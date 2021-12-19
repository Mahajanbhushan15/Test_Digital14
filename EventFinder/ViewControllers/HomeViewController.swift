import UIKit
import Foundation

final class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    private var searchTask: DispatchWorkItem?
    private let searchController = UISearchController(searchResultsController: nil)
    private var errorString = "Swipe Down To Search Events" {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    private var currentSerachText = ""
    private var dataSource = EventMetadata() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private weak var viewModel : HomeViewModel? {
        return HomeViewModel(cloudManager: CloudManagerImpl())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override public var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func callAPI(with searchText: String) {
        loader.isHidden = false
        loader.startAnimating()
        currentSerachText = searchText
        viewModel?.callSearchAPI(text: searchText, completion: { [weak self] result in
            DispatchQueue.main.async {
                self?.loader.stopAnimating()
            }
            switch result {
            case .success(let data) :
                if data.events?.count == 0 {
                    self?.errorString = "Unable to find serach result for \(searchText)"
                }
                self?.dataSource = data
            case .failure(let error) :
                self?.errorString = "error while getting api resposne: \(error.description)"
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailsViewController = segue.destination as? EventDetailsUIViewController {
            detailsViewController.detailsViewModel.event = sender as? Event
        }
    }
}

// Mark - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let events = dataSource.events {
      return events.isEmpty ? 1 : events.count
    }
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if var events = dataSource.events, events.count != 0 {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.ClassName) as? HomeTableViewCell else {
        return UITableViewCell()
      }
      
//        if let favoriteEvents = viewModel?.fetchFavoriteEventFromLocalStorage() {
//
//            if favoriteEvents.filter({ $0.eventId }).count > 0 {
//               // events.is
//            }
//
//        }
        
      cell.configureUI(event: events[indexPath.row])
      return cell
    }
    guard let cell = tableView.dequeueReusableCell(withIdentifier: NoDataTableViewCell.ClassName) as? NoDataTableViewCell else {
      return UITableViewCell()
    }
    cell.errorString.text = errorString
    return cell
  }
}

// Mark - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedEvent = dataSource.events?[indexPath.row] else { return }
        performSegue(withIdentifier: EventDetailsUIViewController.ClassName, sender: selectedEvent)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
}


extension HomeViewController: UISearchResultsUpdating, UISearchControllerDelegate {
  func updateSearchResults(for searchController: UISearchController) {
    guard let text = searchController.searchBar.text, !text.isEmpty, currentSerachText != text else {
      return
    }
    searchTask?.cancel()
    // Replace previous task with a new one
    let task = DispatchWorkItem { [weak self] in
      debugPrint(">> calling api for search text >> \(text)")
      self?.callAPI(with: text)
    }
    searchTask = task

    // Debounce - Execute task in 0.5 seconds (if not cancelled !)
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(500), execute: task)
  }
}


// Handle all UI related stuff here
extension HomeViewController {
  func setupUI() {
    navigationItem.searchController = searchController
    navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationController!.navigationBar.shadowImage = UIImage()
    
    searchController.searchResultsUpdater = self
    searchController.delegate = self
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = "Search Events"
    searchController.hidesNavigationBarDuringPresentation = true
    searchController.searchBar.tintColor = .white
    searchController.searchBar.barTintColor = .white
    searchController.searchBar.searchTextField.textColor = .white
    
    if let textfield = searchController.searchBar.value(forKey: "searchField") as? UITextField {
      textfield.textColor = .systemPink
        if let backgroundview = textfield.subviews.first {
          backgroundview.backgroundColor = UIColor.white
          backgroundview.layer.cornerRadius = 10
          backgroundview.clipsToBounds = true
        }
    }
    UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes =
      [NSAttributedString.Key.foregroundColor: UIColor.white]

    searchController.searchBar.searchTextField.tintColor = .white
    searchController.searchBar.searchTextField.leftView?.tintColor = .white
    searchController.searchBar.searchTextField.rightView?.tintColor = .white
    searchController.searchBar.searchTextField.textColor = .white

    
    tableView.tableFooterView = UIView()
    tableView.reloadData()
    searchController.loadViewIfNeeded()
    
    let titleLabel = UILabel()
    titleLabel.backgroundColor = .clear
    titleLabel.numberOfLines = 2
    titleLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
    titleLabel.textAlignment = .center
    titleLabel.textColor = .white
    titleLabel.text = "Events"
    navigationItem.titleView = titleLabel
    
    loader.isHidden = true
    loader.hidesWhenStopped = true
    registerForKeyboardNotifications()
  }
  
  private func registerForKeyboardNotifications() {
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(with:)), name: UIResponder.keyboardDidShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(with:)), name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  @objc func keyboardDidShow(with notification: Notification) {
    if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
      tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height + 10, right: 0)
      UIView.animate(withDuration: 0.25) {
        self.tableView.layoutIfNeeded()
        self.view.layoutIfNeeded()
      }
    }
  }

  @objc func keyboardWillHide(with notification: Notification) {

    self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    UIView.animate(withDuration: 0.5) {
      self.tableView.layoutIfNeeded()
      self.view.layoutIfNeeded()
    }
  }
}


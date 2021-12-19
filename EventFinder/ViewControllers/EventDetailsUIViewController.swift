import Foundation
import UIKit

final class EventDetailsUIViewController: UIViewController {
    
    @IBOutlet weak var eventImage: CustomImageView!
    @IBOutlet weak var venue: UILabel!
    @IBOutlet weak var dateTime: UILabel!
    
    let detailsViewModel = EventDetailsViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
    }
    
    override public var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .black
        eventImage.image = nil
        if let dateString = detailsViewModel.event.datetimeUTC {
            dateTime.text = dateString.convertDateFormat()
        }
        venue.text = detailsViewModel.event.venue?.displayLocation
        eventImage.layer.cornerRadius = 10
        guard let imageString = detailsViewModel.event.performers?.first?.image else { return }
        eventImage.downloadImageFrom(urlString: imageString)
    }
    
    private func setupUI() {
        let label = UILabel()
        label.backgroundColor = .clear
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        label.textAlignment = .left
        label.textColor = .black
        label.text = detailsViewModel.event.title
        self.navigationItem.titleView = label
    }
}

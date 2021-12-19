import UIKit

class HomeTableViewCell: UITableViewCell {

  @IBOutlet weak var eventImage: CustomImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var subTitleLabel: UILabel!
  @IBOutlet weak var dateTimeLabel: UILabel!
  @IBOutlet weak var favourite: UIButton!
  
  func configureUI(event: Event) {
    titleLabel.text = event.title
    subTitleLabel.text = event.venue?.displayLocation
    if let dateString = event.datetimeUTC {
      dateTimeLabel.text = dateString.convertDateFormat()
    }
    guard let imageString = event.performers?.first?.image else { return }
    eventImage.downloadImageFrom(urlString: imageString)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    imageView?.image = nil
    imageView?.backgroundColor = .gray
    eventImage.layer.cornerRadius = 5.0
    eventImage.layer.masksToBounds = true
    favourite.isHidden = true
  }
}

class NoDataTableViewCell: UITableViewCell {

  @IBOutlet weak var errorString: UILabel!

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }  
}

import UIKit

class ServiceCell: UITableViewCell {

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var placeLabel: UILabel!
  @IBOutlet weak var viewContainer: UIView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    viewContainer.layer.cornerRadius = 8
    viewContainer.clipsToBounds = true
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }

  func setCell(title: String?, state: OfferState?, name: String?, date: String?, address: String?) {
    titleLabel.text = title
    nameLabel.text = name
    dateLabel.text = date
    placeLabel.text = address

    switch state {
    case .read?:
      titleLabel.textColor = UIColor.black
    case .unread?:
      titleLabel.textColor = UIColor.lightGray
    case .none:
      titleLabel.textColor = UIColor.black
    }
  }
}

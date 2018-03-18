import UIKit

class OffersViewController: UITableViewController, OffersPresenterProtocol {

  var offerList: OfferList? {
    didSet {
      tableView.reloadData()
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    let endPoint = EndPoint(baseURL: UserInfo.offersLink(), requestMethod: RequestMethod(name: .get))
    let interactor = Interactor(endPoint: endPoint)
    OffersPresenter(interactor: interactor, presenter: self).present()
    tableView.register(ServiceCell.nib, forCellReuseIdentifier: ServiceCell.identifier)
    title = "Ofertas"
  }

  func showError(error: APIError) {
    //missing
  }

  func loadTable(with model: OfferList) {
    offerList = model
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let rows = offerList?.offers.count else { return 0 }
    return rows
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: ServiceCell.identifier, for: indexPath) as! ServiceCell
    let offer = offerList?.offerAt(index: indexPath.row)
    cell.setCell(title: offer?.title, state: offer?.state, name: offer?.name, date: offer?.date, address: offer?.address)
    return cell
 }
}

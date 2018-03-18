import Foundation

protocol OffersPresenterProtocol {
  func loadTable(with model: OfferList)
  func showError(error: APIError)
}

struct OffersPresenter: PresenterProtocol {

  typealias presenterModel = OfferList

  var interactor: InteractorProtocol?
  var presenter: OffersPresenterProtocol

  func onSuccess(model: OfferList) {
    presenter.loadTable(with: model)
  }

  func onFail(error: APIError) {
    presenter.showError(error: error)
  }
}

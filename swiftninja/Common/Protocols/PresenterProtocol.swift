import Foundation

protocol PresenterProtocol {
  associatedtype presenterModel: Decodable

  var interactor: InteractorProtocol? { get set }
  func onSuccess(model: presenterModel)
  func onFail(error: APIError)
  func present()
}

extension PresenterProtocol {
  func present() {
    interactor?.fetch(decodingType: presenterModel.self) { (result) in
      switch result {
      case .success(let model):
        self.onSuccess(model: model)
      case .failure(let error):
        self.onFail(error: error)
      }
    }
  }
}

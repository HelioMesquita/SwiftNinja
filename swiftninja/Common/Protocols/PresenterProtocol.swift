import Foundation

protocol PresenterProtocol: InteractorProtocol {
  associatedtype presenterModel: Decodable

  func onSuccess(model: presenterModel)
  func onFail(error: APIError)
  func present()
}

extension PresenterProtocol {
  func present() {
    fetch(decodingType: presenterModel.self) { (result) in
      switch result {
      case .success(let model):
        self.onSuccess(model: model)
      case .failure(let error):
        self.onFail(error: error)
      }
    }
  }
}

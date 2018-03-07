import Foundation

protocol SignInPresenterProtocol {
  func performSignIn()
  func showError(error: APIError)
}

struct SignInPresenter: PresenterProtocol {

  typealias presenterModel = SignInModel
  var request: RequestProtocol
  var presenter: SignInPresenterProtocol

  func onSuccess(model: SignInModel) {
    self.userInfo(model)
    self.presenter.performSignIn()
  }

  func onFail(error: APIError) {
    self.presenter.showError(error: error)
  }

  private func userInfo(_ signInModel: SignInModel) {
    let links = signInModel._links
    UserInfo.initialize(offers: links.offers, leads: links.leads)
  }
}

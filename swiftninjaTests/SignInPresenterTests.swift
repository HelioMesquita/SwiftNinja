import Quick
import Nimble
import Mockingjay

@testable import swiftninja

class SignInPresenterTests: QuickSpec {

  override func spec() {

    let object = """
    {
      "_links" : {
        "leads" : {
          "href" : "http://testemobile.getninjas.com.br/leads"
        },
        "offers" : {
          "href" : "http://testemobile.getninjas.com.br/offers"
        }
      }
    }
    """

    struct dummySignInPresenter: SignInPresenterProtocol {
      func performSignIn() {}
      func showError(error: APIError) {}
    }

    describe("NetworkRequest") {

      context("get") {
        it("should a signInModel from json") {
          let interactor = SingleRequestInteractor(endPoint: SignInEndPoint())
          let presenter = SignInPresenter(presenter: dummySignInPresenter(), interactor: interactor)

          self.stub(everything, json(object))

          presenter.present()

          expect(UserInfo.leadsLink().href).to(equal("http://testemobile.getninjas.com.br/leads"))
        }
      }
    }
  }
}


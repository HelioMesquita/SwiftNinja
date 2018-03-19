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

    describe("sign in presenter") {

      context("get") {
        it("should return a signInModel from json") {
          let endPoint = EndPoint(baseURL: "www.google.com", requestMethod: RequestMethod(name: .get))
          let interactor = Interactor(endPoint: endPoint)
          let presenter = SignInPresenter(presenter: dummySignInPresenter(), interactor: interactor)

          self.stub(everything, jsonData(object.data(using: .utf8)!))

          presenter.present()

          expect(UserInfo.leadsLink()).toEventually(equal("http://testemobile.getninjas.com.br/leads"))
        }
      }
    }
  }
}


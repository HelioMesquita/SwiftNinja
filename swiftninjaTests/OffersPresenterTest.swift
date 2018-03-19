import Quick
import Foundation
import Nimble
import Mockingjay

@testable import swiftninja

class OffersPresenterTests: QuickSpec {

  override func spec() {

    let object = """
    {
      "offers":[
        {
          "state":"read",
          "_embedded":{
            "request":{
              "created_at":"2016-03-04T14:47:05.000+00:00",
              "title":"Buffet Completo",
              "_embedded":{
                "user":{
                  "name":"Eduardo L'Hotellier"
                },
                "address":{
                  "city":"São Paulo",
                  "neighborhood":"Vila Leopoldina",
                  "uf":"SP"
                }
              }
            }
          },
          "_links":{
            "self":{
              "href":"https://testemobile.getninjas.com.br/offer-1"
            }
          }
        }
      ],
      "_links":{
          "self":{
            "href":"https://testemobile.getninjas.com.br/offers"
          }
      }
    }
    """

    class DummyOffersPresenter: OffersPresenterProtocol {
      var subject: OfferList?

      func loadTable(with model: OfferList) {
        self.subject = model
      }
      func showError(error: APIError) {}
    }

    describe("offers presenter") {

      context("get") {
        it("should return a offerList from json") {
          let endPoint = EndPoint(baseURL: "www.google.com", requestMethod: RequestMethod(name: .get))
          let interactor = Interactor(endPoint: endPoint)
          let dummyPresenter = DummyOffersPresenter()
          let presenter = OffersPresenter(interactor: interactor, presenter: dummyPresenter)

          self.stub(everything, jsonData(object.data(using: .utf8)!))

          presenter.present()

          expect(dummyPresenter.subject?.offers.count).toEventually(equal(1))
          expect(dummyPresenter.subject?.offers.first?.state.rawValue).toEventually(equal("read"))
          expect(dummyPresenter.subject?.offers.first?.embedded.request.title).toEventually(equal("Buffet Completo"))
        }
      }
    }
  }
}

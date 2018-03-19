import Quick
import Nimble
import Mockingjay

@testable import swiftninja

class OffersPresenterTests: QuickSpec {

  override func spec() {

    let object: AnyObject = """
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
    """ as AnyObject

    class DummyOffersPresenter: OffersPresenterProtocol {
      var model: OfferList!

      func loadTable(with model: OfferList) {
        self.model = model
      }
      func showError(error: APIError) {}
    }

    describe("offers presenter") {

      context("get") {
        it("should return a offerList from json") {
          let endPoint = EndPoint(baseURL: "www.google.com", requestMethod: RequestMethod(name: .get))
          let interactor = Interactor(endPoint: endPoint)
          let dummyPresenter = DummyOffersPresenter()
          OffersPresenter(interactor: interactor, presenter: dummyPresenter).present()
          self.stub(everything, json(object))
          let subject = dummyPresenter.model

          expect(subject?.offers.count).toEventually(equal(1))
//          expect(subject?.offers.first?.state.rawValue).toEventually(equal("read"))
//          expect(subject?.offers.first?.embedded.request.title).toEventually(equal("Buffet Completo"))
        }
      }
    }
  }
}

import Quick
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

    struct dummyOffersPresenter: OffersPresenterProtocol {
      func loadTable(with model: OfferList) {}
      func showError(error: APIError) {}
    }

    describe("offers presenter") {

      context("get") {
        it("should return a offerList from json") {
          let endPoint = EndPoint(baseURL: "www.google.com", requestMethod: RequestMethod(name: .get))
          let interactor = Interactor(endPoint: endPoint)
          let presenter = OffersPresenter(interactor: interactor, presenter: dummyOffersPresenter())

          self.stub(everything, json(object))

          presenter.present()

          expect(UserInfo.leadsLink()).to(equal("http://testemobile.getninjas.com.br/leads"))
        }
      }
    }
  }
}



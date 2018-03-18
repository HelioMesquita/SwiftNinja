import Quick
import Nimble
import Mockingjay

@testable import swiftninja

class InteractorTests: QuickSpec {

  override func spec() {

    let object =
    [
      "title": "title from mock json",
      "message": "message from mock json"
    ]

    struct DummyInteractor: InteractorProtocol {
      var endPoint: EndPointProtocol
    }

    struct DummyEndPoint: EndPointProtocol {
      var baseURL: String = "www.google.com.br"
      var requestMethod: RequestMethod = RequestMethod(name: .get)
    }

    struct ModelDecodable: Decodable {
      var title: String
      var message: String
    }

    describe("interactor default behavior") {

      var networkService: InteractorProtocol!

      beforeEach {
        networkService = DummyInteractor(endPoint: DummyEndPoint())
      }

      context(".request") {
        it("should make a request and return some data") {

          self.stub(everything, json(object))
          var modelResponse: ModelDecodable? = nil

          networkService.request(onSuccess: { data in
            modelResponse = try! JSONDecoder().decode(ModelDecodable.self, from: data!)
          }, onFail: { _ in })

          expect(modelResponse?.title).toEventually(equal("title from mock json"))
          expect(modelResponse?.message).toEventually(equal("message from mock json"))
        }
      }

      context(".fetch") {
        it("should make a request and return a model") {

          self.stub(everything, json(object))
          var modelResponse: ModelDecodable? = nil

          networkService.fetch(decodingType: ModelDecodable.self, completion: { result in
            switch result {
            case .success(let model):
              modelResponse = model
            case .failure( _):
              fail()
            }
          })

          expect(modelResponse?.title).toEventually(equal("title from mock json"))
          expect(modelResponse?.message).toEventually(equal("message from mock json"))
        }
      }
    }
  }
}


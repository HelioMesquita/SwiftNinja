import Foundation
import XCTest
import Alamofire

@testable import swiftninja


struct StubRequest: RequestProtocol {
  var requestMethod: RequestMethod = RequestMethod(name: .get)
  var baseURL: String = ""
}

struct StubNetwork: NetworkProtocol {
  var request: RequestProtocol

  var requestSuccess: Bool = true
  private let json = "{ \"_links\" : { \"leads\" : { \"href\" : \"http://testemobile.getninjas.com.br/leads\" }, \"offers\" : { \"href\" : \"http://testemobile.getninjas.com.br/offers\" } } }"

  func request(onSuccess: @escaping (Data?) -> (), onFail: @escaping (NSError) -> Void) {
    if requestSuccess {
      let data = json.data(using: .utf8)
      onSuccess(data)
    } else {
      onFail(NSError(domain: "Request Error", code: 0, userInfo: nil))
    }
  }
}

class SignInInteractorTests: XCTestCase {

  var subject: SignInInteractor!
  var stubNetwork: StubNetwork!

  override func setUp() {
    super.setUp()
    self.stubNetwork = StubNetwork(request: StubRequest(), requestSuccess: true)
    self.subject = SignInInteractor(network: stubNetwork)
  }

  func testSuccessFetch() {
    subject.fetch(onSuccess: { (anyObject) in
      XCTAssertEqual(UserInfo.leadsLink().href, "http://testemobile.getninjas.com.br/leads")
      XCTAssertEqual(UserInfo.offersLink().href, "http://testemobile.getninjas.com.br/offers")
    }, onFail: { error in
      XCTFail("stub request error")
    })
  }

  func testFailFetch() {
    let stubNetworkFalse = StubNetwork(request: StubRequest(), requestSuccess: false)
    self.subject = SignInInteractor(network: stubNetworkFalse)
    subject.fetch(onSuccess: { data in
      XCTFail("stub request error")
    }, onFail: { error in
      XCTAssertEqual(error.domain, "Request Error")
    })
  }
}

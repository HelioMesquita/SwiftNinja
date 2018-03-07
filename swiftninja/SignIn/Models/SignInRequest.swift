import Foundation

struct SignInRequest: RequestProtocol {
  var baseURL: String = Bundle.main.getBaseUrl()
  var requestMethod: RequestMethod = RequestMethod(name: .get)
}

import Foundation

struct SignInEndPoint: EndPointProtocol {
  var baseURL: String = Bundle.main.getBaseUrl()
  var requestMethod: RequestMethod = RequestMethod(name: .get)
}

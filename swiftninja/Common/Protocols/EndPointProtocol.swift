import Alamofire

protocol EndPointProtocol {
  var baseURL: String { get }
  var requestMethod: RequestMethod { get }
}

struct RequestMethod {
  let name: HTTPMethod
}

import Foundation
import Alamofire

protocol InteractorProtocol {
  var request: RequestProtocol { get }
  func fetch<T: Decodable>(decodingType: T.Type, completion: @escaping (Result<T>) -> Void)
  func request(onSuccess: @escaping (Data?) -> (), onFail: @escaping (APIError) -> Void)
}

extension InteractorProtocol {
  func fetch<T>(decodingType: T.Type, completion: @escaping (Result<T>) -> Void) where T: Decodable {
    request(onSuccess: { data in
      if let data = data {
        do {
          let model = try JSONDecoder().decode(decodingType.self, from: data)
          completion(Result.success(model))
        } catch {
          completion(Result.failure(.jsonParsingFailure))
        }
      }
      completion(Result.failure(.jsonConversionFailure))
    }, onFail: { error in
      completion(Result.failure(.responseUnsuccessful))
    })
  }

  func request(onSuccess: @escaping (Data?) -> (), onFail: @escaping (APIError) -> Void) {
    Alamofire.request(request.baseURL, method: request.requestMethod.name).responseJSON { response in
      if response.result.isSuccess {
        onSuccess(response.data)
      } else {
        onFail(APIError.requestFailed)
      }
    }
  }
}

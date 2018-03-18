import Foundation
import Alamofire

protocol InteractorProtocol {
  var endPoint: EndPointProtocol { get }
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
      } else {
        completion(Result.failure(.jsonConversionFailure))
      }
    }, onFail: { error in
      completion(Result.failure(.responseUnsuccessful))
    })
  }

  func request(onSuccess: @escaping (Data?) -> (), onFail: @escaping (APIError) -> Void) {
    Alamofire.request(endPoint.baseURL, method: endPoint.requestMethod.name).responseJSON { response in


//      WIP
//      if let statusCode = response.response?.statusCode {
//        switch statusCode {
//        case 200...399:
//          print("sucesso")
//        case 400...499:
//          print("falha")
//        case 500:
//          print("servidor fora")
//        default:
//          print("error desconhecido")
//        }
//      }

      if response.result.isSuccess {
        print(response.result.value)
        onSuccess(response.data)
      } else {
        onFail(APIError.requestFailed)
      }
    }
  }
}

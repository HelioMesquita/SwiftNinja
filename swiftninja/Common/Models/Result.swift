import Foundation

enum Result<T>  {
  case success(T)
  case failure(APIError )
}

import Foundation

extension Bundle {

  func getBaseUrl() -> String {
    return self.object(forInfoDictionaryKey: "BaseUrl") as! String
  }
}

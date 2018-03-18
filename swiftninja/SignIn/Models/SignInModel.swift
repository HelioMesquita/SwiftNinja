import Foundation

struct SignInModel: Decodable {
  let _links: SignInLinks

  struct SignInLinks: Decodable {
    let leads: Link
    let offers: Link
  }
}

class UserInfo {

  private var offers: SignInLink = SignInLink(href: "")
  private var leads: SignInLink = SignInLink(href: "")

  private static let instance = UserInfo()

  static func initialize(offers: SignInLink, leads: SignInLink) {
    instance.offers = offers
    instance.leads = leads
  }

  static func offersLink() -> SignInLink {
    return instance.offers
  }

  static func leadsLink() -> SignInLink {
    return instance.leads
  }
}

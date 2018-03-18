class UserInfo {

  private var offers: String = ""
  private var leads: String = ""

  private static let instance = UserInfo()

  static func initialize(offers: SignInLink, leads: SignInLink) {
    instance.offers = offers.href
    instance.leads = leads.href
  }

  static func offersLink() -> String {
    return instance.offers
  }

  static func leadsLink() -> String {
    return instance.leads
  }
}

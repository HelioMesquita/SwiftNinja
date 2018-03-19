import Quick
import Nimble
import Mockingjay

@testable import swiftninja

class UserInfoTest: QuickSpec {
  override func spec() {

    context("links") {
      let offerLink = Link(href: "www.offer.com.br")
      let leadsLink = Link(href: "www.lead.com.br")

      beforeEach {
        UserInfo.initialize(offers: offerLink, leads: leadsLink)
      }

      it("return lead link after init userinfo") {
        expect(UserInfo.leadsLink()).to(equal(leadsLink.href))
      }
      it("return offer link after init userinfo") {
        expect(UserInfo.offersLink()).to(equal(offerLink.href))
      }
    }
  }
}

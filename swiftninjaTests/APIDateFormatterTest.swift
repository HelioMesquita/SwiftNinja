import Quick
import Nimble
import Mockingjay

@testable import swiftninja

class APIDateFormatterTest: QuickSpec {
  override func spec() {

    context("default number formatter") {
      it("return day and month") {

        let value = "2016-03-04T14:47:05.000+00:00"

        let date = APIDateFormatter.defaultNumberFormatter(value: value)

        expect(date).to(equal("04 MAR"))
      }
    }
  }
}

import UIKit

class NavigationController: UINavigationController {

  override func viewDidLoad() {
    super.viewDidLoad()
    navigationBar.isTranslucent = false
    navigationBar.barTintColor = #colorLiteral(red: 0.07100000232, green: 0.5749999881, blue: 0.9660000205, alpha: 1)
    navigationBar.tintColor = UIColor.white
    navigationBar.titleTextAttributes = [
      NSAttributedStringKey.foregroundColor: UIColor.white,
      NSAttributedStringKey.font: UIFont(name: "Helvetica-Bold", size: 18)!
    ]
  }
}

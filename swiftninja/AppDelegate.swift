import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, SignInPresenterProtocol {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    let interactor = SingleRequestInteractor(endPoint: SignInEndPoint())
    SignInPresenter(presenter: self, interactor: interactor).present()
    return true
  }

  func performSignIn() {
    window = UIWindow(frame: UIScreen.main.bounds)

    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let viewController = storyboard.instantiateViewController(withIdentifier: "tabBarController")

    window?.rootViewController = viewController
    window?.makeKeyAndVisible()
  }

  func showError(error: APIError) {
    //missing
  }

  func applicationWillResignActive(_ application: UIApplication) {}

  func applicationDidEnterBackground(_ application: UIApplication) {}

  func applicationWillEnterForeground(_ application: UIApplication) {}

  func applicationDidBecomeActive(_ application: UIApplication) {}

  func applicationWillTerminate(_ application: UIApplication) {}
}



import Foundation
import UIKit

class BaseNavigationController: UINavigationController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.isTranslucent = false
        self.navigationBar.tintColor = ColorPreference.secondaryColor
        self.navigationBar.barTintColor = ColorPreference.tertiaryColor
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: ColorPreference.secondaryColor]
    }
}

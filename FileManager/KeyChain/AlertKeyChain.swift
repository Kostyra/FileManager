

import Foundation
import UIKit

extension UIViewController {
    func alertPass(text: String) {
        let alertPass = UIAlertController(title: "Title", message: text, preferredStyle: .alert)
        alertPass.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alertPass, animated: true)
    }
}

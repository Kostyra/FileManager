import Foundation
import UIKit

class ChangePass: UIViewController {
    var keyChain = KeychainService.keychainDefaultService
    
    private lazy var textFildPass: UITextField = {
        let text = UITextField()
        text.backgroundColor = .gray
        text.layer.cornerRadius = 10
        text.borderStyle = UITextField.BorderStyle.roundedRect
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private lazy var buttonLogIn: CustomButton = {
        let button = CustomButton(titleColor: .white,
                                  backgroundColor: .systemBlue ,
                                  action: buttonActionChange)
        button.setTitle("Change Password", for: .normal)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
    }
    
    func setupView() {
        view.addSubview(textFildPass)
        view.addSubview(buttonLogIn)
        
        NSLayoutConstraint.activate([
            
            textFildPass.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant:-20),
            textFildPass.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textFildPass.heightAnchor.constraint(equalToConstant: 40),
            textFildPass.widthAnchor.constraint(equalToConstant: 200),
            
            buttonLogIn.topAnchor.constraint(equalTo: textFildPass.bottomAnchor, constant:10),
            buttonLogIn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonLogIn.heightAnchor.constraint(equalToConstant: 40),
            buttonLogIn.widthAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    @objc func buttonActionChange() {
        keyChain.removeAll()
        keyChain.saveData(name: textFildPass.text!)
    }
}


import Foundation
import UIKit

class LoginViewController:UIViewController {
    
    var statePass = StatePass.signIn
    var keyChain = KeychainService.keychainDefaultService
    var pass: String = ""
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
                                  action: buttonActionEnter)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        statesPass()
        buttonStatePass()
        view.backgroundColor = .white
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
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
    
    @objc func buttonActionEnter() {
        switch statePass {
        case .signIn:
            print("signIn")
            guard let passData = keyChain.getData() else { return }
            if textFildPass.text == passData {
                let tabBarVC = TabBarViewController()
                navigationController?.pushViewController(tabBarVC, animated: true)
            } else {
                alertPass(text: "Неверный пароль")
            }
        case .signUp:
            print("signUp")
            guard textFildPass.text!.count >= 4, !textFildPass.text!.isEmpty else {
                alertPass(text: "Пароль должен содержать минимум 4 символа")
                textFildPass.text = ""
                return
            }
            if pass == "" {
                pass = textFildPass.text!
                textFildPass.text! = ""
                alertPass(text: "Повторите пароль")
            } else {
                if textFildPass.text! == pass {
                    keyChain.saveData(name: textFildPass.text!)
                    print(textFildPass.text!)
                    let tabBarVC = TabBarViewController()
                    navigationController?.pushViewController(tabBarVC, animated: true)
                } else {
                    alertPass(text: "Пароли не совпадают")
                    textFildPass.text! = ""
                }

            }
            
        case .passEdit:
            buttonLogIn.setTitle("Изменить пароль", for: .normal)
            print("passedit")
            guard textFildPass.text!.count >= 4, !textFildPass.text!.isEmpty else {
                alertPass(text: "Пароль должен состоять минимум из четырёх символов")
                textFildPass.text = ""
                return
            }
            keyChain.saveData(name: textFildPass.text!)
            alertPass(text: "Пароль изменен на \(textFildPass.text!)")
        }
    }
    
    private func showNextScreen() {
        let tabBarViewController = TabBarViewController()
        navigationController?.pushViewController(tabBarViewController, animated: true)
    }
    
    func statesPass() {
        if (keyChain.getData() != nil) {
             statePass = .signIn
        } else {
            statePass = .signUp
        }
    }
    
    func buttonStatePass() {
        switch statePass {
        case .signIn:
            buttonLogIn.setTitle("Log In", for: .normal)
        case .signUp:
            buttonLogIn.setTitle("Log Up", for: .normal)
        case .passEdit:
            buttonLogIn.setTitle("Change pass", for: .normal)
        }
    }
}

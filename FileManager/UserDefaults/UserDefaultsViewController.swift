//
//  UserDefaultsViewController.swift
//  FileManager
//
//  Created by Юлия Филиппова on 11.07.2023.
//

import UIKit

final class UserDefaultsViewController: UIViewController {
    
    var keyChein = KeychainService.keychainDefaultService
    var fileManager = FileManagerService()
    weak var delegate: TableViewControllerDelegate?

    
    private lazy var buttonLogOut: CustomButton = {
        let button = CustomButton(titleColor: .white,
                                  backgroundColor: .systemBlue ,
                                  action: buttonDeletePass
        )
        button.setTitle("Log Out", for: .normal)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var buttonChangePass: CustomButton = {
        let button = CustomButton(titleColor: .white,
                                  backgroundColor: .systemBlue ,
                                  action: buttonActionChangePass
        )
        button.setTitle("Change pass", for: .normal)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var switchSort:UISegmentedControl = {
        let sort = UISegmentedControl(items: ["A-Z","Z-A"])
        sort.translatesAutoresizingMaskIntoConstraints = false
        sort.selectedSegmentIndex = 0
        sort.addTarget(self, action: #selector(switchActionSort(_:)), for: .valueChanged)
        return sort
    }()
    
    private lazy var textLableSwith:UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.text = "Sort"
        text.textColor = .black
        return text
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "User Defaults"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        setup()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let sortValue = UserDefaults.standard.bool(forKey: "sort")
        if sortValue {
            switchSort.selectedSegmentIndex = 0
            print(1)
        } else {
            switchSort.selectedSegmentIndex = 1
            print(2)
        }
        
    }

    @objc func buttonDeletePass() {
        keyChein.removeAll()
    }
    
    @objc func buttonActionChangePass() {
    let changePassVC = LoginViewController()
        changePassVC.modalPresentationStyle = .pageSheet
        changePassVC.modalTransitionStyle = .crossDissolve
        present(changePassVC, animated: true)
        changePassVC.statePass = .passEdit
        changePassVC.buttonStatePass()
    }
    
    @objc private func switchActionSort(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            UserDefaults.standard.set(true, forKey: "sort")
            let sortValue = UserDefaults.standard.bool(forKey: "sort")
            print(sortValue)
            let sort = fileManager.item.sorted(by: <)
            fileManager.item = sort
            delegate?.reload()

        case 1:
            UserDefaults.standard.set(false, forKey: "sort")
            let sortValue = UserDefaults.standard.bool(forKey: "sort")
            print(sortValue)
            let sort = fileManager.item.sorted(by: >)
            fileManager.item = sort
            delegate?.reload()
        default:
            break
        }
    }
    
    func setup() {
        view.addSubview(buttonLogOut)
        view.addSubview(buttonChangePass)
        view.addSubview(switchSort)
        view.addSubview(textLableSwith)
        NSLayoutConstraint.activate([
            buttonLogOut.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            buttonLogOut.heightAnchor.constraint(equalToConstant: 30),
            buttonLogOut.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            buttonLogOut.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            buttonChangePass.topAnchor.constraint(equalTo: buttonLogOut.bottomAnchor, constant: 10),
            buttonChangePass.heightAnchor.constraint(equalToConstant: 30),
            buttonChangePass.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            buttonChangePass.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            textLableSwith.topAnchor.constraint(equalTo: buttonChangePass.bottomAnchor, constant: 10),
            textLableSwith.heightAnchor.constraint(equalToConstant: 30),
            textLableSwith.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            switchSort.topAnchor.constraint(equalTo: buttonChangePass.bottomAnchor, constant: 10),
            switchSort.heightAnchor.constraint(equalToConstant: 30),
            switchSort.leadingAnchor.constraint(equalTo: textLableSwith.trailingAnchor, constant: 16),
        
            
            
        ])
    }
}

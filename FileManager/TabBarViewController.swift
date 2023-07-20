//
//  TabBarViewController.swift
//  FileManager
//
//  Created by Юлия Филиппова on 11.07.2023.
//

import UIKit

class TabBarViewController: UITabBarController {
 
    let imageFolder = UIImage(systemName: "folder.badge.plus")
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTabs()
    }

    private func setupTabs() {
        let tableVC = TableViewController()
        let tableNC = UINavigationController(rootViewController: tableVC)
        tableNC.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "folder"), tag: 0)

        let userDefaultsVC = UserDefaultsViewController()
        let userDefaultsNC = UINavigationController(rootViewController: userDefaultsVC)
        userDefaultsNC.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "person.badge.key"), tag: 1)
        
        viewControllers = [tableNC,userDefaultsNC]
    }
    

    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.setNavigationBarHidden(true, animated: animated)
//    }
    
}

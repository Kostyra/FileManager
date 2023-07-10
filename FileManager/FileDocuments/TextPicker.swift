//
//  TextPicker.swift
//  FileManager
//
//  Created by Юлия Филиппова on 09.07.2023.
//

import Foundation
import UIKit

final class TextPicker {
    static var defaultPicker = TextPicker()
    func showNewNameFolder(in viewConroller: UITableViewController, complition: @escaping(String) ->()) {
        let alert = UIAlertController(title: "Name new folder", message: nil, preferredStyle: .alert)
        alert.addTextField()
        
        let okAction = UIAlertAction(title: "Ok", style: .default) {_ in
            if let text1 = alert.textFields?[0].text  {
                complition(text1)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        viewConroller.present(alert, animated: true)
    }
    
    
   private init() {}
}

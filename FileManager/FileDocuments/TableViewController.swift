//
//  TableViewController.swift
//  FileManager
//
//  Created by Юлия Филиппова on 08.07.2023.
//

import UIKit

protocol TableViewControllerDelegate: AnyObject {
    func reload()
}

class TableViewController: UITableViewController {
    
    let imageFolder = UIImage(systemName: "folder.badge.plus")
    let imagePhoto = UIImage(systemName: "photo")
    let imageBack = UIImage(systemName: "arrowshape.turn.up.backward")
    var folderManager = FileManagerService()
    var directories: [String]?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
//        let buttonBack = UIBarButtonItem(image: imageBack, style: .plain, target: self, action: #selector(buttonActionBack))
//        navigationItem.leftBarButtonItem = buttonBack
        let buttonDocuments = UIBarButtonItem(image: imageFolder, style: .plain, target: self, action: #selector(buttonAddDocument))
        let buttonImage = UIBarButtonItem(image: imagePhoto, style: .plain, target: self, action: #selector(buttonAddPhoto))
        navigationItem.rightBarButtonItems = [buttonImage, buttonDocuments]
        
        
        folderManager.titleManagerService{ title in self.title = title }
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    @objc func buttonAddDocument() {
        TextPicker.defaultPicker.showNewNameFolder(in: self) { nameFolder in
            self.folderManager.createDirectory(name: "\(nameFolder)")
            self.tableView.reloadData()
        }
    }
    
    @objc func buttonAddPhoto () {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else { return }
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return folderManager.item.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") ?? UITableViewCell(style: .default, reuseIdentifier: "Cell")
        let item = folderManager.item[indexPath.row]
        cell.textLabel?.text = item
        if folderManager.isDirectory(atIndex: indexPath.row) == true {
            cell.accessoryType = .disclosureIndicator
        } else {
            cell.accessoryType = .none
            cell.selectionStyle = .none
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            folderManager.removeContent(atIndex: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if folderManager.isDirectory(atIndex: indexPath.row) == true {
            TableViewController.show(in: self, withPath: folderManager.getFullIndexPath(atIndex: indexPath.row))
        }
    }
}


extension TableViewController: UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let imageURL = info[.imageURL] as! URL
        let imageName = imageURL.lastPathComponent.first
        let image = info[.originalImage] as! UIImage
        folderManager.createFile(nameFolder: nil, image: image, imageName: String(describing: imageName!))
        directories?.append("Image \(imageName!).jpeg")
        dismiss(animated: true)
        self.tableView.reloadData()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    private func addButtonTappedInTable() {
        TextPicker.defaultPicker.showNewNameFolder(in: self) { nameFolder in
            self.folderManager.createDirectory(name: "\(nameFolder)")
            self.tableView.reloadData()
        }
    }
}

extension TableViewController {
    static func show(in viewController: UIViewController, withPath path: String) {
        let fc = TableViewController()
        fc.folderManager = FileManagerService(pathFolderCurrentFolder: path)
        viewController.navigationController?.pushViewController(fc, animated: true)
    }
}

extension TableViewController: TableViewControllerDelegate {
    func reload() {
        tableView.reloadData()
    }
}

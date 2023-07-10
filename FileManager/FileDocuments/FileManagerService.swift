//
//  FileManagerService.swift
//  FileManager
//
//  Created by Юлия Филиппова on 08.07.2023.
//

import Foundation
import UIKit

protocol FileManagerServiceProtocol {
    func contentsOfDirectory(atPath path: String) -> [String]
    func createDirectory(name: String)
    func createFile(nameFolder: String?, image: UIImage, imageName: String)
    func removeContent(atIndex:Int)
    func titleManagerService(complition:(String) ->())
}


final class FileManagerService: FileManagerServiceProtocol {

    var pathFolderCurrentFolder: String
    
    init() {
        self.pathFolderCurrentFolder = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    }
    
    init(pathFolderCurrentFolder: String) {
        self.pathFolderCurrentFolder = pathFolderCurrentFolder
    }
    
    var item: [String] {
        (try? FileManager.default.contentsOfDirectory(atPath: pathFolderCurrentFolder)) ?? []
    }
    
    func contentsOfDirectory(atPath path: String) -> [String] {
        (try? FileManager.default.contentsOfDirectory(atPath: pathFolderCurrentFolder)) ?? []
    }
    
    func createDirectory(name: String) {
        do {
            try FileManager.default.createDirectory(atPath: pathFolderCurrentFolder + "/" + name, withIntermediateDirectories: true)
            
        } catch {
            print("Failed create Directory\(error)")
        }
    }
    
    func createFile(nameFolder: String?, image: UIImage, imageName: String){
        let urlFile = URL(fileURLWithPath: pathFolderCurrentFolder + "/" + (nameFolder ?? ""))
                let url = urlFile.appendingPathComponent("Image \(String(describing: imageName)).jpeg")
                if let data = image.pngData() {
                    do {
                        try data.write(to: url)
                    } catch {
                        print("Unable to Write  Image Data to Disk")
                    }
                }
    }
    
    func removeContent(atIndex:Int) {
        let path = pathFolderCurrentFolder + "/" + item[atIndex]
        do {
            try FileManager.default.removeItem(atPath: path)
        } catch {
            print("Failed to remove content: \(error)")
        }
        
    }
    
    func isDirectory(atIndex index: Int) -> Bool {
        let name = contentsOfDirectory(atPath: pathFolderCurrentFolder)[index]
        let path = pathFolderCurrentFolder + "/" + name
        var objcBool: ObjCBool = false
        FileManager.default.fileExists(atPath: path, isDirectory: &objcBool)
        return objcBool.boolValue
    }
    
    func titleManagerService(complition:(String) ->()) {
        let title = URL(fileURLWithPath: pathFolderCurrentFolder).lastPathComponent
        complition(title)
    }
    
    func getFullIndexPath(atIndex index: Int) -> String {
        pathFolderCurrentFolder + "/" + item[index]
    }
}


import Foundation
import KeychainAccess

class KeychainService:KeychainServiceProtocol {
    
    static var keychainDefaultService = KeychainService()
    private init() {}
    
    let keychain = Keychain(service: "FileManager")
    func getData() -> String? {
        do {
            if let data = try keychain.get("password") {
                return data
            }
        } catch {
            print("Error data\(error)")
        }
        return nil
    }
    
//    func saveData(name: String) {
//        keychain["password"] = name
//    }
    
    func saveData(name: String) {
        try? keychain.set(name, key: "password")
    }
    
    func updateData(name: String) {
        saveData(name: name)
    }
    
    func remove(for name: String) {
        do {
            try keychain.remove(name)
        } catch {
            print("Error delete\(error)")
        }
    }
    
    func removeAll() {
        do {
            try keychain.removeAll()
        } catch {
            print("Error delete\(error)")
        }
    }
}

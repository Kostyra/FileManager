

import Foundation


import Foundation

protocol KeychainServiceProtocol: AnyObject {
    func getData() -> String?
    func saveData(name: String)
    func updateData(name: String)
    func remove(for name: String)
    func removeAll()
}

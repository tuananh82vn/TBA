
import UIKit

struct LocalStore {

    private static let DebtCode = "DebtCode"
    
    private static let Web_URL_API = "Web_URL_API"

    private static let RCS_URL_API = "RCS_URL_API"
    
    private static let userDefaults = NSUserDefaults.standardUserDefaults()

    
    static func setDebtCode(token: String) {
        userDefaults.setObject(token, forKey: DebtCode)
        userDefaults.synchronize()
    }
    
    private static func deleteDebtCode() {
        userDefaults.removeObjectForKey(DebtCode)
        userDefaults.synchronize()
    }
    
    static func accessDebtCode() -> String? {
        return userDefaults.stringForKey(DebtCode)
    }
    
    //----------------------------------------------------------------------------//
    
    static func setRCS_URL_API(token: String) {
        userDefaults.setObject(token, forKey: RCS_URL_API)
        userDefaults.synchronize()
    }
    
    private static func deleteRCS_URL_API() {
        userDefaults.removeObjectForKey(RCS_URL_API)
        userDefaults.synchronize()
    }
    
    static func accessRCS_URL_API() -> String? {
        return userDefaults.stringForKey(RCS_URL_API)
    }
    
    //----------------------------------------------------------------------------//
    
    static func setWeb_URL_API(token: String) {
        userDefaults.setObject(token, forKey: Web_URL_API)
        userDefaults.synchronize()
    }
    
    private static func deleteWeb_URL_API() {
        userDefaults.removeObjectForKey(Web_URL_API)
        userDefaults.synchronize()
    }
    
    static func accessWeb_URL_API() -> String? {
        return userDefaults.stringForKey(Web_URL_API)
    }
    
    //----------------------------------------------------------------------------//

    


    // MARK: Helper

    static private func arrayForKey(key: String, containsId id: Int) -> Bool {
        let elements = userDefaults.arrayForKey(key) as? [Int] ?? []
        return elements.contains(id)
    }

    static private func appendId(id: Int, toKey key: String) {
        let elements = userDefaults.arrayForKey(key) as? [Int] ?? []
        if !elements.contains(id) {
            userDefaults.setObject(elements + [id], forKey: key)
            userDefaults.synchronize()
        }
    }

    static private func removeId(id: Int, forKey key: String) {
        var elements = userDefaults.arrayForKey(key) as? [Int] ?? []
        if let index = elements.indexOf(id) {
            elements.removeAtIndex(index)
            userDefaults.setObject(elements, forKey: key)
            userDefaults.synchronize()
        }
    }
}

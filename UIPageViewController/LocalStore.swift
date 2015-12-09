
import UIKit

struct LocalStore {

    private static let RefNumber = "RefNumber"
    
    private static let Web_URL_API = "Web_URL_API"

    private static let RCS_URL_API = "RCS_URL_API"
    
    private static let Pin = "Pin"
    
    private static let IsPinSetup = "IsPinSetup"
    
    private static let TotalOutstanding = "TotalOutstanding"
    
    private static let NextPaymentInstallmentAmount = "NextPaymentInstallmentAmount"
    
    
    private static let userDefaults = NSUserDefaults.standardUserDefaults()
    
    
    //----------------------------------------------------------------------------//
    static func setNextPaymentInstallmentAmount(token: String) {
        userDefaults.setObject(token, forKey: NextPaymentInstallmentAmount)
        userDefaults.synchronize()
    }
    
    private static func deleteNextPaymentInstallmentAmount() {
        userDefaults.removeObjectForKey(NextPaymentInstallmentAmount)
        userDefaults.synchronize()
    }
    
    static func accessNextPaymentInstallmentAmount() -> String? {
        return userDefaults.stringForKey(NextPaymentInstallmentAmount)
    }
    
    //----------------------------------------------------------------------------//

    static func setTotalOutstanding(token: String) {
        userDefaults.setObject(token, forKey: TotalOutstanding)
        userDefaults.synchronize()
    }
    
    private static func deleteTotalOutstanding() {
        userDefaults.removeObjectForKey(TotalOutstanding)
        userDefaults.synchronize()
    }
    
    static func accessTotalOutstanding() -> String? {
        return userDefaults.stringForKey(TotalOutstanding)
    }
    
    
    //----------------------------------------------------------------------------//
    
    static func setRefNumber(token: String) {
        userDefaults.setObject(token, forKey: RefNumber)
        userDefaults.synchronize()
    }
    
    private static func deleteRefNumber() {
        userDefaults.removeObjectForKey(RefNumber)
        userDefaults.synchronize()
    }
    
    static func accessRefNumber() -> String? {
        return userDefaults.stringForKey(RefNumber)
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

    static func setPin(token: String) {
        userDefaults.setObject(token, forKey: Pin)
        userDefaults.synchronize()
    }
    
    private static func deletePin() {
        userDefaults.removeObjectForKey(Pin)
        userDefaults.synchronize()
    }
    
    static func accessPin() -> String? {
        return userDefaults.stringForKey(Pin)
    }
    
    //----------------------------------------------------------------------------//
    
    static func setIsPinSetup(token: String) {
        userDefaults.setObject(token, forKey: IsPinSetup)
        userDefaults.synchronize()
    }
    
    private static func deleteIsPinSetup() {
        userDefaults.removeObjectForKey(IsPinSetup)
        userDefaults.synchronize()
    }
    
    static func accessIsPinSetup() -> String? {
        return userDefaults.stringForKey(IsPinSetup)
    }


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

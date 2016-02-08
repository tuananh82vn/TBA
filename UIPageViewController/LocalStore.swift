
import UIKit

struct LocalStore {
    
    private static let DeviceName = "DeviceName"

    private static let RefNumber = "RefNumber"
    
    private static let Web_URL_API = "Web_URL_API"

    private static let RCS_URL_API = "RCS_URL_API"
    
    private static let Pin = "Pin"
    
    private static let IsPinSetup = "IsPinSetup"
    
    private static let TotalOutstanding = "TotalOutstanding"
    
    private static let TotalPaid = "TotalPaid"
    
    private static let TotalOverDue = "TotalOverDue"

    private static let DRCode = "DRCode"

    private static let NextPaymentInstallment = "NextPaymentInstallment"

    private static let userDefaults = NSUserDefaults.standardUserDefaults()
    
    private static let IsExistingArrangementManual = "IsExistingArrangementManual";
    
    private static let IsExistingArrangementCC = "IsExistingArrangementCC";

    private static let IsExistingArrangementDD = "IsExistingArrangementDD";

    private static let IsCoBorrowers = "IsCoBorrowers";
    
    //----------------------------------------------------------------------------//
    static func setDeviceName(token: String) {
        userDefaults.setObject(token, forKey: DeviceName)
        userDefaults.synchronize()
    }
    
    private static func deleteDeviceName() {
        userDefaults.removeObjectForKey(DeviceName)
        userDefaults.synchronize()
    }
    
    static func accessDeviceName() -> String {
        return userDefaults.stringForKey(DeviceName)!
    }
    
    //----------------------------------------------------------------------------//
    static func setDRCode(token: String) {
        userDefaults.setObject(token, forKey: DRCode)
        userDefaults.synchronize()
    }
    
    private static func deleteDRCode() {
        userDefaults.removeObjectForKey(DRCode)
        userDefaults.synchronize()
    }
    
    static func accessDRCode() -> String? {
        return userDefaults.stringForKey(DRCode)
    }
    
    //----------------------------------------------------------------------------//
    
    static func setNextPaymentInstallment(token: String) {
        userDefaults.setObject(token, forKey: NextPaymentInstallment)
        userDefaults.synchronize()
    }
    
    private static func deleteNextPaymentInstallment() {
        userDefaults.removeObjectForKey(NextPaymentInstallment)
        userDefaults.synchronize()
    }
    
    static func accessNextPaymentInstallment() -> String? {
        return userDefaults.stringForKey(NextPaymentInstallment)
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
    
    static func setTotalPaid(token: String) {
        userDefaults.setObject(token, forKey: TotalPaid)
        userDefaults.synchronize()
    }
    
    private static func deletesetTotalPaid() {
        userDefaults.removeObjectForKey(TotalPaid)
        userDefaults.synchronize()
    }
    
    static func accesssetTotalPaid() -> String? {
        return userDefaults.stringForKey(TotalPaid)
    }
    
    //----------------------------------------------------------------------------//
    
    static func setTotalOverDue(token: String) {
        userDefaults.setObject(token, forKey: TotalOverDue)
        userDefaults.synchronize()
    }
    
    private static func deletesetTotalOverDue() {
        userDefaults.removeObjectForKey(TotalOverDue)
        userDefaults.synchronize()
    }
    
    static func accesssetTotalOverDue() -> String? {
        return userDefaults.stringForKey(TotalOverDue)
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
    
    //----------------------------------------------------------------------------//
    
    static func setIsExistingArrangementManual(token: Bool) {
        userDefaults.setObject(token, forKey: IsExistingArrangementManual)
        userDefaults.synchronize()
    }
    
    private static func deleteIsExistingArrangementManual() {
        userDefaults.removeObjectForKey(IsExistingArrangementManual)
        userDefaults.synchronize()
    }
    
    static func accessIsExistingArrangementManual() -> Bool? {
        return userDefaults.boolForKey(IsExistingArrangementManual)
    }
    
    //----------------------------------------------------------------------------//
    
    static func setIsExistingArrangementCC(token: Bool) {
        userDefaults.setObject(token, forKey: IsExistingArrangementCC)
        userDefaults.synchronize()
    }
    
    private static func deleteIsExistingArrangementCC() {
        userDefaults.removeObjectForKey(IsExistingArrangementCC)
        userDefaults.synchronize()
    }
    
    static func accessIsExistingArrangementCC() -> Bool? {
        return userDefaults.boolForKey(IsExistingArrangementCC)
    }
    
    //----------------------------------------------------------------------------//
    
    
    static func setIsExistingArrangementDD(token: Bool) {
        userDefaults.setObject(token, forKey: IsExistingArrangementDD)
        userDefaults.synchronize()
    }
    
    private static func deleteIsExistingArrangementDD() {
        userDefaults.removeObjectForKey(IsExistingArrangementDD)
        userDefaults.synchronize()
    }
    
    static func accessIsExistingArrangementDD() -> Bool? {
        return userDefaults.boolForKey(IsExistingArrangementDD)
    }
    
    //----------------------------------------------------------------------------//
    
    
    static func setIsCoBorrowers(token: Bool) {
        userDefaults.setObject(token, forKey: IsCoBorrowers)
        userDefaults.synchronize()
    }
    
    private static func deleteIsCoBorrowers() {
        userDefaults.removeObjectForKey(IsCoBorrowers)
        userDefaults.synchronize()
    }
    
    static func accessIsCoBorrowers() -> Bool? {
        return userDefaults.boolForKey(IsCoBorrowers)
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

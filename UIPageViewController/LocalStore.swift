
import UIKit

struct LocalStore {
    
    private static let ArrangementDebtor = "ArrangementDebtor";

    private static let IsArrangementUnderThisDebtor = "IsArrangementUnderThisDebtor";

    private static let MakePaymentInFull = "MakePaymentInFull"
    
    private static let MakePaymentIn3Part = "MakePaymentIn3Part";

    private static let MakePaymentInstallment = "MakePaymentInstallment";
    
    private static let MakePaymentOtherAmount = "MakePaymentOtherAmount";

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
    
    private static let IsExistingArrangement = "IsExistingArrangement";
    
    private static let IsExistingArrangementCC = "IsExistingArrangementCC";

    private static let IsExistingArrangementDD = "IsExistingArrangementDD";

    private static let IsCoBorrowers = "IsCoBorrowers";
    
    private static let IsCoBorrowersSelected = "IsCoBorrowersSelected";
    
    private static let IsAllowMonthlyInstallment = "IsAllowMonthlyInstallment";
    
    private static let DebtorCodeSelected = "DebtorCodeSelected";
    

    private static let MaxNoPay = "MaxNoPay";
    
    private static let ThreePartDateDurationDays = "ThreePartDateDurationDays";
    
    
    private static let FirstAmountOfInstalment = "FirstAmountOfInstalment"

    private static let WeeklyAmount = "WeeklyAmount"
    
    private static let FortnightAmount = "FortnightAmount"
    
    private static let MonthlyAmount = "MonthlyAmount"

    //----------------------------------------------------------------------------//
    
    static func setMonthlyAmount(token: Double) {
        userDefaults.setObject(token, forKey: MonthlyAmount)
        userDefaults.synchronize()
    }
    
    static func deleteMonthlyAmount() {
        userDefaults.removeObjectForKey(MonthlyAmount)
        userDefaults.synchronize()
    }
    
    static func accessMonthlyAmount() -> Double {
        return userDefaults.doubleForKey(MonthlyAmount)
    }
    
    //----------------------------------------------------------------------------//
    
    static func setFortnightAmount(token: Double) {
        userDefaults.setObject(token, forKey: FortnightAmount)
        userDefaults.synchronize()
    }
    
    static func deleteFortnightAmount() {
        userDefaults.removeObjectForKey(FortnightAmount)
        userDefaults.synchronize()
    }
    
    static func accessFortnightAmount() -> Double {
        return userDefaults.doubleForKey(FortnightAmount)
    }
    //----------------------------------------------------------------------------//
    
    static func setWeeklyAmount(token: Double) {
        userDefaults.setObject(token, forKey: WeeklyAmount)
        userDefaults.synchronize()
    }
    
    static func deleteWeeklyAmount() {
        userDefaults.removeObjectForKey(WeeklyAmount)
        userDefaults.synchronize()
    }
    
    static func accessWeeklyAmount() -> Double {
        return userDefaults.doubleForKey(WeeklyAmount)
    }
    
    //----------------------------------------------------------------------------//
    static func setMakePaymentIn3Part(token: Bool) {
        userDefaults.setObject(token, forKey: MakePaymentIn3Part)
        userDefaults.synchronize()
    }
    
    static func deleteMakePaymentIn3Part() {
        userDefaults.removeObjectForKey(MakePaymentIn3Part)
        userDefaults.synchronize()
    }
    
    static func accessMakePaymentIn3Part() -> Bool {
        return userDefaults.boolForKey(MakePaymentIn3Part)
    }
    
    //----------------------------------------------------------------------------//
    static func setIsArrangementUnderThisDebtor(token: Bool) {
        userDefaults.setObject(token, forKey: IsArrangementUnderThisDebtor)
        userDefaults.synchronize()
    }
    
    static func deleteIsArrangementUnderThisDebtor() {
        userDefaults.removeObjectForKey(IsArrangementUnderThisDebtor)
        userDefaults.synchronize()
    }
    
    static func accessIsArrangementUnderThisDebtor() -> Bool {
        return userDefaults.boolForKey(IsArrangementUnderThisDebtor)
    }
    
    //----------------------------------------------------------------------------//
    static func setMakePaymentInstallment(token: Bool) {
        userDefaults.setObject(token, forKey: MakePaymentInstallment)
        userDefaults.synchronize()
    }
    
    static func deleteMakePaymentInstallment() {
        userDefaults.removeObjectForKey(MakePaymentInstallment)
        userDefaults.synchronize()
    }
    
    static func accessMakePaymentInstallment() -> Bool {
        return userDefaults.boolForKey(MakePaymentInstallment)
    }
    //----------------------------------------------------------------------------//
    static func setMakePaymentOtherAmount(token: Bool) {
        userDefaults.setObject(token, forKey: MakePaymentOtherAmount)
        userDefaults.synchronize()
    }
    
    static func deleteMakePaymentOtherAmount() {
        userDefaults.removeObjectForKey(MakePaymentOtherAmount)
        userDefaults.synchronize()
    }
    
    static func accessMakePaymentOtherAmount() -> Bool {
        return userDefaults.boolForKey(MakePaymentOtherAmount)
    }
    

    //----------------------------------------------------------------------------//
    static func setMakePaymentInFull(token: Bool) {
        userDefaults.setObject(token, forKey: MakePaymentInFull)
        userDefaults.synchronize()
    }
    
    static func deleteMakePaymentInFull() {
        userDefaults.removeObjectForKey(MakePaymentInFull)
        userDefaults.synchronize()
    }
    
    static func accessMakePaymentInFull() -> Bool {
        return userDefaults.boolForKey(MakePaymentInFull)
    }
    
    //----------------------------------------------------------------------------//
    static func setArrangementDebtor(token: String) {
        userDefaults.setObject(token, forKey: ArrangementDebtor)
        userDefaults.synchronize()
    }
    
    static func deleteArrangementDebtor() {
        userDefaults.removeObjectForKey(ArrangementDebtor)
        userDefaults.synchronize()
    }
    
    static func accessArrangementDebtor() -> String {
        return userDefaults.stringForKey(ArrangementDebtor)!
    }
    //----------------------------------------------------------------------------//
    static func setDeviceName(token: String) {
        userDefaults.setObject(token, forKey: DeviceName)
        userDefaults.synchronize()
    }
    
    static func deleteDeviceName() {
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
    
    static func deleteDRCode() {
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
    
    static func deleteNextPaymentInstallment() {
        userDefaults.removeObjectForKey(NextPaymentInstallment)
        userDefaults.synchronize()
    }
    
    static func accessNextPaymentInstallment() -> String? {
        return userDefaults.stringForKey(NextPaymentInstallment)
    }
    
    //----------------------------------------------------------------------------//

    static func setTotalOutstanding(token: Double) {
        userDefaults.setObject(token, forKey: TotalOutstanding)
        userDefaults.synchronize()
    }
    
    static func deleteTotalOutstanding() {
        userDefaults.removeObjectForKey(TotalOutstanding)
        userDefaults.synchronize()
    }
    
    static func accessTotalOutstanding() -> Double {
        return userDefaults.doubleForKey(TotalOutstanding)
    }
    
    //----------------------------------------------------------------------------//
    
    static func setFirstAmountOfInstalment(token: Double) {
        userDefaults.setObject(token, forKey: FirstAmountOfInstalment)
        userDefaults.synchronize()
    }
    
    static func deleteFirstAmountOfInstalment() {
        userDefaults.removeObjectForKey(FirstAmountOfInstalment)
        userDefaults.synchronize()
    }
    
    static func accessFirstAmountOfInstalment() -> Double {
        return userDefaults.doubleForKey(FirstAmountOfInstalment)
    }
    
    //----------------------------------------------------------------------------//
    
    static func setTotalPaid(token: String) {
        userDefaults.setObject(token, forKey: TotalPaid)
        userDefaults.synchronize()
    }
    
    static func deletesetTotalPaid() {
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
    
    static func deletesetTotalOverDue() {
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
    
    static func deleteRefNumber() {
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
    
    static func deleteRCS_URL_API() {
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
    
    static func deleteWeb_URL_API() {
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
    
    static func deletePin() {
        userDefaults.removeObjectForKey(Pin)
        userDefaults.synchronize()
    }
    
    static func accessPin() -> String? {
        return userDefaults.stringForKey(Pin)
    }
    
    //----------------------------------------------------------------------------//
    
    static func setIsPinSetup(token: Bool) {
        userDefaults.setObject(token, forKey: IsPinSetup)
        userDefaults.synchronize()
    }
    
    static func deleteIsPinSetup() {
        userDefaults.removeObjectForKey(IsPinSetup)
        userDefaults.synchronize()
    }
    
    static func accessIsPinSetup() -> Bool {
        return userDefaults.boolForKey(IsPinSetup)
    }
    
    //----------------------------------------------------------------------------//
    
    static func setDebtorCodeSelected(token: String) {
        userDefaults.setObject(token, forKey: DebtorCodeSelected)
        userDefaults.synchronize()
    }
    
    static func deleteDebtorCodeSelected() {
        userDefaults.removeObjectForKey(DebtorCodeSelected)
        userDefaults.synchronize()
    }
    
    static func accessDebtorCodeSelected() -> String? {
        return userDefaults.stringForKey(DebtorCodeSelected)
    }
    
    //----------------------------------------------------------------------------//
    
    static func setIsExistingArrangement(token: Bool) {
        userDefaults.setObject(token, forKey: IsExistingArrangement)
        userDefaults.synchronize()
    }
    
    static func deleteIsExistingArrangement() {
        userDefaults.removeObjectForKey(IsExistingArrangement)
        userDefaults.synchronize()
    }
    
    static func accessIsExistingArrangement() -> Bool? {
        return userDefaults.boolForKey(IsExistingArrangement)
    }
    
    
    //----------------------------------------------------------------------------//
    
    static func setIsCoBorrowersSelected(token: Bool) {
        userDefaults.setObject(token, forKey: IsCoBorrowersSelected)
        userDefaults.synchronize()
    }
    
    static func deleteIsCoBorrowersSelected() {
        userDefaults.removeObjectForKey(IsCoBorrowersSelected)
        userDefaults.synchronize()
    }
    
    static func accessIsCoBorrowersSelected() -> Bool? {
        return userDefaults.boolForKey(IsCoBorrowersSelected)
    }
    
    
    
    //----------------------------------------------------------------------------//
    
    static func setIsExistingArrangementCC(token: Bool) {
        userDefaults.setObject(token, forKey: IsExistingArrangementCC)
        userDefaults.synchronize()
    }
    
    static func deleteIsExistingArrangementCC() {
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
    
    static func deleteIsExistingArrangementDD() {
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
    
    static func deleteIsCoBorrowers() {
        userDefaults.removeObjectForKey(IsCoBorrowers)
        userDefaults.synchronize()
    }
    
    static func accessIsCoBorrowers() -> Bool? {
        return userDefaults.boolForKey(IsCoBorrowers)
    }
    
    //----------------------------------------------------------------------------//
    
    
    static func setIsAllowMonthlyInstallment(token: Bool) {
        userDefaults.setObject(token, forKey: IsAllowMonthlyInstallment)
        userDefaults.synchronize()
    }
    
    static func deleteIsAllowMonthlyInstallment() {
        userDefaults.removeObjectForKey(IsAllowMonthlyInstallment)
        userDefaults.synchronize()
    }
    
    static func accessIsAllowMonthlyInstallment() -> Bool? {
        return userDefaults.boolForKey(IsAllowMonthlyInstallment)
    }
    
    //----------------------------------------------------------------------------//
    
    
    static func setMaxNoPay(token: Int) {
        userDefaults.setObject(token, forKey: MaxNoPay)
        userDefaults.synchronize()
    }
    
    static func deleteMaxNoPay() {
        userDefaults.removeObjectForKey(MaxNoPay)
        userDefaults.synchronize()
    }
    
    static func accessMaxNoPay() -> Int {
        return userDefaults.integerForKey(MaxNoPay)
    }
    
    //----------------------------------------------------------------------------//
    
    
    static func setThreePartDateDurationDays(token: Int) {
        userDefaults.setObject(token, forKey: ThreePartDateDurationDays)
        userDefaults.synchronize()
    }
    
    static func deleteThreePartDateDurationDays() {
        userDefaults.removeObjectForKey(ThreePartDateDurationDays)
        userDefaults.synchronize()
    }
    
    static func accessThreePartDateDurationDays() -> Int {
        return userDefaults.integerForKey(ThreePartDateDurationDays)
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

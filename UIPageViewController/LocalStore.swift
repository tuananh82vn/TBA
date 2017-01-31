
import UIKit

struct LocalStore {
    
    fileprivate static let DeviceToken = "DeviceToken";
    
    fileprivate static let ArrangementDebtor = "ArrangementDebtor";

    fileprivate static let IsArrangementUnderThisDebtor = "IsArrangementUnderThisDebtor";

    fileprivate static let MakePaymentInFull = "MakePaymentInFull"
    
    fileprivate static let MakePaymentIn3Part = "MakePaymentIn3Part";

    fileprivate static let MakePaymentInstallment = "MakePaymentInstallment";
    
    fileprivate static let MakePaymentOtherAmount = "MakePaymentOtherAmount";

    fileprivate static let DeviceName = "DeviceName"

    fileprivate static let RefNumber = "RefNumber"
    
    fileprivate static let Web_URL_API = "Web_URL_API"

    fileprivate static let RCS_URL_API = "RCS_URL_API"
    
    fileprivate static let Pin = "Pin"
    
    fileprivate static let IsPinSetup = "IsPinSetup"
    
    fileprivate static let TotalOutstanding = "TotalOutstanding"
    
    fileprivate static let TotalPaid = "TotalPaid"
    
    fileprivate static let TotalOverDue = "TotalOverDue"

    fileprivate static let DRCode = "DRCode"

    fileprivate static let NextPaymentInstallment = "NextPaymentInstallment"

    fileprivate static let userDefaults = UserDefaults.standard
    
    fileprivate static let IsExistingArrangement = "IsExistingArrangement";
    
    fileprivate static let IsExistingArrangementCC = "IsExistingArrangementCC";

    fileprivate static let IsExistingArrangementDD = "IsExistingArrangementDD";

    fileprivate static let IsCoBorrowers = "IsCoBorrowers";
    
    fileprivate static let IsCoBorrowersSelected = "IsCoBorrowersSelected";
    
    fileprivate static let IsAllowMonthlyInstallment = "IsAllowMonthlyInstallment";
    
    fileprivate static let DebtorCodeSelected = "DebtorCodeSelected";
    
    fileprivate static let MaxNoPay = "MaxNoPay";
    
    fileprivate static let ThreePartDateDurationDays = "ThreePartDateDurationDays";
    
    fileprivate static let FirstAmountOfInstalment = "FirstAmountOfInstalment"

    fileprivate static let WeeklyAmount = "WeeklyAmount"
    
    fileprivate static let FortnightAmount = "FortnightAmount"
    
    fileprivate static let MonthlyAmount = "MonthlyAmount"
    
    fileprivate static let Frequency = "Frequency"

    fileprivate static let IsAgreePrivacy = "IsAgreePrivacy"

    
    //----------------------------------------------------------------------------//
    static func setDeviceToken(_ token: String) {
        userDefaults.set(token, forKey: DeviceToken)
        userDefaults.synchronize()
    }
    
    static func deleteDeviceToken() {
        userDefaults.removeObject(forKey: DeviceToken)
        userDefaults.synchronize()
    }
    
    static func accessDeviceToken() -> String {
        return userDefaults.string(forKey: DeviceToken)!
    }

    //----------------------------------------------------------------------------//
    
    static func setMonthlyAmount(_ token: Double) {
        userDefaults.set(token, forKey: MonthlyAmount)
        userDefaults.synchronize()
    }
    
    static func deleteMonthlyAmount() {
        userDefaults.removeObject(forKey: MonthlyAmount)
        userDefaults.synchronize()
    }
    
    static func accessMonthlyAmount() -> Double {
        return userDefaults.double(forKey: MonthlyAmount)
    }
    
    //----------------------------------------------------------------------------//
    
    static func setFortnightAmount(_ token: Double) {
        userDefaults.set(token, forKey: FortnightAmount)
        userDefaults.synchronize()
    }
    
    static func deleteFortnightAmount() {
        userDefaults.removeObject(forKey: FortnightAmount)
        userDefaults.synchronize()
    }
    
    static func accessFortnightAmount() -> Double {
        return userDefaults.double(forKey: FortnightAmount)
    }
    //----------------------------------------------------------------------------//
    
    static func setWeeklyAmount(_ token: Double) {
        userDefaults.set(token, forKey: WeeklyAmount)
        userDefaults.synchronize()
    }
    
    static func deleteWeeklyAmount() {
        userDefaults.removeObject(forKey: WeeklyAmount)
        userDefaults.synchronize()
    }
    
    static func accessWeeklyAmount() -> Double {
        return userDefaults.double(forKey: WeeklyAmount)
    }
    
    //----------------------------------------------------------------------------//
    static func setMakePaymentIn3Part(_ token: Bool) {
        userDefaults.set(token, forKey: MakePaymentIn3Part)
        userDefaults.synchronize()
    }
    
    static func deleteMakePaymentIn3Part() {
        userDefaults.removeObject(forKey: MakePaymentIn3Part)
        userDefaults.synchronize()
    }
    
    static func accessMakePaymentIn3Part() -> Bool {
        return userDefaults.bool(forKey: MakePaymentIn3Part)
    }
    
    //----------------------------------------------------------------------------//
    static func setIsArrangementUnderThisDebtor(_ token: Bool) {
        userDefaults.set(token, forKey: IsArrangementUnderThisDebtor)
        userDefaults.synchronize()
    }
    
    static func deleteIsArrangementUnderThisDebtor() {
        userDefaults.removeObject(forKey: IsArrangementUnderThisDebtor)
        userDefaults.synchronize()
    }
    
    static func accessIsArrangementUnderThisDebtor() -> Bool {
        return userDefaults.bool(forKey: IsArrangementUnderThisDebtor)
    }
    
    //----------------------------------------------------------------------------//
    static func setMakePaymentInstallment(_ token: Bool) {
        userDefaults.set(token, forKey: MakePaymentInstallment)
        userDefaults.synchronize()
    }
    
    static func deleteMakePaymentInstallment() {
        userDefaults.removeObject(forKey: MakePaymentInstallment)
        userDefaults.synchronize()
    }
    
    static func accessMakePaymentInstallment() -> Bool {
        return userDefaults.bool(forKey: MakePaymentInstallment)
    }
    //----------------------------------------------------------------------------//
    static func setMakePaymentOtherAmount(_ token: Bool) {
        userDefaults.set(token, forKey: MakePaymentOtherAmount)
        userDefaults.synchronize()
    }
    
    static func deleteMakePaymentOtherAmount() {
        userDefaults.removeObject(forKey: MakePaymentOtherAmount)
        userDefaults.synchronize()
    }
    
    static func accessMakePaymentOtherAmount() -> Bool {
        return userDefaults.bool(forKey: MakePaymentOtherAmount)
    }
    

    //----------------------------------------------------------------------------//
    static func setMakePaymentInFull(_ token: Bool) {
        userDefaults.set(token, forKey: MakePaymentInFull)
        userDefaults.synchronize()
    }
    
    static func deleteMakePaymentInFull() {
        userDefaults.removeObject(forKey: MakePaymentInFull)
        userDefaults.synchronize()
    }
    
    static func accessMakePaymentInFull() -> Bool {
        return userDefaults.bool(forKey: MakePaymentInFull)
    }
    
    //----------------------------------------------------------------------------//
    static func setArrangementDebtor(_ token: String) {
        userDefaults.set(token, forKey: ArrangementDebtor)
        userDefaults.synchronize()
    }
    
    static func deleteArrangementDebtor() {
        userDefaults.removeObject(forKey: ArrangementDebtor)
        userDefaults.synchronize()
    }
    
    static func accessArrangementDebtor() -> String {
        return userDefaults.string(forKey: ArrangementDebtor)!
    }
    //----------------------------------------------------------------------------//
    static func setDeviceName(_ token: String) {
        userDefaults.set(token, forKey: DeviceName)
        userDefaults.synchronize()
    }
    
    static func deleteDeviceName() {
        userDefaults.removeObject(forKey: DeviceName)
        userDefaults.synchronize()
    }
    
    static func accessDeviceName() -> String {
        return userDefaults.string(forKey: DeviceName)!
    }
    
    //----------------------------------------------------------------------------//
    static func setDRCode(_ token: String) {
        userDefaults.set(token, forKey: DRCode)
        userDefaults.synchronize()
    }
    
    static func deleteDRCode() {
        userDefaults.removeObject(forKey: DRCode)
        userDefaults.synchronize()
    }
    
    static func accessDRCode() -> String? {
        return userDefaults.string(forKey: DRCode)
    }
    
    //----------------------------------------------------------------------------//
    
    static func setNextPaymentInstallment(_ token: Double) {
        userDefaults.set(token, forKey: NextPaymentInstallment)
        userDefaults.synchronize()
    }
    
    static func deleteNextPaymentInstallment() {
        userDefaults.removeObject(forKey: NextPaymentInstallment)
        userDefaults.synchronize()
    }
    
    static func accessNextPaymentInstallment() -> Double {
        return userDefaults.double(forKey: NextPaymentInstallment)
    }
    
    //----------------------------------------------------------------------------//

    static func setTotalOutstanding(_ token: Double) {
        userDefaults.set(token, forKey: TotalOutstanding)
        userDefaults.synchronize()
    }
    
    static func deleteTotalOutstanding() {
        userDefaults.removeObject(forKey: TotalOutstanding)
        userDefaults.synchronize()
    }
    
    static func accessTotalOutstanding() -> Double {
        return userDefaults.double(forKey: TotalOutstanding)
    }
    
    //----------------------------------------------------------------------------//
    
    static func setFirstAmountOfInstalment(_ token: Double) {
        userDefaults.set(token, forKey: FirstAmountOfInstalment)
        userDefaults.synchronize()
    }
    
    static func deleteFirstAmountOfInstalment() {
        userDefaults.removeObject(forKey: FirstAmountOfInstalment)
        userDefaults.synchronize()
    }
    
    static func accessFirstAmountOfInstalment() -> Double {
        return userDefaults.double(forKey: FirstAmountOfInstalment)
    }
    
    //----------------------------------------------------------------------------//
    
    static func setTotalPaid(_ token: String) {
        userDefaults.set(token, forKey: TotalPaid)
        userDefaults.synchronize()
    }
    
    static func deletesetTotalPaid() {
        userDefaults.removeObject(forKey: TotalPaid)
        userDefaults.synchronize()
    }
    
    static func accesssetTotalPaid() -> String? {
        return userDefaults.string(forKey: TotalPaid)
    }
    
    //----------------------------------------------------------------------------//
    
    static func setTotalOverDue(_ token: String) {
        userDefaults.set(token, forKey: TotalOverDue)
        userDefaults.synchronize()
    }
    
    static func deletesetTotalOverDue() {
        userDefaults.removeObject(forKey: TotalOverDue)
        userDefaults.synchronize()
    }
    
    static func accesssetTotalOverDue() -> String? {
        return userDefaults.string(forKey: TotalOverDue)
    }
    
    
    //----------------------------------------------------------------------------//
    
    static func setRefNumber(_ token: String) {
        userDefaults.set(token, forKey: RefNumber)
        userDefaults.synchronize()
    }
    
    static func deleteRefNumber() {
        userDefaults.removeObject(forKey: RefNumber)
        userDefaults.synchronize()
    }
    
    static func accessRefNumber() -> String? {
        return userDefaults.string(forKey: RefNumber)
    }
    
    
    //----------------------------------------------------------------------------//
    
    static func setRCS_URL_API(_ token: String) {
        userDefaults.set(token, forKey: RCS_URL_API)
        userDefaults.synchronize()
    }
    
    static func deleteRCS_URL_API() {
        userDefaults.removeObject(forKey: RCS_URL_API)
        userDefaults.synchronize()
    }
    
    static func accessRCS_URL_API() -> String? {
        return userDefaults.string(forKey: RCS_URL_API)
    }
    
    //----------------------------------------------------------------------------//
    
    static func setWeb_URL_API(_ token: String) {
        userDefaults.set(token, forKey: Web_URL_API)
        userDefaults.synchronize()
    }
    
    static func deleteWeb_URL_API() {
        userDefaults.removeObject(forKey: Web_URL_API)
        userDefaults.synchronize()
    }
    
    static func accessWeb_URL_API() -> String? {
        return userDefaults.string(forKey: Web_URL_API)
    }
    
    //----------------------------------------------------------------------------//

    static func setPin(_ token: String) {
        userDefaults.set(token, forKey: Pin)
        userDefaults.synchronize()
    }
    
    static func deletePin() {
        userDefaults.removeObject(forKey: Pin)
        userDefaults.synchronize()
    }
    
    static func accessPin() -> String? {
        return userDefaults.string(forKey: Pin)
    }
    
    //----------------------------------------------------------------------------//
    
    static func setIsPinSetup(_ token: Bool) {
        userDefaults.set(token, forKey: IsPinSetup)
        userDefaults.synchronize()
    }
    
    static func deleteIsPinSetup() {
        userDefaults.removeObject(forKey: IsPinSetup)
        userDefaults.synchronize()
    }
    
    static func accessIsPinSetup() -> Bool {
        return userDefaults.bool(forKey: IsPinSetup)
    }
    
    //----------------------------------------------------------------------------//
    
    static func setDebtorCodeSelected(_ token: String) {
        userDefaults.set(token, forKey: DebtorCodeSelected)
        userDefaults.synchronize()
    }
    
    static func deleteDebtorCodeSelected() {
        userDefaults.removeObject(forKey: DebtorCodeSelected)
        userDefaults.synchronize()
    }
    
    static func accessDebtorCodeSelected() -> String? {
        return userDefaults.string(forKey: DebtorCodeSelected)
    }
    
    //----------------------------------------------------------------------------//
    
    static func setIsExistingArrangement(_ token: Bool) {
        userDefaults.set(token, forKey: IsExistingArrangement)
        userDefaults.synchronize()
    }
    
    static func deleteIsExistingArrangement() {
        userDefaults.removeObject(forKey: IsExistingArrangement)
        userDefaults.synchronize()
    }
    
    static func accessIsExistingArrangement() -> Bool? {
        return userDefaults.bool(forKey: IsExistingArrangement)
    }
    
    
    //----------------------------------------------------------------------------//
    
    static func setIsCoBorrowersSelected(_ token: Bool) {
        userDefaults.set(token, forKey: IsCoBorrowersSelected)
        userDefaults.synchronize()
    }
    
    static func deleteIsCoBorrowersSelected() {
        userDefaults.removeObject(forKey: IsCoBorrowersSelected)
        userDefaults.synchronize()
    }
    
    static func accessIsCoBorrowersSelected() -> Bool? {
        return userDefaults.bool(forKey: IsCoBorrowersSelected)
    }
    
    
    
    //----------------------------------------------------------------------------//
    
    static func setIsExistingArrangementCC(_ token: Bool) {
        userDefaults.set(token, forKey: IsExistingArrangementCC)
        userDefaults.synchronize()
    }
    
    static func deleteIsExistingArrangementCC() {
        userDefaults.removeObject(forKey: IsExistingArrangementCC)
        userDefaults.synchronize()
    }
    
    static func accessIsExistingArrangementCC() -> Bool? {
        return userDefaults.bool(forKey: IsExistingArrangementCC)
    }
    
    //----------------------------------------------------------------------------//
    
    
    static func setIsExistingArrangementDD(_ token: Bool) {
        userDefaults.set(token, forKey: IsExistingArrangementDD)
        userDefaults.synchronize()
    }
    
    static func deleteIsExistingArrangementDD() {
        userDefaults.removeObject(forKey: IsExistingArrangementDD)
        userDefaults.synchronize()
    }
    
    static func accessIsExistingArrangementDD() -> Bool? {
        return userDefaults.bool(forKey: IsExistingArrangementDD)
    }
    
    //----------------------------------------------------------------------------//
    
    
    static func setIsCoBorrowers(_ token: Bool) {
        userDefaults.set(token, forKey: IsCoBorrowers)
        userDefaults.synchronize()
    }
    
    static func deleteIsCoBorrowers() {
        userDefaults.removeObject(forKey: IsCoBorrowers)
        userDefaults.synchronize()
    }
    
    static func accessIsCoBorrowers() -> Bool? {
        return userDefaults.bool(forKey: IsCoBorrowers)
    }
    
    //----------------------------------------------------------------------------//
    
    
    static func setIsAllowMonthlyInstallment(_ token: Bool) {
        userDefaults.set(token, forKey: IsAllowMonthlyInstallment)
        userDefaults.synchronize()
    }
    
    static func deleteIsAllowMonthlyInstallment() {
        userDefaults.removeObject(forKey: IsAllowMonthlyInstallment)
        userDefaults.synchronize()
    }
    
    static func accessIsAllowMonthlyInstallment() -> Bool? {
        return userDefaults.bool(forKey: IsAllowMonthlyInstallment)
    }
    
    //----------------------------------------------------------------------------//
    
    
    static func setMaxNoPay(_ token: Int) {
        userDefaults.set(token, forKey: MaxNoPay)
        userDefaults.synchronize()
    }
    
    static func deleteMaxNoPay() {
        userDefaults.removeObject(forKey: MaxNoPay)
        userDefaults.synchronize()
    }
    
    static func accessMaxNoPay() -> Int {
        return userDefaults.integer(forKey: MaxNoPay)
    }
    
    //----------------------------------------------------------------------------//
    
    
    static func setThreePartDateDurationDays(_ token: Int) {
        userDefaults.set(token, forKey: ThreePartDateDurationDays)
        userDefaults.synchronize()
    }
    
    static func deleteThreePartDateDurationDays() {
        userDefaults.removeObject(forKey: ThreePartDateDurationDays)
        userDefaults.synchronize()
    }
    
    static func accessThreePartDateDurationDays() -> Int {
        return userDefaults.integer(forKey: ThreePartDateDurationDays)
    }
    
    //----------------------------------------------------------------------------//


    // MARK: Helper

    static fileprivate func arrayForKey(_ key: String, containsId id: Int) -> Bool {
        let elements = userDefaults.array(forKey: key) as? [Int] ?? []
        return elements.contains(id)
    }

    static fileprivate func appendId(_ id: Int, toKey key: String) {
        let elements = userDefaults.array(forKey: key) as? [Int] ?? []
        if !elements.contains(id) {
            userDefaults.set(elements + [id], forKey: key)
            userDefaults.synchronize()
        }
    }

    static fileprivate func removeId(_ id: Int, forKey key: String) {
        var elements = userDefaults.array(forKey: key) as? [Int] ?? []
        if let index = elements.index(of: id) {
            elements.remove(at: index)
            userDefaults.set(elements, forKey: key)
            userDefaults.synchronize()
        }
    }
    
    //----------------------------------------------------------------------------//
    
    
    static func setFrequency(_ token: Int) {
        userDefaults.set(token, forKey: Frequency)
        userDefaults.synchronize()
    }
    
    static func deleteFrequency() {
        userDefaults.removeObject(forKey: Frequency)
        userDefaults.synchronize()
    }
    
    static func accessFrequency() -> Int {
        return userDefaults.integer(forKey: Frequency)
    }
    //----------------------------------------------------------------------------//

    static func setIsAgreePrivacy(_ token: Bool) {
        userDefaults.set(token, forKey: IsAgreePrivacy)
        userDefaults.synchronize()
    }
    
    static func deleteIsAgreePrivacy() {
        userDefaults.removeObject(forKey: IsAgreePrivacy)
        userDefaults.synchronize()
    }
    
    static func accessIsAgreePrivacy() -> Bool {
        return userDefaults.bool(forKey: IsAgreePrivacy)
    }
    
    //----------------------------------------------------------------------------//

    static func Alert(_ view : UIView, title : String , message : String , indexPath : Int) {
        
        
        //0 Error
        //1 Warning
        //2 Positive
        //3 Info
        let colors = [UIColor(red: 1, green: 0, blue: 0.282, alpha: 1),
                      UIColor(red:1, green:0.733, blue:0, alpha:1),
                      UIColor(red:0.478, green:0.988, blue:0.157, alpha:1),
                      UIColor(red:0.231, green:0.678, blue:1, alpha:1)]

        
        let alert = TKAlert()
        
        alert.customFrame = CGRect(x: 0, y: 20, width: view.frame.size.width, height: 160)
        alert.style.contentSeparatorWidth = 0
        alert.style.titleColor = UIColor.white
        alert.style.messageColor = UIColor.white
        alert.style.cornerRadius = 0
        alert.style.showAnimation = TKAlertAnimation.slideFromTop
        alert.style.dismissAnimation = TKAlertAnimation.slideFromTop
        alert.style.backgroundStyle = TKAlertBackgroundStyle.none
        
        alert.alertView.autoresizingMask = UIViewAutoresizing.flexibleWidth
        alert.dismissMode = TKAlertDismissMode.tap
        
        alert.title = title
        alert.message = message
        alert.contentView.fill = TKSolidFill(color: colors[indexPath])
        alert.headerView.fill = TKSolidFill(color: colors[indexPath])
        
        alert.dismissTimeout = 3

        alert.show(true)

    }
}

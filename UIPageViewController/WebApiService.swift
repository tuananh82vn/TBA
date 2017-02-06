
import SystemConfiguration
import Alamofire
import SwiftyJSON

struct WebApiService {

    
    fileprivate enum ResourcePath: CustomStringConvertible {
        case verify
        case getNetCode
        case getNetCodeVerify
        case verifyNetCode
        case getDebtorInfo
        case validateCreditCard
        case makeCreditCardPayment
        case makeDebitPayment
        case emailReceipt
        case requestCallback
        case getPaymentDetail
        case getPersonalInformationDetail
        case sendFeedback
        case arrangeDetail
        case deferPayment
        case getDebtorAdditionalInfor
        case getDebtorPaymentHistory
        case getWelcomeMessage
        case sendAppDetails
        case getInboxItems
        case getInboxItemMessage
        case getInboxItemDocument
        case updateInboxItemMessage
        case saveInbox
        case sendActivityTracking
        case getCallBackTime
        
        var description: String {
            switch self {
                case .verify: return "/Api/Verify"
                case .getNetCode: return "/Api/GetNetCode"
                case .getNetCodeVerify: return "/Api/GetNetCodeVerify"
                case .verifyNetCode: return "/Api/VerifyNetCode"
                case .getDebtorInfo: return "/Api/GetDebtorInfo"
                case .getDebtorAdditionalInfor: return "/Api/GetDebtorAdditionalInfor"

                case .validateCreditCard: return "/Api/ValidateCreditCard"
                case .makeCreditCardPayment: return "/Api/MakeCreditCardPayment"
                case .makeDebitPayment: return "/Api/MakeDebitPayment"
                case .emailReceipt: return "/Api/EmailReceipt"
                case .requestCallback: return "/Api/RequestCallback"
                case .getPaymentDetail: return "/Api/GetPaymentDetail"
                case .getPersonalInformationDetail: return "/Api/GetPersonalInformationDetail"
                case .sendFeedback: return "/Api/SendFeedback"
                case .arrangeDetail: return "/Api/GetArrangeDetails"
                case .deferPayment : return "/Api/DeferPayment"
                case .getDebtorPaymentHistory : return "/Api/GetDebtorPaymentHistory"
                case .getWelcomeMessage: return "/Api/GetWelcomeMessage"
                case .sendAppDetails: return "/Api/SendAppDetails"
                case .getInboxItems: return "/Api/GetInboxItems"
                case .getInboxItemMessage: return "/Api/GetInboxItemMessage"
                case .getInboxItemDocument: return "/Api/GetInboxItemDocument"
                case .updateInboxItemMessage: return "/Api/UpdateInboxItemMessage"
                case .saveInbox: return "/Api/SaveInbox"
                case .sendActivityTracking: return "/Api/SendActivityTracking"
                case .getCallBackTime: return "/Api/GetCallBackTime"

            }
        }
    }
    
      static func postVerify(domain: String, response : @escaping (_ objectReturn : JsonReturnModel?) -> ()) {
        let urlString = domain + ResourcePath.verify.description
        
        let JsonReturn = JsonReturnModel()
        
        Alamofire.request(urlString, method: .post, encoding: JSONEncoding.default).responseJSON {
            json in
            
            if let jsonReturn1 = json.result.value {
                
                let jsonObject = JSON(jsonReturn1)
                
                if let IsSuccess = jsonObject["IsSuccess"].bool {
                    
                    JsonReturn.IsSuccess = IsSuccess
                    
                }
                
                if let Errors = jsonObject["Errors"].arrayObject {
                    
                    let ErrorsReturn = JSONParser.parseError(Errors as NSArray)
                    
                    JsonReturn.Errors = ErrorsReturn
                    
                }
                
                response (JsonReturn)
                
            }
            else
            {
                response (nil)
            }
            
        }

    }


//    static func checkInternet(_ completionHandler:(_ internet:Bool) -> Void){
//        
//        var internet = false
//        
//        var zeroAddress = sockaddr_in()
//        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
//        zeroAddress.sin_family = sa_family_t(AF_INET)
//        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
//            SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
//        }
//        var flags = SCNetworkReachabilityFlags()
//        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
//            completionHandler(internet)
//        }
//        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
//        
//        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
//    
//        internet =  (isReachable && !needsConnection)
//
//        completionHandler(internet)
//    
//    }
    
    static func getNetCode(ReferenceNumber: String,  response : @escaping (_ objectReturn : JsonReturnModel?) -> ()) {
        
        let urlString = LocalStore.accessWeb_URL_API()! + ResourcePath.getNetCode.description
        
        let JsonReturn = JsonReturnModel()
        
        let parameters = [
            "Item": [
                "ReferenceNumber": ReferenceNumber
            ]
        ]
        
        
        Alamofire.request(urlString, method: .post, parameters : parameters  ,encoding: JSONEncoding.default).responseJSON {
            json in
            
            if let jsonReturn1 = json.result.value {
                
                let jsonObject = JSON(jsonReturn1)
                
                
                if let IsSuccess = jsonObject["IsSuccess"].bool {
                    
                    JsonReturn.IsSuccess = IsSuccess
                    
                }
                
                
                if let Errors = jsonObject["Errors"].arrayObject {
                    
                    let ErrorsReturn = JSONParser.parseError(Errors as NSArray)
                    
                    JsonReturn.Errors = ErrorsReturn
                    
                }
                
                response (JsonReturn)
            }
            else
            {
                response (nil)
            }
            
        }

    }
    
    static func getNetCodeVerify(_ ReferenceNumber: String, MobileNumber: String,  response : @escaping (_ objectReturn : JsonReturnModel?) -> ()) {
        
        let urlString = LocalStore.accessWeb_URL_API()! + ResourcePath.getNetCodeVerify.description
        
        let JsonReturn = JsonReturnModel()
        
        let parameters = [
            "Item": [
                "ReferenceNumber": ReferenceNumber,
                "MobileNumbers": MobileNumber
            ]
        ]
        
        
        Alamofire.request(urlString, method: .post, parameters : parameters  ,encoding: JSONEncoding.default).responseJSON {
            json in
            
            if let jsonReturn1 = json.result.value {
                
                let jsonObject = JSON(jsonReturn1)
                
                
                if let IsSuccess = jsonObject["IsSuccess"].bool {
                    
                    JsonReturn.IsSuccess = IsSuccess
                    
                }
                
                if let Errors = jsonObject["Errors"].arrayObject {
                    
                    let ErrorsReturn = JSONParser.parseError(Errors as NSArray)
                    
                    JsonReturn.Errors = ErrorsReturn
                    
                }
                
                response (JsonReturn)
            }
            else
            {
                response (nil)
            }
            
        }
        
    }
    
//    static func getWelcomeMessage(_ response : @escaping (_ objectReturn : JsonReturnModel?) -> ()) {
//        
//        let urlString = LocalStore.accessWeb_URL_API()! + ResourcePath.getWelcomeMessage.description
//        
//        let JsonReturn = JsonReturnModel()
//        
//
//        
//        
//        Alamofire.request(urlString, method: .post ,encoding: JSONEncoding.default).responseJSON {
//            json in
//            
//            if let jsonReturn1 = json.result.value {
//                
//                let jsonObject = JSON(jsonReturn1)
//                
//
//                if let Errors = jsonObject["Errors"].arrayObject {
//                    
//                    let ErrorsReturn = JSONParser.parseError(Errors as NSArray)
//                    
//                    JsonReturn.Errors = ErrorsReturn
//                    
//                }
//                
//                response (JsonReturn)
//            }
//            else
//            {
//                response (nil)
//            }
//            
//        }
//    }

    static func verifyNetCode(_ ReferenceNumber: String, Netcode: String, response : @escaping (_ objectReturn : JsonReturnModel?) -> ()) {
        
        let urlString = LocalStore.accessWeb_URL_API()! + ResourcePath.verifyNetCode.description
        
        let JsonReturn = JsonReturnModel()
        
        let parameters = [
            "Item": [
                "ReferenceNumber": ReferenceNumber,
                "Netcode": Netcode
            ]
        ]
        
        
        Alamofire.request(urlString, method: .post, parameters : parameters  ,encoding: JSONEncoding.default).responseJSON {
            json in
            
            if let jsonReturn1 = json.result.value {
                
                let jsonObject = JSON(jsonReturn1)
                
                
                if let IsSuccess = jsonObject["IsSuccess"].bool {
                    
                    JsonReturn.IsSuccess = IsSuccess
                    
                }
                
                if let Errors = jsonObject["Errors"].arrayObject {
                    
                    let ErrorsReturn = JSONParser.parseError(Errors as NSArray)
                    
                    JsonReturn.Errors = ErrorsReturn
                    
                }
                
                response (JsonReturn)
            }
            else
            {
                response (nil)
            }
            
        }
    }
    
    static func validateCreditCard(_ CardNumber: String, CardType: Int, response : @escaping (_ objectReturn : JsonReturnModel?) -> ()) {
        
        let urlString = LocalStore.accessWeb_URL_API()! + ResourcePath.validateCreditCard.description
        
        let JsonReturn = JsonReturnModel()
        
        let parameters = [
            "Item": [
                "CardType": CardType,
                "CreditCardNumber": CardNumber
            ]
        ]
        
        
        Alamofire.request(urlString, method: .post, parameters : parameters  ,encoding: JSONEncoding.default).responseJSON {
            json in
            
            if let jsonReturn1 = json.result.value {
                
                let jsonObject = JSON(jsonReturn1)
                
                
                if let IsSuccess = jsonObject["IsSuccess"].bool {
                    
                    JsonReturn.IsSuccess = IsSuccess
                    
                }
                
                if let Errors = jsonObject["Errors"].arrayObject {
                    
                    let ErrorsReturn = JSONParser.parseError(Errors as NSArray)
                    
                    JsonReturn.Errors = ErrorsReturn
                    
                }
                
                response (JsonReturn)
            }
            else
            {
                response (nil)
            }
            
        }
    }

    static func emailReceipt(_ debtorInfo:  DebtorInfo, response : @escaping (_ objectReturn : JsonReturnModel?) -> ()) {
        
        let urlString = LocalStore.accessWeb_URL_API()! + ResourcePath.emailReceipt.description
        
        let JsonReturn = JsonReturnModel()
        
        let parameters = [
            "Item": [
                "Name": debtorInfo.Name,
                "CurrentPaymentId": debtorInfo.CurrentPaymentId,
                "ClientName" : debtorInfo.ClientName,
                "PaymentType" : debtorInfo.PaymentType,
                "EmailAddress" : debtorInfo.EmailAddress,
                "PaymentMethod" : debtorInfo.PaymentMethod
            ]
        ]
        
        
        Alamofire.request(urlString, method: .post, parameters : parameters  ,encoding: JSONEncoding.default).responseJSON {
            json in
            
            if let jsonReturn1 = json.result.value {
                
                let jsonObject = JSON(jsonReturn1)
                
                
                if let IsSuccess = jsonObject["IsSuccess"].bool {
                    
                    JsonReturn.IsSuccess = IsSuccess
                    
                }
                
                if let Errors = jsonObject["Errors"].arrayObject {
                    
                    let ErrorsReturn = JSONParser.parseError(Errors as NSArray)
                    
                    JsonReturn.Errors = ErrorsReturn
                    
                }
                
                response (JsonReturn)
            }
            else
            {
                response (nil)
            }
            
        }
    }

    static func saveInbox(_ debtorInfo:  DebtorInfo, response : @escaping (_ objectReturn : JsonReturnModel?) -> ()) {
        
        let urlString = LocalStore.accessWeb_URL_API()! + ResourcePath.saveInbox.description
        
        let JsonReturn = JsonReturnModel()
        
        let parameters = [
            "Item": [
                "Name": debtorInfo.Name,
                "CurrentPaymentId": debtorInfo.CurrentPaymentId,
                "ClientName" : debtorInfo.ClientName,
                "PaymentType" : debtorInfo.PaymentType,
                "EmailAddress" : debtorInfo.EmailAddress,
                "PaymentMethod" : debtorInfo.PaymentMethod
            ]
        ]
        
        
        Alamofire.request(urlString, method: .post, parameters : parameters  ,encoding: JSONEncoding.default).responseJSON {
            json in
            
            if let jsonReturn1 = json.result.value {
                
                let jsonObject = JSON(jsonReturn1)
                
                
                if let IsSuccess = jsonObject["IsSuccess"].bool {
                    
                    JsonReturn.IsSuccess = IsSuccess
                    
                }
                
                if let Errors = jsonObject["Errors"].arrayObject {
                    
                    let ErrorsReturn = JSONParser.parseError(Errors as NSArray)
                    
                    JsonReturn.Errors = ErrorsReturn
                    
                }
                
                response (JsonReturn)
            }
            else
            {
                response (nil)
            }
            
        }
    }

    static func updateInboxItemMessage(_ ReferenceNumber:  String, MessageNo : String , Action : String, response : @escaping (_ objectReturn : JsonReturnModel?) -> ()) {
        
        let urlString = LocalStore.accessWeb_URL_API()! + ResourcePath.updateInboxItemMessage.description
        
        let JsonReturn = JsonReturnModel()
        
        let parameters = [
                "ReferenceNumber": ReferenceNumber,
                "MessageNo": MessageNo,
                "Action" : Action
        ]
        
        
        Alamofire.request(urlString, method: .post, parameters : parameters  ,encoding: JSONEncoding.default).responseJSON {
            json in
            
            if let jsonReturn1 = json.result.value {
                
                let jsonObject = JSON(jsonReturn1)
                
                
                if let IsSuccess = jsonObject["IsSuccess"].bool {
                    
                    JsonReturn.IsSuccess = IsSuccess
                    
                }
                
                if let Errors = jsonObject["Errors"].arrayObject {
                    
                    let ErrorsReturn = JSONParser.parseError(Errors as NSArray)
                    
                    JsonReturn.Errors = ErrorsReturn
                    
                }
                
                response (JsonReturn)
            }
            else
            {
                response (nil)
            }
            
        }
    }
    
    static func getInboxItemDocument(_ ReferenceNumber:  String, DocumentPath : String, response : @escaping (_ objectReturn : JsonReturnModel?) -> ()) {
        
        let urlString = LocalStore.accessWeb_URL_API()! + ResourcePath.getInboxItemDocument.description
        
        let JsonReturn = JsonReturnModel()
        
        let parameters = [
            "ReferenceNumber": ReferenceNumber,
            "DocumentPath" : DocumentPath
        ]
        
        
        Alamofire.request(urlString, method: .post, parameters : parameters  ,encoding: JSONEncoding.default).responseJSON {
            json in
            
            if let jsonReturn1 = json.result.value {
                
                let jsonObject = JSON(jsonReturn1)
                
                
                if let IsSuccess = jsonObject["IsSuccess"].bool {
                    
                    JsonReturn.IsSuccess = IsSuccess
                    
                }
                
                if let Errors = jsonObject["Errors"].arrayObject {
                    
                    let ErrorsReturn = JSONParser.parseError(Errors as NSArray)
                    
                    JsonReturn.Errors = ErrorsReturn
                    
                }
                
                response (JsonReturn)
            }
            else
            {
                response (nil)
            }
            
        }
    }
    
    static func GetDebtorInfo(_ ReferenceNumber: String, response : @escaping (_ objectReturn : DebtorInfo?) -> ()) {
        
        let urlString = LocalStore.accessWeb_URL_API()! + ResourcePath.getDebtorInfo.description
        
        let JsonReturn = DebtorInfo()
        
        let parameters = [
            "Item": [
                "ReferenceNumber": ReferenceNumber
            ]
        ]
        
        
        Alamofire.request(urlString, method: .post, parameters : parameters  ,encoding: JSONEncoding.default).responseJSON {
            json in
            
            if let jsonReturn1 = json.result.value {
                
                let jsonObject = JSON(jsonReturn1)
                
                if let IsSuccess = jsonObject["IsSuccess"].bool {
                    
                    JsonReturn.IsSuccess = IsSuccess
                }
                
                if let ReferenceNumber = jsonObject["ReferenceNumber"].string {
                    JsonReturn.ReferenceNumber = ReferenceNumber
                }
                
                if let ReferenceNumber = jsonObject["AccountCode"].string {
                    JsonReturn.AccountCode = ReferenceNumber
                }
                
                if let DRCode = jsonObject["DebtorCode"].string {
                    JsonReturn.DRCode = DRCode
                }

                if let TotalOutstanding = jsonObject["TotalOutstanding"].double {
                    JsonReturn.TotalOutstanding = TotalOutstanding.roundTo(places: 2)
                }
                
                if let MaxNoPay = jsonObject["MaxNoPay"].int {
                    JsonReturn.MaxNoPay = MaxNoPay
                }
                
                if let TotalRemainingDefer = jsonObject["TotalRemainingDefer"].int {
                    JsonReturn.TotalRemainingDefer = TotalRemainingDefer
                }
                
                if let TotalUsedDefer = jsonObject["TotalUsedDefer"].int {
                    JsonReturn.TotalUsedDefer = TotalUsedDefer
                }
                
                if let TotalDefer = jsonObject["TotalDefer"].int {
                    JsonReturn.TotalDefer = TotalDefer
                }
                
                if let NextPaymentInstallment = jsonObject["NextPaymentInstallment"].double {
                    JsonReturn.NextPaymentInstallment = NextPaymentInstallment.roundTo(places: 2)
                }
                
                if let MinimumMonthlyOustanding = jsonObject["MinimumMonthlyOustanding"].double {
                    JsonReturn.MinimumMonthlyOustanding = MinimumMonthlyOustanding.roundTo(places: 2)
                }
                
                if let MinimumFortnightlyOutstanding = jsonObject["MinimumFortnightlyOutstanding"].double {
                    JsonReturn.MinimumFortnightlyOutstanding = MinimumFortnightlyOutstanding.roundTo(places: 2)
                }
                
                if let MinimumWeeklyOutstanding = jsonObject["MinimumWeeklyOutstanding"].double {
                    JsonReturn.MinimumWeeklyOutstanding = MinimumWeeklyOutstanding.roundTo(places: 2)
                }
                
                if let MerchantId = jsonObject["NTID"].string {
                    JsonReturn.MerchantId = MerchantId
                }
                
                if let ArrangementDebtor = jsonObject["ArrangementDebtor"].string {
                    JsonReturn.ArrangementDebtor = ArrangementDebtor
                }
                
                if let ClientName = jsonObject["ClientName"].string {
                    JsonReturn.ClientName = ClientName
                }
                
                if let ClientAcc = jsonObject["ClientAccNo"].string {
                    JsonReturn.ClientAcc = ClientAcc
                }
                
                if let IsExistingArrangement = jsonObject["IsExistingArrangement"].bool {
                    JsonReturn.IsExistingArrangement = IsExistingArrangement
                }
                
                if let IsCoBorrowers = jsonObject["IsCoBorrowers"].bool {
                    JsonReturn.IsCoBorrowers = IsCoBorrowers
                }
                
                if let IsExistingArrangementCC = jsonObject["IsExistingArrangementCC"].bool {
                    JsonReturn.IsExistingArrangementCC = IsExistingArrangementCC
                }
                
                if let IsExistingArrangementDD = jsonObject["IsExistingArrangementDD"].bool {
                    JsonReturn.IsExistingArrangementDD = IsExistingArrangementDD
                }
                
                if let IsAllowMonthlyInstallment = jsonObject["IsAllowMonthlyInstallment"].bool {
                    JsonReturn.IsAllowMonthlyInstallment = IsAllowMonthlyInstallment
                }
                
                if let tempHistoryList = jsonObject["HistoryInstalmentScheduleList"].arrayObject {
                    
                    let HistoryInstalmentScheduleList = JSONParser.parseHistoryPaymentTracker(tempHistoryList as NSArray)
                    
                    JsonReturn.HistoryInstalmentScheduleList = HistoryInstalmentScheduleList
                    
                }

                if let tempScheduleList = jsonObject["InstalmentScheduleList"].arrayObject {
                    
                    let InstalmentScheduleList = JSONParser.parseSchedulePaymentTracker(tempScheduleList as NSArray)
                    
                    JsonReturn.InstalmentScheduleList = InstalmentScheduleList
                    
                }
                
                if let coDebtorCode = jsonObject["CoDebtorCode"].arrayObject {
                    
                    let coDebtorCodeList = JSONParser.parseCoDebtorCode(coDebtorCode as NSArray)
                    
                    JsonReturn.coDebtorCode = coDebtorCodeList
                    
                }
                
                if let coFirstName = jsonObject["CoFirstName"].arrayObject {
                    
                    let coFirstNameList = JSONParser.parseCoDebtorCode(coFirstName as NSArray)
                    
                    JsonReturn.coFirstName = coFirstNameList
                    
                }
                
                if let coLastName = jsonObject["CoLastName"].arrayObject {
                    
                    let coLastNameList = JSONParser.parseCoDebtorCode(coLastName as NSArray)
                    
                    JsonReturn.coLastName = coLastNameList
                    
                }
                
                if let coMobileNumbers = jsonObject["CoMobileNumbers"].arrayObject {
                    
                    let coMobileNumbersList = JSONParser.parseCoDebtorCode(coMobileNumbers as NSArray)
                    
                    JsonReturn.coMobileNumbers = coMobileNumbersList
                    
                }
                
                if let coDriverLicenseNumber = jsonObject["CoDriverLicenseNumber"].arrayObject {
                    
                    let coDriverLicenseNumberList = JSONParser.parseCoDebtorCode(coDriverLicenseNumber as NSArray)
                    
                    JsonReturn.coDriverLicenses = coDriverLicenseNumberList
                }
                
                
                if(JsonReturn.IsCoBorrowers){
                    
                    for index in 0 ..< JsonReturn.coDebtorCode.count
                    {
                        
                        let coDebtor = CoDebtor()
                        
                        coDebtor.DebtorCode = JsonReturn.coDebtorCode[index]
                        coDebtor.FullName = JsonReturn.coFirstName[index] + " " + JsonReturn.coLastName[index]
                        coDebtor.FullName = coDebtor.FullName.trim()
                        coDebtor.Mobile = JsonReturn.coMobileNumbers[index].trim()
                        if(coDebtor.Mobile == "")
                        {
                            coDebtor.Mobile = "No Number"
                            coDebtor.MarkMobile = "No Number"
                        }
                        else{
                            
//                            let index2: String.Index = coDebtor.Mobile.startIndex.advancedBy(2)
//                            
//                            let index6: String.Index = coDebtor.Mobile.startIndex.advancedBy(6)
    
//                            coDebtor.MarkMobile = coDebtor.Mobile.substring(to: 2) + "XXXXX" + coDebtor.Mobile.substring(from: 6)
                            
                              coDebtor.MarkMobile = coDebtor.Mobile
                        }
                        
                        JsonReturn.coDebtor.append(coDebtor)
                    }
                    
                }
                
                
                if let Errors = jsonObject["Error"].string {
                    
                    let er = Error()
                    
                    er.ErrorMessage = Errors
                    
                    JsonReturn.Errors.append(er)
                    
                }
                
                if let Client = jsonObject["Client"].dictionaryObject {
                    
                    let ClientReturn = JSONParser.parseClient(Client as NSDictionary)
                    
                    JsonReturn.client = ClientReturn
                    
                }
                
                response (JsonReturn)
            }
            else
            {
                response (nil)
            }
            
        }
    }
    
    static func GetInboxItems(_ ReferenceNumber: String, response : @escaping (_ objectReturn : InboxItemList?) -> ()) {
        
        let urlString = LocalStore.accessWeb_URL_API()! + ResourcePath.getInboxItems.description
        
        let JsonReturn = InboxItemList()
        
        let parameters = [
            "Item": [
                "ReferenceNumber": ReferenceNumber
            ]
        ]
        
        
        Alamofire.request(urlString, method: .post, parameters : parameters  ,encoding: JSONEncoding.default).responseJSON {
            json in
            
            if let jsonReturn1 = json.result.value {
                
                let jsonObject = JSON(jsonReturn1)
                
                if let IsSuccess = jsonObject["IsSuccess"].bool {
                    
                    JsonReturn.IsSuccess = IsSuccess
                }
                
                if let tempHistoryList = jsonObject["InboxList"].arrayObject {
                    
                    let HistoryList = JSONParser.parseInboxList(tempHistoryList as NSArray)
                    
                    JsonReturn.InboxList = HistoryList
                    
                }

                if let Errors = jsonObject["Error"].string {
                    
                    let er = Error()
                    
                    er.ErrorMessage = Errors
                    
                    JsonReturn.Errors.append(er)
                    
                }
                
                response (JsonReturn)
            }
            else
            {
                response (nil)
            }
            
        }
    }
    static func GetDebtorPaymentHistory(_ ReferenceNumber: String, response : @escaping (_ objectReturn : DebtorInfo?) -> ()) {
        
        let urlString = LocalStore.accessWeb_URL_API()! + ResourcePath.getDebtorPaymentHistory.description
        
        let JsonReturn = DebtorInfo()
        
        let parameters = [
            "Item": [
                "ReferenceNumber": ReferenceNumber
            ]
        ]
        
        
        Alamofire.request(urlString, method: .post, parameters : parameters  ,encoding: JSONEncoding.default).responseJSON {
            json in
            
            if let jsonReturn1 = json.result.value {
                
                let jsonObject = JSON(jsonReturn1)
                
                if let IsSuccess = jsonObject["IsSuccess"].bool {
                    
                    JsonReturn.IsSuccess = IsSuccess
                }
                
                 if let tempHistoryList = jsonObject["HistoryInstalmentScheduleList"].arrayObject {
                
                       let HistoryInstalmentScheduleList = JSONParser.parseHistoryPaymentTracker(tempHistoryList as NSArray)
                
                        JsonReturn.HistoryInstalmentScheduleList = HistoryInstalmentScheduleList
                
                 }
                
                 if let tempScheduleList = jsonObject["InstalmentScheduleList"].arrayObject {
                
                       let InstalmentScheduleList = JSONParser.parseSchedulePaymentTracker(tempScheduleList as NSArray)
                
                       JsonReturn.InstalmentScheduleList = InstalmentScheduleList
                
                 }
                
                if let Errors = jsonObject["Error"].string {
                    
                    let er = Error()
                    
                    er.ErrorMessage = Errors
                    
                    JsonReturn.Errors.append(er)
                    
                }
                
                response (JsonReturn)
            }
            else
            {
                response (nil)
            }
            
        }
    }
    
    
    static func GetDebtorAdditonalInfo(_ ReferenceNumber: String, DebtorCode : String, response : @escaping (_ objectReturn : DebtorInfo?) -> ()) {
        
        let urlString = LocalStore.accessWeb_URL_API()! + ResourcePath.getDebtorAdditionalInfor.description
        
        let JsonReturn = DebtorInfo()
        
        let parameters = [
            "Item": [
                "ReferenceNumber": ReferenceNumber,
                "DebtorCode" : DebtorCode
            ]
        ]
        
        
        Alamofire.request(urlString, method: .post, parameters : parameters  ,encoding: JSONEncoding.default).responseJSON {
            json in
            
            if let jsonReturn1 = json.result.value {
                
                let jsonObject = JSON(jsonReturn1)
                
                if let IsSuccess = jsonObject["IsSuccess"].bool {
                    
                    JsonReturn.IsSuccess = IsSuccess
                }
                
                if let DateOfBirths = jsonObject["DateOfBirths"].string {
                    
                    JsonReturn.DateOfBirths = DateOfBirths
                }
                
                if let PostCode = jsonObject["PostCodes"].string {
                    
                    JsonReturn.PostCode = PostCode
                }
                
                
                if let Errors = jsonObject["Errors"].arrayObject {
                    
                    let ErrorsReturn = JSONParser.parseError(Errors as NSArray)
                    
                    JsonReturn.Errors = ErrorsReturn
                    
                }

                
                response (JsonReturn)
            }
            else
            {
                response (nil)
            }
            
        }
    }

    
    static func GetArrangmentDetail(_ ReferenceNumber: String, response : @escaping (_ objectReturn : ArrangeDetails?) -> ()) {
        
        let urlString = LocalStore.accessWeb_URL_API()! + ResourcePath.arrangeDetail.description
        
        let JsonReturn = ArrangeDetails()
        
        let parameters = [
            "Item": [
                "ReferenceNumber": ReferenceNumber
            ]
        ]
        
        
        Alamofire.request(urlString, method: .post, parameters : parameters  ,encoding: JSONEncoding.default).responseJSON {
            json in
            
            if let jsonReturn1 = json.result.value {
                
                let jsonObject = JSON(jsonReturn1)
                
                if let IsSuccess = jsonObject["IsSuccess"].bool {
                    
                    JsonReturn.IsSuccess = IsSuccess
                }
                
                if let ReferenceNumber = jsonObject["ReferenceNumber"].string {
                    JsonReturn.ReferenceNumber = ReferenceNumber
                }
                
                if let ArrangeAmount = jsonObject["ArrangeAmount"].float {
                    JsonReturn.ArrangeAmount = ArrangeAmount
                }
                
                if let Frequency = jsonObject["Frequency"].string {
                    JsonReturn.Frequency = Frequency
                }
                
                if let LeftToPay = jsonObject["LeftToPay"].float {
                    JsonReturn.LeftToPay = LeftToPay
                }
                
                if let NextInstalmentDate = jsonObject["NextInstalmentDate"].string {
                    JsonReturn.NextInstalmentDate = NextInstalmentDate
                }
                
                if let OverdueAmount = jsonObject["OverdueAmount"].float {
                    JsonReturn.OverdueAmount = OverdueAmount
                }
                
                if let PaidAmount = jsonObject["PaidAmount"].float {
                    JsonReturn.PaidAmount = PaidAmount
                }
                
                if let Status = jsonObject["Status"].string {
                    JsonReturn.Status = Status
                }
                
                if let Error = jsonObject["Error"].string {
                    JsonReturn.Error = Error
                }
                
                response (JsonReturn)
            }
            else
            {
                response (nil)
            }
            
        }
    }
    
    
    static func MakeCreditCardPayment(_ cardObject : CardInfo, PaymentType : Int ,response : @escaping (_ objectReturn : PaymentReturnModel?) -> ()) {
        
        let urlString = LocalStore.accessWeb_URL_API()! + ResourcePath.makeCreditCardPayment.description
        
        let JsonReturn = PaymentReturnModel()
        
        //Visa
        if(cardObject.CardType == 0 ){
            cardObject.CardType = 2
        }
        
        let parameters = [
            "Item": [
                "ReferenceNumber": LocalStore.accessRefNumber()!,
                "Amount": cardObject.Amount,
                "CardType": cardObject.CardType,
                "NameOnCard" : cardObject.NameOnCard,
                "CreditCardNumber": cardObject.CardNumber,
                "CreditCardExpiryYear": cardObject.ExpiryYear,
                "CreditCardExpiryMonth": cardObject.ExpiryMonth,
                "CreditCardCVV": cardObject.Cvv,
                "PaymentType": PaymentType,
                "PaymentMethod": "1",
                "DebtorPaymentInstallment" : cardObject.DebtorPaymentInstallment,
                "InstalmentPaymentFrequency" : LocalStore.accessFrequency()
            ]
        ]
        
        
        Alamofire.request(urlString, method: .post, parameters : parameters  ,encoding: JSONEncoding.default).responseJSON {
            json in
            
            if let jsonReturn1 = json.result.value {
                
                let jsonObject = JSON(jsonReturn1)

                if let IsSuccess = jsonObject["IsSuccess"].bool {
                    
                    JsonReturn.IsSuccess = IsSuccess
                }
                
                if let Errors = jsonObject["Errors"].arrayObject {
                    
                    let ErrorsReturn = JSONParser.parseError(Errors as NSArray)
                    
                    JsonReturn.Errors = ErrorsReturn
                }
                
                if let PaymentId = jsonObject["PaymentId"].int {
                    
                    JsonReturn.PaymentId = PaymentId
                }
                
                
                if let Name = jsonObject["Name"].string {
                    
                    JsonReturn.Name = Name
                }
                
                if let ClientName = jsonObject["ClientName"].string {
                    
                    JsonReturn.ClientName = ClientName
                }
                
                if let Date = jsonObject["Date"].string {
                    
                    JsonReturn.Date = Date
                }
                
                if let Time = jsonObject["Time"].string {
                    
                    JsonReturn.Time = Time
                }
                
                if let Amount = jsonObject["Amount"].string {
                    
                    JsonReturn.Amount = Amount
                }
                
                if let ReceiptNumber = jsonObject["ReceiptNumber"].string {
                    
                    JsonReturn.ReceiptNumber = ReceiptNumber
                }
                
                if let TransactionDescription = jsonObject["TransactionDescription"].string {
                    
                    JsonReturn.TransactionDescription = TransactionDescription
                }
                
                if let IsFuturePayment = jsonObject["IsFuturePayment"].bool {
                    
                    JsonReturn.IsFuturePayment = IsFuturePayment
                }
                
                response (JsonReturn)
            }
            else
            {
                response (nil)
            }
            
        }
    }
    
    static func MakeDebitPayment(_ cardObject : BankInfo, PaymentType : Int ,response : @escaping (_ objectReturn : PaymentReturnModel?) -> ()) {
        
        let urlString = LocalStore.accessWeb_URL_API()! + ResourcePath.makeDebitPayment.description
        
        let JsonReturn = PaymentReturnModel()
        

        let parameters = [
            "Item": [
                "ReferenceNumber": LocalStore.accessRefNumber()!,
                "Amount": cardObject.Amount,
                "DirectDebitAccountName" : cardObject.AccountName,
                "DirectDebitAccountNumber": cardObject.AccountNumber,
                "DirectDebitBSB1": cardObject.BSB1,
                "DirectDebitBSB2": cardObject.BSB2,
                "PaymentType": PaymentType,
                "PaymentMethod": "2",
                "DebtorPaymentInstallment" : cardObject.DebtorPaymentInstallment,
                "InstalmentPaymentFrequency" : LocalStore.accessFrequency()

            ]
        ]
        
        
        Alamofire.request(urlString, method: .post, parameters : parameters  ,encoding: JSONEncoding.default).responseJSON {
            json in
            
            if let jsonReturn1 = json.result.value {
                
                let jsonObject = JSON(jsonReturn1)
                
                if let IsSuccess = jsonObject["IsSuccess"].bool {
                    
                    JsonReturn.IsSuccess = IsSuccess
                }
                
                if let Errors = jsonObject["Errors"].arrayObject {
                    
                    let ErrorsReturn = JSONParser.parseError(Errors as NSArray)
                    
                    JsonReturn.Errors = ErrorsReturn
                }
                
                if let PaymentId = jsonObject["PaymentId"].int {
                    
                    JsonReturn.PaymentId = PaymentId
                }
                
                if let FirstDebtorPaymentInstallmentId = jsonObject["FirstDebtorPaymentInstallmentId"].int {
                    
                    JsonReturn.FirstDebtorPaymentInstallmentId = FirstDebtorPaymentInstallmentId
                }
                
                if let Name = jsonObject["Name"].string {
                    
                    JsonReturn.Name = Name
                }
                
                if let ClientName = jsonObject["ClientName"].string {
                    
                    JsonReturn.ClientName = ClientName
                }
                
                if let Date = jsonObject["Date"].string {
                    
                    JsonReturn.Date = Date
                }
                
                if let Time = jsonObject["Time"].string {
                    
                    JsonReturn.Time = Time
                }
                
                if let Amount = jsonObject["Amount"].string {
                    
                    JsonReturn.Amount = Amount
                }
                
                if let IsFuturePayment = jsonObject["IsFuturePayment"].bool {
                    
                    JsonReturn.IsFuturePayment = IsFuturePayment
                }

                response (JsonReturn)
            }
            else
            {
                response (nil)
            }
            
        }
    }
    
    static func RequestCallback(_ request:  RequestCallBack, response : @escaping (_ objectReturn : JsonReturnModel?) -> ()) {
        
        let urlString = LocalStore.accessWeb_URL_API()! + ResourcePath.requestCallback.description
        
        let JsonReturn = JsonReturnModel()
        
        let parameters = [
            "Item": [
                "ReferenceNumber": LocalStore.accessRefNumber()!,
                "Number": request.Phone,
                "Name": request.Name,
                "Date" : request.Date.formattedWith("dd/MM/yyyy"),
                "CallBackTimeSlot" : request.CallBackTimeSlotValue,
                "Notes" : request.Notes
            ]
        ]
        
        
        Alamofire.request(urlString, method: .post, parameters : parameters  ,encoding: JSONEncoding.default).responseJSON {
            json in
            
            if let jsonReturn1 = json.result.value {
                
                let jsonObject = JSON(jsonReturn1)
                
                
                if let IsSuccess = jsonObject["IsSuccess"].bool {
                    
                    JsonReturn.IsSuccess = IsSuccess
                    
                }
                
                if let Errors = jsonObject["Errors"].arrayObject {
                    
                    let ErrorsReturn = JSONParser.parseError(Errors as NSArray)
                    
                    JsonReturn.Errors = ErrorsReturn
                    
                }
                
                response (JsonReturn)
            }
            else
            {
                response (nil)
            }
            
        }
    }
    
    static func GetPaymentInfo(_ response : @escaping (_ objectReturn : PaymentInfo?) -> ()) {
        
        let urlString = LocalStore.accessWeb_URL_API()! + ResourcePath.getPaymentDetail.description
        
        let JsonReturn = PaymentInfo()
        
        let parameters = [
            "Item": [
                "ReferenceNumber": LocalStore.accessRefNumber()!,
                "Action": "G"
            ]
        ]
        
        
        Alamofire.request(urlString, method: .post, parameters : parameters  ,encoding: JSONEncoding.default).responseJSON {
            json in
            
            if let jsonReturn1 = json.result.value {
                
                let jsonObject = JSON(jsonReturn1)
                
                
                if let RecType = jsonObject["RecType"].string {
                    
                    JsonReturn.RecType = RecType
                    
                    if(JsonReturn.RecType == "CC")
                    {
                        JsonReturn.card = CardInfo()
                        
                        if let CcNo = jsonObject["CcNo"].string {
                            
                            JsonReturn.card.CardNumber = CcNo
                        }
                        
                        if let ExpireDate = jsonObject["ExpiryDate"].string {

                                let yyear : Int? = Int((ExpireDate as NSString).substring(from: 2))
                                let mmonth : Int? = Int((ExpireDate as NSString).substring(to: 2))

                                JsonReturn.card.ExpiryYear  =  yyear!
                                JsonReturn.card.ExpiryMonth  = mmonth!

                        }
                    }
                    else if(JsonReturn.RecType == "DD")
                    {
                        JsonReturn.bank = BankInfo()
                        
                        if let BSB = jsonObject["BsbNo"].string {
                            
                            JsonReturn.bank.BSB = BSB
                            
                            if(BSB.length > 0)
                            {
                                
                                let char: Character = "-"
                                if let idx = JsonReturn.bank.BSB.indexDistance(of: char) {
                                    JsonReturn.bank.BSB1 = (BSB as NSString).substring(to: idx)
                                    JsonReturn.bank.BSB2 = (BSB as NSString).substring(from: idx+1)
                                }
                                else {
                                    JsonReturn.bank.BSB1 = (BSB as NSString).substring(to: 3)
                                    JsonReturn.bank.BSB2 = (BSB as NSString).substring(from: 3)
                                }
                                
                                


                            }
                            
                        }
                        if let AccountNo = jsonObject["AccountNo"].string {
                            
                            JsonReturn.bank.AccountNumber = AccountNo
                        }
                        
                        if let AccountName = jsonObject["AccountName"].string {
                            
                            JsonReturn.bank.AccountName = AccountName
                        }
                        
                    }
                }
                
                
                if let IsSuccess = jsonObject["IsSuccess"].bool {
                    
                    JsonReturn.IsSuccess = IsSuccess
                    
                }

                if let Error = jsonObject["Error"].string {
                    
                    JsonReturn.Errors = Error
                    
                }
                
                response (JsonReturn)
            }
            else
            {
                response (nil)
            }
            
        }
    }

    static func SetPaymentInfo(_ paymentInfo: PaymentInfo, response : @escaping (_ objectReturn : PaymentInfo?) -> ()) {
        
        let urlString = LocalStore.accessWeb_URL_API()! + ResourcePath.getPaymentDetail.description
        
        let JsonReturn = PaymentInfo()
        
        let month = paymentInfo.card.ExpiryMonth
        
        var monthString = ""
        
        if(month < 10)
        {
            monthString = "0" + month.description
        }
        else
        {
            monthString = month.description

        }
        
        let parameters = [
            "Item": [
                "ReferenceNumber": LocalStore.accessRefNumber()!,
                "Action": "U",
                "RecType": paymentInfo.RecType,
                "CcNo" : paymentInfo.card.CardNumber,
                "ExpiryDate" : monthString + paymentInfo.card.ExpiryYear.description,
                "BsbNo" : paymentInfo.bank.BSB,
                "AccountNo" : paymentInfo.bank.AccountNumber,
                "AccountName" : paymentInfo.bank.AccountName
            ]
        ]
        
        
        Alamofire.request(urlString, method: .post, parameters : parameters  ,encoding: JSONEncoding.default).responseJSON {
            json in
            
            if let jsonReturn1 = json.result.value {
                
                let jsonObject = JSON(jsonReturn1)
                
                
                if let IsSuccess = jsonObject["IsSuccess"].bool {
                    
                    JsonReturn.IsSuccess = IsSuccess
                    
                }
                
                if let Error = jsonObject["Error"].string {
                    
                    JsonReturn.Errors = Error
                    
                }
                
                response (JsonReturn)
            }
            else
            {
                response (nil)
            }
            
        }
    }
    
    static func GetPersonalInfo(_ response : @escaping (_ objectReturn : PaymentInfo?) -> ()) {
        
        let urlString = LocalStore.accessWeb_URL_API()! + ResourcePath.getPersonalInformationDetail.description
        
        let JsonReturn = PaymentInfo()
        
        let parameters = [
            "Item": [
                "ReferenceNumber": LocalStore.accessRefNumber()!,
                "DebtorCode" : LocalStore.accessDRCode()!,
                "Action": "G"
            ]
        ]
        
        
        Alamofire.request(urlString, method: .post, parameters : parameters  ,encoding: JSONEncoding.default).responseJSON {
            json in
            
            if let jsonReturn1 = json.result.value {
                
                let jsonObject = JSON(jsonReturn1)
                
                if let StreetAddress = jsonObject["Address1s"].string {
                    
                    JsonReturn.personalInfo.StreetAddress = StreetAddress
                }
                
                if let MailAddress = jsonObject["Address2s"].string {
                    
                    JsonReturn.personalInfo.MailAddress = MailAddress
                }
                
                if let HomeNumber = jsonObject["HomeNumber"].string {
                    
                    JsonReturn.personalInfo.HomePhone = HomeNumber
                }
                
                if let WorkNumber = jsonObject["WorkNumber"].string {
                    
                    JsonReturn.personalInfo.WorkPhone = WorkNumber
                }
                
                if let MobileNumbers = jsonObject["MobileNumbers"].string {
                    
                    JsonReturn.personalInfo.MobilePhone = MobileNumbers
                }
                
                if let EmailAddress = jsonObject["EmailAddress"].string {
                    
                    JsonReturn.personalInfo.EmailAddress = EmailAddress
                }
                
                if let HomePhonePreferred = jsonObject["HomePhonePreferred"].bool {
                    
                    JsonReturn.personalInfo.HomePhonePreferred = HomePhonePreferred
                    
                }
                
                if let WorkPhonePreferred = jsonObject["WorkPhonePreferred"].bool {
                    
                    JsonReturn.personalInfo.WorkPhonePreferred = WorkPhonePreferred
                    
                }
                
                if let MobilePhonePreferred = jsonObject["MobilePhonePreferred"].bool {
                    
                    JsonReturn.personalInfo.MobilePhonePreferred = MobilePhonePreferred
                    
                }
                
                if let IsSuccess = jsonObject["IsSuccess"].bool {
                    
                    JsonReturn.IsSuccess = IsSuccess
                    
                }

                
                if let Error = jsonObject["Error"].string {
                    
                    JsonReturn.Errors = Error
                    
                }
                
                response (JsonReturn)
            }
            else
            {
                response (nil)
            }
            
        }
    }
    
    static func SetPersonalInfo(_ personalInfo: PersonalInfo, response : @escaping (_ objectReturn : PaymentInfo?) -> ()) {
        
        let urlString = LocalStore.accessWeb_URL_API()! + ResourcePath.getPersonalInformationDetail.description
        
        let JsonReturn = PaymentInfo()
        
        let parameters = [
            "Item": [
                "ReferenceNumber": LocalStore.accessRefNumber()!,
                "DebtorCode" : LocalStore.accessDRCode()!,
                "Action": "U",
                "Address1s" : personalInfo.StreetAddress,
                "Address2s" : personalInfo.MailAddress,
                "EmailAddress"     : personalInfo.EmailAddress,
                "HomeNumber" : personalInfo.HomePhone,
                "HomePhonePreferred" : personalInfo.HomePhonePreferred,
                "WorkNumber" : personalInfo.WorkPhone,
                "WorkPhonePreferred" : personalInfo.WorkPhonePreferred,
                "MobileNumbers" : personalInfo.MobilePhone,
                "MobilePhonePreferred" : personalInfo.MobilePhonePreferred

            ]
        ]
        
        
        Alamofire.request(urlString, method: .post, parameters : parameters  ,encoding: JSONEncoding.default).responseJSON {
            json in
            
            if let jsonReturn1 = json.result.value {
                
                let jsonObject = JSON(jsonReturn1)
                
                
                if let IsSuccess = jsonObject["IsSuccess"].bool {
                    
                    JsonReturn.IsSuccess = IsSuccess
                    
                }
                
                if let Error = jsonObject["Error"].string {
                    
                    JsonReturn.Errors = Error
                    
                }
                
                response (JsonReturn)
            }
            else
            {
                response (nil)
            }
            
        }
    }
    
    static func SendFeedback(_ object: Feedback, response : @escaping (_ objectReturn : JsonReturnModel?) -> ()) {
        
        let urlString = LocalStore.accessWeb_URL_API()! + ResourcePath.sendFeedback.description
        
        let JsonReturn = JsonReturnModel()
        
        let parameters = [
            "Item": [
                "ReferenceNumber": LocalStore.accessRefNumber()!,
                "Subject" : object.Subject,
                "Content" : object.Content
            ]
        ]
        
        
        Alamofire.request(urlString, method: .post, parameters : parameters  ,encoding: JSONEncoding.default).responseJSON {
            json in
            
            if let jsonReturn1 = json.result.value {
                
                let jsonObject = JSON(jsonReturn1)
                
                
                if let IsSuccess = jsonObject["IsSuccess"].bool {
                    
                    JsonReturn.IsSuccess = IsSuccess
                    
                }
                
                if let Errors = jsonObject["Errors"].arrayObject {
                    
                    let ErrorsReturn = JSONParser.parseError(Errors as NSArray)
                    
                    JsonReturn.Errors = ErrorsReturn
                    
                }
                
                response (JsonReturn)
            }
            else
            {
                response (nil)
            }
            
        }
    }
    
    static func SendDeferPayment(_ object: DeferPayment, response : @escaping (_ objectReturn : JsonReturnModel?) -> ()) {
        
        let urlString = LocalStore.accessWeb_URL_API()! + ResourcePath.deferPayment.description
        
        let JsonReturn = JsonReturnModel()
        
        let parameters = [
            "Item": [
                "ReferenceNumber": LocalStore.accessRefNumber()!,
                "InstalDate" : object.InstalDate,
                "Amount" : object.Amount
            ]
        ]
        
        
        Alamofire.request(urlString, method: .post, parameters : parameters  ,encoding: JSONEncoding.default).responseJSON {
            json in
            
            if let jsonReturn1 = json.result.value {
                
                let jsonObject = JSON(jsonReturn1)
                
                
                if let IsSuccess = jsonObject["IsSuccess"].bool {
                    
                    JsonReturn.IsSuccess = IsSuccess
                    
                }
                
                if let Errors = jsonObject["Errors"].arrayObject {
                    
                    let ErrorsReturn = JSONParser.parseError(Errors as NSArray)
                    
                    JsonReturn.Errors = ErrorsReturn
                    
                }
                
                response (JsonReturn)
            }
            else
            {
                response (nil)
            }
            
        }
    }
    
    static func sendAppDetail(_ ReferenceNumber: String, PinNumber: String, DeviceToken: String, response : @escaping (_ objectReturn : JsonReturnModel?) -> ()) {
        
        let urlString = LocalStore.accessWeb_URL_API()! + ResourcePath.sendAppDetails.description
        
        let JsonReturn = JsonReturnModel()
        
        let parameters = [
            "Item": [
                "ReferenceNumber": ReferenceNumber,
                "PinNumber": PinNumber,
                "DeviceToken": DeviceToken,
                "DeviceType" : "Ios"
            ]
        ]
        
        
        Alamofire.request(urlString, method: .post, parameters : parameters  ,encoding: JSONEncoding.default).responseJSON {
            json in
            
            if let jsonReturn1 = json.result.value {
                
                let jsonObject = JSON(jsonReturn1)
                
                
                if let IsSuccess = jsonObject["IsSuccess"].bool {
                    
                    JsonReturn.IsSuccess = IsSuccess
                    
                }
                
                if let Errors = jsonObject["Errors"].arrayObject {
                    
                    let ErrorsReturn = JSONParser.parseError(Errors as NSArray)
                    
                    JsonReturn.Errors = ErrorsReturn
                    
                }
                
                response (JsonReturn)
            }
            else
            {
                response (nil)
            }
            
        }
    }
    
    static func getInboxItemMessage(_ ReferenceNumber: String, MessageNo: String, response : @escaping (_ objectReturn : String?) -> ()) {
        
        let urlString = LocalStore.accessWeb_URL_API()! + ResourcePath.getInboxItemMessage.description
        
        let JsonReturn = ""
        
        let parameters = [
            "Item": [
                "ReferenceNumber": ReferenceNumber,
                "MessageNo": MessageNo
            ]
        ]
        
        
        Alamofire.request(urlString, method: .post, parameters : parameters  ,encoding: JSONEncoding.default).responseJSON {
            json in
            
            if let jsonReturn1 = json.result.value {
                
                let jsonObject = JSON(jsonReturn1)
                
                
                response (jsonObject.description)
            }
            else
            {
                response (nil)
            }
            
        }
    }
    
    static func sendActivityTracking(_ Activity: String) {
        
        let urlString = LocalStore.accessWeb_URL_API()! + ResourcePath.sendActivityTracking.description
        
        let parameters = [
                "ReferenceNumber": LocalStore.accessRefNumber()!,
                "From" : "Ios",
                "Activity" : Activity
        ]
        
        Alamofire.request(urlString, method: .post, parameters : parameters  ,encoding: JSONEncoding.default)
    }
    
    static func GetCallBackTime(_ ReferenceNumber: String, CallbackDate : String, CallbackTimeSlot : String, response : @escaping (_ objectReturn : CallBackItem?) -> ()) {
        
        let urlString = LocalStore.accessWeb_URL_API()! + ResourcePath.getCallBackTime.description
        
        let JsonReturn = CallBackItem()
        
        let parameters = [
            "Item": [
                "ReferenceNumber": ReferenceNumber,
                "CallbackDate" : CallbackDate,
                "CallbackTimeSlot" : CallbackTimeSlot
            ]
        ]
        
        
        Alamofire.request(urlString, method: .post, parameters : parameters  ,encoding: JSONEncoding.default).responseJSON {
            json in
            
            if let jsonReturn1 = json.result.value {
                
                let jsonObject = JSON(jsonReturn1)
                
                if let IsSuccess = jsonObject["IsSuccess"].bool {
                    
                    JsonReturn.IsSuccess = IsSuccess
                }
                
                if let temp = jsonObject["CallbackSlot"].arrayObject {
                    
                    let tempList = JSONParser.parseCallbackList(temp as NSArray)
                    
                    JsonReturn.CallbackSlot = tempList
                    
                }
                
                if let Errors = jsonObject["Error"].string {
                    
                    let er = Error()
                    
                    er.ErrorMessage = Errors
                    
                    JsonReturn.Errors.append(er)
                    
                }
                
                response (JsonReturn)
            }
            else
            {
                response (nil)
            }
            
        }
    }


}

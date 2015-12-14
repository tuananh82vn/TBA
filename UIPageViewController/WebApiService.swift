
import Alamofire
import SystemConfiguration

struct WebApiService {

    
    private enum ResourcePath: CustomStringConvertible {
        case Verify
        case GetNetCode
        case VerifyNetCode
        case GetDebtorInfo
        case MakeCreditCardPayment
        case MakeDebitPayment
        case EmailReceipt
        case RequestCallback
        case GetPaymentDetail
        
        var description: String {
            switch self {
                case .Verify: return "/Api/Verify"
                case .GetNetCode: return "/Api/GetNetCode"
                case .VerifyNetCode: return "/Api/VerifyNetCode"
                case .GetDebtorInfo: return "/Api/GetDebtorInfo"
                case .MakeCreditCardPayment: return "/Api/MakeCreditCardPayment"
                case .MakeDebitPayment: return "/Api/MakeDebitPayment"
                case .EmailReceipt: return "/Api/EmailReceipt"
                case .RequestCallback: return "/Api/RequestCallback"
                case .GetPaymentDetail: return "/Api/GetPaymentDetail"
            }
        }
    }
    
    static func postVerify(domain: String,  response : (objectReturn : JsonReturnModel?) -> ()) {
        
        let urlString = domain + ResourcePath.Verify.description
        
        
        let JsonReturn = JsonReturnModel()
        
        Alamofire.request(.POST, urlString, parameters: nil, encoding: .JSON).responseJSON {
            json in
            
            if let jsonReturn1 = json.result.value {
                
                let jsonObject = JSON(jsonReturn1)
                
                
                if let IsSuccess = jsonObject["IsSuccess"].bool {
                    
                    JsonReturn.IsSuccess = IsSuccess
                    
                }
                
                if let Errors = jsonObject["Errors"].arrayObject {
                    
                    let ErrorsReturn = JSONParser.parseError(Errors)
                    
                    JsonReturn.Errors = ErrorsReturn
                    
                }
                
                response (objectReturn : JsonReturn)
            }
            else
            {
                response (objectReturn : nil)
            }
            
        }

        
    }


    static func checkInternet(completionHandler:(internet:Bool) -> Void){
        
        var internet = false
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(&zeroAddress) {
            SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            completionHandler(internet: internet)
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
    
        internet =  (isReachable && !needsConnection)

        completionHandler(internet: internet)
    
    }
    
    static func getNetCode(ReferenceNumber: String,  response : (objectReturn : JsonReturnModel?) -> ()) {
        
        let urlString = LocalStore.accessWeb_URL_API()! + ResourcePath.GetNetCode.description
        
        let JsonReturn = JsonReturnModel()
        
        let parameters = [
            "Item": [
                "ReferenceNumber": ReferenceNumber
            ]
        ]
        
        
        Alamofire.request(.POST, urlString, parameters: parameters, encoding: .JSON).responseJSON {
            json in
            
            if let jsonReturn1 = json.result.value {
                
                let jsonObject = JSON(jsonReturn1)
                
                
                if let IsSuccess = jsonObject["IsSuccess"].bool {
                    
                    JsonReturn.IsSuccess = IsSuccess
                    
                }
                
                if let Errors = jsonObject["Errors"].arrayObject {
                    
                    let ErrorsReturn = JSONParser.parseError(Errors)
                    
                    JsonReturn.Errors = ErrorsReturn
                    
                }
                
                response (objectReturn : JsonReturn)
            }
            else
            {
                response (objectReturn : nil)
            }
            
        }

    }
    
    static func verifyNetCode(ReferenceNumber: String, Netcode: String, response : (objectReturn : JsonReturnModel?) -> ()) {
        
        let urlString = LocalStore.accessWeb_URL_API()! + ResourcePath.VerifyNetCode.description
        
        let JsonReturn = JsonReturnModel()
        
        let parameters = [
            "Item": [
                "ReferenceNumber": ReferenceNumber,
                "Netcode": Netcode
            ]
        ]
        
        
        Alamofire.request(.POST, urlString, parameters: parameters, encoding: .JSON).responseJSON {
            json in
            
            if let jsonReturn1 = json.result.value {
                
                let jsonObject = JSON(jsonReturn1)
                
                
                if let IsSuccess = jsonObject["IsSuccess"].bool {
                    
                    JsonReturn.IsSuccess = IsSuccess
                    
                }
                
                if let Errors = jsonObject["Errors"].arrayObject {
                    
                    let ErrorsReturn = JSONParser.parseError(Errors)
                    
                    JsonReturn.Errors = ErrorsReturn
                    
                }
                
                response (objectReturn : JsonReturn)
            }
            else
            {
                response (objectReturn : nil)
            }
            
        }
    }
    
    static func emailReceipt(debtorInfo:  DebtorInfo, response : (objectReturn : JsonReturnModel?) -> ()) {
        
        let urlString = LocalStore.accessWeb_URL_API()! + ResourcePath.EmailReceipt.description
        
        let JsonReturn = JsonReturnModel()
        
        let parameters = [
            "Item": [
                "Name": debtorInfo.Name,
                "CurrentPaymentId": debtorInfo.CurrentPaymentId,
                "ClientName" : debtorInfo.ClientName,
                "PaymentType" : debtorInfo.PaymentType,
                "EmailAddress" : debtorInfo.EmailAddress
            ]
        ]
        
        
        Alamofire.request(.POST, urlString, parameters: parameters, encoding: .JSON).responseJSON {
            json in
            
            if let jsonReturn1 = json.result.value {
                
                let jsonObject = JSON(jsonReturn1)
                
                
                if let IsSuccess = jsonObject["IsSuccess"].bool {
                    
                    JsonReturn.IsSuccess = IsSuccess
                    
                }
                
                if let Errors = jsonObject["Errors"].arrayObject {
                    
                    let ErrorsReturn = JSONParser.parseError(Errors)
                    
                    JsonReturn.Errors = ErrorsReturn
                    
                }
                
                response (objectReturn : JsonReturn)
            }
            else
            {
                response (objectReturn : nil)
            }
            
        }
    }

    
    
    
    static func GetDebtorInfo(ReferenceNumber: String, response : (objectReturn : DebtorInfo?) -> ()) {
        
        let urlString = LocalStore.accessWeb_URL_API()! + ResourcePath.GetDebtorInfo.description
        
        let JsonReturn = DebtorInfo()
        
        let parameters = [
            "Item": [
                "ReferenceNumber": ReferenceNumber
            ]
        ]
        
        
        Alamofire.request(.POST, urlString, parameters: parameters, encoding: .JSON).responseJSON {
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
                if let DebtorCode = jsonObject["DebtorCode"].string {
                    JsonReturn.DebtorCode = DebtorCode
                }
                if let TotalOutstanding = jsonObject["TotalOutstanding"].float {
                    JsonReturn.TotalOutstanding = TotalOutstanding
                }
                if let NextPaymentInstallmentAmount = jsonObject["NextPaymentInstallmentAmount"].string {
                    JsonReturn.NextPaymentInstallmentAmount = NextPaymentInstallmentAmount
                }
                if let MerchantId = jsonObject["NTID"].string {
                    JsonReturn.MerchantId = MerchantId
                }
                
                if let Errors = jsonObject["Errors"].arrayObject {
                    
                    let ErrorsReturn = JSONParser.parseError(Errors)
                    
                    JsonReturn.Errors = ErrorsReturn
                    
                }
                
                response (objectReturn : JsonReturn)
            }
            else
            {
                response (objectReturn : nil)
            }
            
        }
    }
    
    
    static func MakeCreditCardPayment(cardObject : CardInfo, PaymentType : Int ,response : (objectReturn : PaymentReturnModel?) -> ()) {
        
        let urlString = LocalStore.accessWeb_URL_API()! + ResourcePath.MakeCreditCardPayment.description
        
        let JsonReturn = PaymentReturnModel()
        
        let calendar = NSCalendar.currentCalendar()
        
        let componentsYear = calendar.components(NSCalendarUnit.Year, fromDate: cardObject.ExpiryDate)
        let year =  componentsYear.year
        
        
        let componentsMonth = calendar.components(NSCalendarUnit.Month, fromDate: cardObject.ExpiryDate)
        let month =  componentsMonth.month
        
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
                "CreditCardExpiryYear": year.description,
                "CreditCardExpiryMonth": month.description,
                "CreditCardCVV": cardObject.Cvv,
                "PaymentType": PaymentType,
                "PaymentMethod": "1"
            ]
        ]
        
        
        Alamofire.request(.POST, urlString, parameters: parameters, encoding: .JSON).responseJSON {
            json in
            
            if let jsonReturn1 = json.result.value {
                
                let jsonObject = JSON(jsonReturn1)

                if let IsSuccess = jsonObject["IsSuccess"].bool {
                    
                    JsonReturn.IsSuccess = IsSuccess
                }
                
                if let Errors = jsonObject["Errors"].arrayObject {
                    
                    let ErrorsReturn = JSONParser.parseError(Errors)
                    
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
                
                response (objectReturn : JsonReturn)
            }
            else
            {
                response (objectReturn : nil)
            }
            
        }
    }
    
    static func MakeDebitPayment(cardObject : BankInfo, PaymentType : Int ,response : (objectReturn : PaymentReturnModel?) -> ()) {
        
        let urlString = LocalStore.accessWeb_URL_API()! + ResourcePath.MakeDebitPayment.description
        
        let JsonReturn = PaymentReturnModel()
        

        let parameters = [
            "Item": [
                "ReferenceNumber": LocalStore.accessRefNumber()!,
                "Amount": cardObject.Amount,
                "DirectDebitAccountName" : cardObject.AccountName,
                "DirectDebitAccountNumber": cardObject.AccountNumber,
                "DirectDebitBSB1": cardObject.Bsb1,
                "DirectDebitBSB2": cardObject.Bsb2,
                "PaymentType": PaymentType,
                "PaymentMethod": "2"
            ]
        ]
        
        
        Alamofire.request(.POST, urlString, parameters: parameters, encoding: .JSON).responseJSON {
            json in
            
            if let jsonReturn1 = json.result.value {
                
                let jsonObject = JSON(jsonReturn1)
                
                if let IsSuccess = jsonObject["IsSuccess"].bool {
                    
                    JsonReturn.IsSuccess = IsSuccess
                }
                
                if let Errors = jsonObject["Errors"].arrayObject {
                    
                    let ErrorsReturn = JSONParser.parseError(Errors)
                    
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

                response (objectReturn : JsonReturn)
            }
            else
            {
                response (objectReturn : nil)
            }
            
        }
    }
    
    static func RequestCallback(request:  RequestCallBackForm, response : (objectReturn : JsonReturnModel?) -> ()) {
        
        let urlString = LocalStore.accessWeb_URL_API()! + ResourcePath.RequestCallback.description
        
        let JsonReturn = JsonReturnModel()
        
        let parameters = [
            "Item": [
                "ReferenceNumber": LocalStore.accessRefNumber()!,
                "Name": request.Name,
                "Date" : request.Date.formattedWith("dd/MM/yyyy"),
                "TimeFrom" : request.TimeFrom.formattedWith("HH:mm"),
                "TimeTo" : request.TimeTo.formattedWith("HH:mm"),
                "Notes" : request.Notes
            ]
        ]
        
        
        Alamofire.request(.POST, urlString, parameters: parameters, encoding: .JSON).responseJSON {
            json in
            
            if let jsonReturn1 = json.result.value {
                
                let jsonObject = JSON(jsonReturn1)
                
                
                if let IsSuccess = jsonObject["IsSuccess"].bool {
                    
                    JsonReturn.IsSuccess = IsSuccess
                    
                }
                
                if let Errors = jsonObject["Errors"].arrayObject {
                    
                    let ErrorsReturn = JSONParser.parseError(Errors)
                    
                    JsonReturn.Errors = ErrorsReturn
                    
                }
                
                response (objectReturn : JsonReturn)
            }
            else
            {
                response (objectReturn : nil)
            }
            
        }
    }
    
    static func GetCreditCardInfo(response : (objectReturn : CardInfo?) -> ()) {
        
        let urlString = LocalStore.accessWeb_URL_API()! + ResourcePath.GetPaymentDetail.description
        
        let JsonReturn = CardInfo()
        
        let parameters = [
            "Item": [
                "ReferenceNumber": LocalStore.accessRefNumber()!
            ]
        ]
        
        
        Alamofire.request(.POST, urlString, parameters: parameters, encoding: .JSON).responseJSON {
            json in
            
            if let jsonReturn1 = json.result.value {
                
                let jsonObject = JSON(jsonReturn1)
                
                
                if let NameOnCard = jsonObject["Amount"].string {
                    
                    JsonReturn.NameOnCard = NameOnCard
                }
                
                if let CardNumber = jsonObject["CardNumber"].string {
                    
                    JsonReturn.CardNumber = CardNumber
                }
                
//                if let ExpiryDate = jsonObject["ExpiryDate"].string {
//                    
//                    JsonReturn.Date = ExpiryDate
//                }
                
//                if let IsSuccess = jsonObject["IsSuccess"].bool {
//                    
//                    JsonReturn.IsSuccess = IsSuccess
//                    
//                }
//                
//                if let Errors = jsonObject["Errors"].arrayObject {
//                    
//                    let ErrorsReturn = JSONParser.parseError(Errors)
//                    
//                    JsonReturn.Errors = ErrorsReturn
//                    
//                }
                
                response (objectReturn : JsonReturn)
            }
            else
            {
                response (objectReturn : nil)
            }
            
        }
    }


}

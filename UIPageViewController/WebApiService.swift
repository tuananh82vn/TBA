
import Alamofire
import SystemConfiguration

struct WebApiService {

    
    private enum ResourcePath: CustomStringConvertible {
        case Verify
        case GetNetCode
        case GetNetCodeVerify
        case VerifyNetCode
        case GetDebtorInfo
        case ValidateCreditCard
        case MakeCreditCardPayment
        case MakeDebitPayment
        case EmailReceipt
        case RequestCallback
        case GetPaymentDetail
        case GetPersonalInformationDetail
        case SendFeedback
        case ArrangeDetail
        case DeferPayment
        case GetDebtorAdditionalInfor
        case GetDebtorPaymentHistory

        var description: String {
            switch self {
                case .Verify: return "/Api/Verify"
                case .GetNetCode: return "/Api/GetNetCode"
                case .GetNetCodeVerify: return "/Api/GetNetCodeVerify"
                case .VerifyNetCode: return "/Api/VerifyNetCode"
                case .GetDebtorInfo: return "/Api/GetDebtorInfo"
                case .GetDebtorAdditionalInfor: return "/Api/GetDebtorAdditionalInfor"

                case .ValidateCreditCard: return "/Api/ValidateCreditCard"
                case .MakeCreditCardPayment: return "/Api/MakeCreditCardPayment"
                case .MakeDebitPayment: return "/Api/MakeDebitPayment"
                case .EmailReceipt: return "/Api/EmailReceipt"
                case .RequestCallback: return "/Api/RequestCallback"
                case .GetPaymentDetail: return "/Api/GetPaymentDetail"
                case .GetPersonalInformationDetail: return "/Api/GetPersonalInformationDetail"
                case .SendFeedback: return "/Api/SendFeedback"
                case .ArrangeDetail: return "/Api/GetArrangeDetails"
                case .DeferPayment : return "/Api/DeferPayment"
                case .GetDebtorPaymentHistory : return "/Api/GetDebtorPaymentHistory"

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
    
    static func getNetCodeVerify(ReferenceNumber: String, MobileNumber: String,  response : (objectReturn : JsonReturnModel?) -> ()) {
        
        let urlString = LocalStore.accessWeb_URL_API()! + ResourcePath.GetNetCodeVerify.description
        
        let JsonReturn = JsonReturnModel()
        
        let parameters = [
            "Item": [
                "ReferenceNumber": ReferenceNumber,
                "MobileNumbers": MobileNumber
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
    
    static func validateCreditCard(CardNumber: String, CardType: Int, response : (objectReturn : JsonReturnModel?) -> ()) {
        
        let urlString = LocalStore.accessWeb_URL_API()! + ResourcePath.ValidateCreditCard.description
        
        let JsonReturn = JsonReturnModel()
        
        let parameters = [
            "Item": [
                "CardType": CardType,
                "CreditCardNumber": CardNumber
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
                "EmailAddress" : debtorInfo.EmailAddress,
                "PaymentMethod" : debtorInfo.PaymentMethod
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
                    JsonReturn.DRCode = DebtorCode
                }

                if let TotalOutstanding = jsonObject["TotalOutstanding"].double {
                    JsonReturn.TotalOutstanding = TotalOutstanding.roundToPlaces(2)
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
                    JsonReturn.NextPaymentInstallment = NextPaymentInstallment.roundToPlaces(2)
                }
                
                if let MinimumMonthlyOustanding = jsonObject["MinimumMonthlyOustanding"].double {
                    JsonReturn.MinimumMonthlyOustanding = MinimumMonthlyOustanding.roundToPlaces(2)
                }
                
                if let MinimumFortnightlyOutstanding = jsonObject["MinimumFortnightlyOutstanding"].double {
                    JsonReturn.MinimumFortnightlyOutstanding = MinimumFortnightlyOutstanding.roundToPlaces(2)
                }
                
                if let MinimumWeeklyOutstanding = jsonObject["MinimumWeeklyOutstanding"].double {
                    JsonReturn.MinimumWeeklyOutstanding = MinimumWeeklyOutstanding.roundToPlaces(2)
                }
                
                if let MerchantId = jsonObject["NTID"].string {
                    JsonReturn.MerchantId = MerchantId
                }
                
                if let ArrangementDebtor = jsonObject["ArrangementDebtor"].string {
                    JsonReturn.ArrangementDebtor = ArrangementDebtor
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
                
//                if let tempHistoryList = jsonObject["HistoryInstalmentScheduleList"].arrayObject {
//                    
//                    let HistoryList = JSONParser.parseHistoryPaymentTracker(tempHistoryList)
//                    
//                    JsonReturn.HistoryList = HistoryList
//                    
//                }
//                
//                if let tempScheduleList = jsonObject["InstalmentScheduleList"].arrayObject {
//                    
//                    let ScheduleList = JSONParser.parseSchedulePaymentTracker(tempScheduleList)
//                    
//                    JsonReturn.ScheduleList = ScheduleList
//                    
//                }
                
                if let coDebtorCode = jsonObject["CoDebtorCode"].arrayObject {
                    
                    let coDebtorCodeList = JSONParser.parseCoDebtorCode(coDebtorCode)
                    
                    JsonReturn.coDebtorCode = coDebtorCodeList
                    
                }
                
                if let coFirstName = jsonObject["CoFirstName"].arrayObject {
                    
                    let coFirstNameList = JSONParser.parseCoDebtorCode(coFirstName)
                    
                    JsonReturn.coFirstName = coFirstNameList
                    
                }
                
                if let coLastName = jsonObject["CoLastName"].arrayObject {
                    
                    let coLastNameList = JSONParser.parseCoDebtorCode(coLastName)
                    
                    JsonReturn.coLastName = coLastNameList
                    
                }
                
                if let coMobileNumbers = jsonObject["CoMobileNumbers"].arrayObject {
                    
                    let coMobileNumbersList = JSONParser.parseCoDebtorCode(coMobileNumbers)
                    
                    JsonReturn.coMobileNumbers = coMobileNumbersList
                    
                }
                
                if let coDriverLicenseNumber = jsonObject["CoDriverLicenseNumber"].arrayObject {
                    
                    let coDriverLicenseNumberList = JSONParser.parseCoDebtorCode(coDriverLicenseNumber)
                    
                    JsonReturn.coDriverLicenses = coDriverLicenseNumberList
                }
                
                
                if(JsonReturn.IsCoBorrowers){
                    
                    for var index = 0; index < JsonReturn.coDebtorCode.count; ++index {
                        
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
                            
                            let index2: String.Index = coDebtor.Mobile.startIndex.advancedBy(2)
                            
                            let index6: String.Index = coDebtor.Mobile.startIndex.advancedBy(6)
    
                            coDebtor.MarkMobile = coDebtor.Mobile.substringToIndex(index2) + "XXXXX" + coDebtor.Mobile.substringFromIndex(index6)
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
                    
                    let ClientReturn = JSONParser.parseClient(Client)
                    
                    JsonReturn.client = ClientReturn
                    
                }
                
                response (objectReturn : JsonReturn)
            }
            else
            {
                response (objectReturn : nil)
            }
            
        }
    }
    
    
    static func GetDebtorPaymentHistory(ReferenceNumber: String, response : (objectReturn : DebtorInfo?) -> ()) {
        
        let urlString = LocalStore.accessWeb_URL_API()! + ResourcePath.GetDebtorPaymentHistory.description
        
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
                
                 if let tempHistoryList = jsonObject["HistoryInstalmentScheduleList"].arrayObject {
                
                       let HistoryList = JSONParser.parseHistoryPaymentTracker(tempHistoryList)
                
                        JsonReturn.HistoryList = HistoryList
                
                 }
                
                 if let tempScheduleList = jsonObject["InstalmentScheduleList"].arrayObject {
                
                       let ScheduleList = JSONParser.parseSchedulePaymentTracker(tempScheduleList)
                
                       JsonReturn.ScheduleList = ScheduleList
                
                 }
                
                if let Errors = jsonObject["Error"].string {
                    
                    let er = Error()
                    
                    er.ErrorMessage = Errors
                    
                    JsonReturn.Errors.append(er)
                    
                }
                
                response (objectReturn : JsonReturn)
            }
            else
            {
                response (objectReturn : nil)
            }
            
        }
    }
    
    
    static func GetDebtorAdditonalInfo(ReferenceNumber: String, DebtorCode : String, response : (objectReturn : DebtorInfo?) -> ()) {
        
        let urlString = LocalStore.accessWeb_URL_API()! + ResourcePath.GetDebtorAdditionalInfor.description
        
        let JsonReturn = DebtorInfo()
        
        let parameters = [
            "Item": [
                "ReferenceNumber": ReferenceNumber,
                "DebtorCode" : DebtorCode
            ]
        ]
        
        
        Alamofire.request(.POST, urlString, parameters: parameters, encoding: .JSON).responseJSON {
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

    
    static func GetArrangmentDetail(ReferenceNumber: String, response : (objectReturn : ArrangeDetails?) -> ()) {
        
        let urlString = LocalStore.accessWeb_URL_API()! + ResourcePath.ArrangeDetail.description
        
        let JsonReturn = ArrangeDetails()
        
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
        
//        let componentsYear = calendar.components(NSCalendarUnit.Year, fromDate: cardObject.ExpiryDate)
//        let year =  componentsYear.year
//        
//        
//        let componentsMonth = calendar.components(NSCalendarUnit.Month, fromDate: cardObject.ExpiryDate)
//        let month =  componentsMonth.month
        
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
                "DebtorPaymentInstallment" : cardObject.DebtorPaymentInstallment
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
                "DirectDebitBSB1": cardObject.BSB1,
                "DirectDebitBSB2": cardObject.BSB2,
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
    
    static func RequestCallback(request:  RequestCallBack, response : (objectReturn : JsonReturnModel?) -> ()) {
        
        let urlString = LocalStore.accessWeb_URL_API()! + ResourcePath.RequestCallback.description
        
        let JsonReturn = JsonReturnModel()
        
        let parameters = [
            "Item": [
                "ReferenceNumber": LocalStore.accessRefNumber()!,
                "Number": request.Phone,
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
    
    static func GetPaymentInfo(response : (objectReturn : PaymentInfo?) -> ()) {
        
        let urlString = LocalStore.accessWeb_URL_API()! + ResourcePath.GetPaymentDetail.description
        
        let JsonReturn = PaymentInfo()
        
        let parameters = [
            "Item": [
                "ReferenceNumber": LocalStore.accessRefNumber()!,
                "Action": "G"
            ]
        ]
        
        
        Alamofire.request(.POST, urlString, parameters: parameters, encoding: .JSON).responseJSON {
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

                                let yyear : Int? = Int((ExpireDate as NSString).substringFromIndex(2))
                                let mmonth : Int? = Int((ExpireDate as NSString).substringToIndex(2))

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
                                
                                let needle: Character = "-"
                                if let idx = JsonReturn.bank.BSB.characters.indexOf(needle) {
                                    let pos = JsonReturn.bank.BSB.startIndex.distanceTo(idx)
                                    JsonReturn.bank.BSB1 = (BSB as NSString).substringToIndex(pos)
                                    JsonReturn.bank.BSB2 = (BSB as NSString).substringFromIndex(pos+1)
                                }
                                else {
                                    JsonReturn.bank.BSB1 = (BSB as NSString).substringToIndex(3)
                                    JsonReturn.bank.BSB2 = (BSB as NSString).substringFromIndex(3)
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
                
                response (objectReturn : JsonReturn)
            }
            else
            {
                response (objectReturn : nil)
            }
            
        }
    }

    static func SetPaymentInfo(paymentInfo: PaymentInfo, response : (objectReturn : PaymentInfo?) -> ()) {
        
        let urlString = LocalStore.accessWeb_URL_API()! + ResourcePath.GetPaymentDetail.description
        
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
        
        
        Alamofire.request(.POST, urlString, parameters: parameters, encoding: .JSON).responseJSON {
            json in
            
            if let jsonReturn1 = json.result.value {
                
                let jsonObject = JSON(jsonReturn1)
                
                
                if let IsSuccess = jsonObject["IsSuccess"].bool {
                    
                    JsonReturn.IsSuccess = IsSuccess
                    
                }
                
                if let Error = jsonObject["Error"].string {
                    
                    JsonReturn.Errors = Error
                    
                }
                
                response (objectReturn : JsonReturn)
            }
            else
            {
                response (objectReturn : nil)
            }
            
        }
    }
    
    static func GetPersonalInfo(response : (objectReturn : PaymentInfo?) -> ()) {
        
        let urlString = LocalStore.accessWeb_URL_API()! + ResourcePath.GetPersonalInformationDetail.description
        
        let JsonReturn = PaymentInfo()
        
        let parameters = [
            "Item": [
                "ReferenceNumber": LocalStore.accessRefNumber()!,
                "DebtorCode" : LocalStore.accessDRCode()!,
                "Action": "G"
            ]
        ]
        
        
        Alamofire.request(.POST, urlString, parameters: parameters, encoding: .JSON).responseJSON {
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

                if let IsSuccess = jsonObject["IsSuccess"].bool {
                    
                    JsonReturn.IsSuccess = IsSuccess
                    
                }
                
                if let Error = jsonObject["Error"].string {
                    
                    JsonReturn.Errors = Error
                    
                }
                
                response (objectReturn : JsonReturn)
            }
            else
            {
                response (objectReturn : nil)
            }
            
        }
    }
    
    static func SetPersonalInfo(personalInfo: PersonalInfo, response : (objectReturn : PaymentInfo?) -> ()) {
        
        let urlString = LocalStore.accessWeb_URL_API()! + ResourcePath.GetPersonalInformationDetail.description
        
        let JsonReturn = PaymentInfo()
        
        let parameters = [
            "Item": [
                "ReferenceNumber": LocalStore.accessRefNumber()!,
                "DebtorCode" : LocalStore.accessDRCode()!,
                "Action": "U",
                "Address1s" : personalInfo.StreetAddress,
                "Address2s" : personalInfo.MailAddress,
                "HomeNumber" : personalInfo.HomePhone,
                "WorkNumber" : personalInfo.WorkPhone,
                "MobileNumbers" : personalInfo.MobilePhone
            ]
        ]
        
        
        Alamofire.request(.POST, urlString, parameters: parameters, encoding: .JSON).responseJSON {
            json in
            
            if let jsonReturn1 = json.result.value {
                
                let jsonObject = JSON(jsonReturn1)
                
                
                if let IsSuccess = jsonObject["IsSuccess"].bool {
                    
                    JsonReturn.IsSuccess = IsSuccess
                    
                }
                
                if let Error = jsonObject["Error"].string {
                    
                    JsonReturn.Errors = Error
                    
                }
                
                response (objectReturn : JsonReturn)
            }
            else
            {
                response (objectReturn : nil)
            }
            
        }
    }
    
    static func SendFeedback(object: Feedback, response : (objectReturn : JsonReturnModel?) -> ()) {
        
        let urlString = LocalStore.accessWeb_URL_API()! + ResourcePath.SendFeedback.description
        
        let JsonReturn = JsonReturnModel()
        
        let parameters = [
            "Item": [
                "ReferenceNumber": LocalStore.accessRefNumber()!,
                "Subject" : object.Subject,
                "Content" : object.Content
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
    
    static func SendDeferPayment(object: DeferPayment, response : (objectReturn : JsonReturnModel?) -> ()) {
        
        let urlString = LocalStore.accessWeb_URL_API()! + ResourcePath.DeferPayment.description
        
        let JsonReturn = JsonReturnModel()
        
        let parameters = [
            "Item": [
                "ReferenceNumber": LocalStore.accessRefNumber()!,
                "InstalDate" : object.InstalDate,
                "Amount" : object.Amount
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

}

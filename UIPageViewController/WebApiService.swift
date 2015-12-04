
import Alamofire
import SystemConfiguration

struct WebApiService {

    
    private enum ResourcePath: CustomStringConvertible {
        case Login
        case Verify
        case GetDirectory
        case GetFile
        
        
        var description: String {
            switch self {
                case .Login: return "/Api/Login"
                case .Verify: return "/Api/Verify"
                case .GetDirectory: return "/Api/GetDirectory"
                case .GetFile: return "/Api/GetFile/?filePath="

            }
        }
    }
    
    static func postVerify(domain: String,  response : (objectReturn : JsonReturnModel?) -> ()) {
        
        let urlString = domain + ResourcePath.Verify.description
        
        
        let JsonReturn = JsonReturnModel()
        
        Alamofire.request(.POST, urlString, parameters: nil , encoding: .JSON).responseJSON {
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
    
//    static func checkInternet(flag:Bool, completionHandler:(internet:Bool) -> Void)
//    {
//        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
//        
//        let url = NSURL(string: "http://www.google.com/")
//        let request = NSMutableURLRequest(URL: url!)
//        
//        request.HTTPMethod = "HEAD"
//        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData
//        request.timeoutInterval = 10.0
//        
//        NSURLConnection.sendAsynchronousRequest(request, queue:NSOperationQueue.mainQueue(), completionHandler:
//            {(response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
//                
//                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
//                
//                let rsp = response as! NSHTTPURLResponse?
//                
//                completionHandler(internet:rsp?.statusCode == 200)
//        })
//    }
    
    static func loginWithUsername(Username: String, password: String) {
        
        let baseURL = LocalStore.accessRCS_URL_API()!
        
        let urlString = baseURL + ResourcePath.Login.description
        
        
        let parameters = [
            "Item": [
                "Username": Username,
                "Password": password
            ]
        ]
        
        
        Alamofire.request(.POST, urlString, parameters: parameters, encoding: .JSON).responseJSON { response in
            
            if let json = response.result.value {
                
                let jsonObject = JSON(json)
                
                let IsSuccess = jsonObject["IsSuccess"].bool
                
                if(IsSuccess?.boolValue == true)
                {
                    if let Item = jsonObject["Item"].dictionaryObject {
                        
                        //let Return = JSONParser.parseLoginModel(Item as NSDictionary)
                        
                        //returnMethod (objectReturn : Return)
                    }
                }
                else
                {
                    //returnMethod (objectReturn : nil)
                }
                
            }
            else
            {
                //returnMethod (objectReturn : nil)
            }
            
        }
        
    }

}

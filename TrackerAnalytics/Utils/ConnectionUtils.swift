//
//  ConnectionUtils.swift
//  TrackerAnalytics
//
//  Created by Ghadeer on 5/24/19.
//  Copyright © 2019 RMDY. All rights reserved.
//

import UIKit
import Alamofire
class ConnectionUtils: NSObject {
    class func performJsonRequestToUrl(actionURL: String, parameters: Parameters, httpMethod:HTTPMethod ,success: @escaping (_ responseDictionary: NSDictionary) -> Void , failure: @escaping (_ error: NSError) -> Void )
    {
        let requestUrl = String(format: "%@%@",trackerAPIKeys.BASE_URL,actionURL)
        
        Alamofire.request(requestUrl ,method: httpMethod, parameters: parameters ).responseJSON { response in
            switch(response.result) {
            case .success(_):
                let statusCode = response.response?.statusCode
                switch statusCode {
                case 200:
                    if let JSON = response.result.value {
                        let responseDictionary = JSON as! NSDictionary
                        success(responseDictionary)
                    }
                    break
                case 401:
                    let userInfo: [AnyHashable : Any] =
                        [NSLocalizedDescriptionKey :"Invalid User name or Password"]
                    failure(errorMessageFromJSON(statusCode: statusCode!,userInfo: userInfo))
                    break
                    
                default:
                    let userInfo: [AnyHashable : Any] =
                        [NSLocalizedDescriptionKey :"Somthing Went Wrong"]
                    failure(errorMessageFromJSON(statusCode: statusCode!,userInfo: userInfo))
                    break
                    
                }
              
                
                break
            case .failure(_):
                print(response.result.error ?? "")
                let userInfo: [AnyHashable : Any] =
                    [NSLocalizedDescriptionKey :response.result.error?.localizedDescription as Any]
                var code = 0
                if let statusCode = response.response?.statusCode{
                    code = statusCode
                }
                
                failure(errorMessageFromJSON(statusCode: code,userInfo: userInfo))

                break
            }
        }
    }
    
    class private func errorMessageFromJSON(statusCode: Int , userInfo: [AnyHashable : Any])->NSError{
    
        let error = NSError(domain: "HttpResponseError", code:statusCode, userInfo: userInfo as? [String : Any])
        return error
    }
    
}


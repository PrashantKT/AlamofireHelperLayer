//
//  APIClient.swift
//  MVVMDemoTests
//
//  Created by Prashant on 30/08/18.
//  Copyright © 2018 Plutomen. All rights reserved.
//

import Foundation
import Alamofire


struct Connectivity {
    static let sharedInstance = NetworkReachabilityManager()!
    static var isConnectedToInternet:Bool {
        return self.sharedInstance.isReachable
    }
}

final class SessionManagerHandler:SessionManager {
    
    class var sessionConfig:URLSessionConfiguration {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.requestCachePolicy = .reloadIgnoringLocalCacheData
        sessionConfig.urlCache = nil
        return sessionConfig
    }
    
    static let  manager  : SessionManagerHandler =
        SessionManagerHandler(configuration: sessionConfig, delegate: SessionDelegate(), serverTrustPolicyManager: nil)
    
    
    
    
    override init(configuration: URLSessionConfiguration, delegate: SessionDelegate, serverTrustPolicyManager: ServerTrustPolicyManager?) {
        super.init(configuration: configuration, delegate: delegate, serverTrustPolicyManager: serverTrustPolicyManager)
    }
    
}

class APIClient {
    
    typealias completionResponse<T:Codable> = ((_ success:T?,_ error:Error?) -> Void)
    
    @discardableResult
    private static func performRequest (request:Router, complition :@escaping (Result<Any>) -> Void) -> DataRequest? {
        
        if Connectivity.isConnectedToInternet {
            
            return SessionManagerHandler.manager.request(request).responseJSON { (response) in
                complition(response.result)
            }
        } else {
            let result = Result<Any>.failure(NSError(domain: ErrorMessages.General.noInternetConnection, code: 123456, userInfo: nil))
            complition(result)
            return nil
        }
        
    }
    
    private static func handleResponseCallCompletion<T:Codable>(result:Result<Any>,completion:@escaping completionResponse<T>) {
        let object = CodableHelper<T>().decode(json: result)
        completion(object.object,object.error)
    }
    
    //--------------------------------------------------------------------------------
    
    // MARK: - APIRouterUserModule Methods
    
    //--------------------------------------------------------------------------------
    
    
    static func login<T:Codable>(userName:String,password:String,completion:@escaping completionResponse<T>) {
        self.performRequest(request: APIRouterUserModule.login(email: userName, password: password)) {(model) in
            self.handleResponseCallCompletion(result: model, completion: completion)
        }
    }
    
   // Implment rest of method here
    
}

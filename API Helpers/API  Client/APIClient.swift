//
//  APIClient.swift
//  NetworkLayerWithAlamofire5
//
//  Created by Prashant on 26/03/18.
//  Copyright © 2018 Prashant. All rights reserved.
//

import Foundation
import Alamofire

class APIClient {
    
    @discardableResult
    private static func performRequest (request:APIRouter, complition :@escaping (Result<Any>) -> Void) -> DataRequest {
       return Alamofire.request(request).responseJSON { (response) in
            complition(response.result)
        }
    }
    
    static func login(userName:String,password:String,completion:@escaping (Result<Any>) -> Void) {
        self.performRequest(request: .login(userName: userName, password: password), complition: completion)
    }
    
    static func profile(completion : @escaping (Result<Any>) -> Void) {
        self.performRequest(request: .images, complition: completion)
    }
    
    
    
}



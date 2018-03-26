//
//  APIRouter.swift
//  NetworkLayerWithAlamofire5
//
//  Created by Prashant on 26/03/18.
//  Copyright © 2018 Prashant. All rights reserved.
//


import Foundation
import Alamofire


enum APIRouter : URLRequestConvertible {
    
    case login(userName:String,password:String)
    case images
    
    // URL Request method
    private var httpMethod : HTTPMethod {
        switch self {
        case .login:
            return .post
        case .images:
            return .get
        }
        
    }
    
   private var endPoint:String {
        switch self {
        case .login:
            return "/login"
        case .images :
            return "/images"
        }
    }
    
   private var parameters : Parameters? {
        switch self {
        case .login(let username,let password):
            return [  Constants.APIConstants.RequestKeys.userName : username,                                                       Constants.APIConstants.RequestKeys.password : password]
        default :
            return nil
            
        }
    }

    func asURLRequest() throws -> URLRequest {
        
        // Generate URL
        let url = try Constants.APIConstants.BaseURL.production.rawValue.asURL()
        
        // Generate  URL Request
        var urlRequest = URLRequest(url: url.appendingPathComponent(endPoint))
        
        // Generate Headers
        
        urlRequest.addValue("application/json", forHTTPHeaderField:"Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        

        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options:[])
                
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        return urlRequest

    }

}

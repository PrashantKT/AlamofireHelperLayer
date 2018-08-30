//
//  APIRouter.swift
//  MVVMDemo
//
//  Created by Prashant on 30/08/18.
//  Copyright © 2018 Plutomen. All rights reserved.
//

import Foundation

public var authToken :String {
    return "auth"
    // return AppGlobalManager.sharedManager.currentUser?.data?.first?.customerAuthToken ?? ""
}

public enum SocialNetworkType :String {
    case facebook = "FB"
    case google = "GOOGLE"
}

public protocol Router:URLRequestConvertible {
    var endPoint : String {get}
    var parameters:Parameters? {get}
    var httpMethod : HTTPMethod {get}
    var encoding:ParameterEncoding {get}
    func asURLRequest() throws -> URLRequest
}

extension Router {
    func asURLRequest() throws -> URLRequest {
        
        // Generate URL
        let url = try Constants.APIConstants.BaseURL.production.rawValue.asURL()
        
        // Generate  URL Request
        var urlRequest = URLRequest(url: url.appendingPathComponent(endPoint))
        
        // Generate Headers
        
        //        if self.endPoint != "/screenshot_list" {
        
        urlRequest.addValue("application/json", forHTTPHeaderField:"Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.addValue(Constants.APIConstants.RequestKeys.APIKEY_Val, forHTTPHeaderField:  Constants.APIConstants.RequestKeys.APIKEY)
        urlRequest.addValue(Constants.APIConstants.RequestKeys.APIVERSION_Val , forHTTPHeaderField:Constants.APIConstants.RequestKeys.APIVERSION )
        urlRequest.addValue(authToken, forHTTPHeaderField:Constants.APIConstants.RequestKeys.AUTHTOKEN )
        
        //  }
        urlRequest.httpMethod = self.httpMethod.rawValue
        
        
        if var parameters = parameters {
            do {
                //       parameters[Constants.APIConstants.RequestKeys.LANGIDKEY] = Localize.currentLanguage()
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options:[])
                urlRequest =  try  self.encoding.encode(urlRequest, with: parameters)
                
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        return urlRequest
        
    }
}


enum APIRouterUserModule : Router {
    
    case login(email:String,password:String)
    case loginSocial(social_network_type:SocialNetworkType, social_network_id:String)
    case forgotPassword (email:String)
    
    case signup(email:String,
        full_name:String,
        password:String,
        date_of_birth:String,
        latitude:String,
        longitude:String,
        social_network_type:SocialNetworkType?,
        social_network_id:String?,
        device_token:String?
    )
    
    case changePassword (old_password : String, new_password: String, new_confirm_password:String)
    case updateProfile(full_name:String,date_of_birth:String)
    case profile
    case logout(auth_customer_id:String)
    case contactUS (name : String, email: String, message:String)
    
    
    // URL Request method
    var httpMethod : HTTPMethod {
        switch self {
        case .login,.loginSocial,.signup ,.forgotPassword,.changePassword,.updateProfile,.logout,.profile,.contactUS:
            return .post
            
        }
    }
    
    var endPoint:String {
        switch self {
        case .login , .loginSocial:
            return "/customer_login"
        case .signup :
            return "/sign_up"
        case .forgotPassword:
            return "/forgot_password"
        case .changePassword :
            return "/change_password"
        case .updateProfile :
            return "/edit_profile"
        case .logout :
            return "/log_out"
        case .profile:
            return "/customer_detail"
        case .contactUS :
            return "/contact_us"
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .login,.loginSocial,.signup ,.forgotPassword,.changePassword,.updateProfile,.logout,.profile,.contactUS:
            return URLEncoding.queryString
            
        }
    }
    
    
    var parameters : Parameters? {
        switch self {
        case .login(let username,let password):
            return [  Constants.APIConstants.RequestKeys.Signup.email : username,
                      Constants.APIConstants.RequestKeys.Signup.password : password ,
                      Constants.APIConstants.RequestKeys.Signup.device_id : UIDevice.current.identifierForVendor!.uuidString,
                      Constants.APIConstants.RequestKeys.Signup.device_type : "ios",
            ]
        case .signup(let email,let fullname,let password,let date_of_birth,let latitude, let longitude, let social_network_type,let social_network_id,let device_token):
            
            return [ Constants.APIConstants.RequestKeys.Signup.email : email,
                     Constants.APIConstants.RequestKeys.Signup.full_name : fullname,
                     Constants.APIConstants.RequestKeys.Signup.password : password,
                     Constants.APIConstants.RequestKeys.Signup.date_of_birth : date_of_birth,
                     Constants.APIConstants.RequestKeys.Signup.latitude : latitude,
                     Constants.APIConstants.RequestKeys.Signup.longitude : longitude,
                     Constants.APIConstants.RequestKeys.Signup.social_network_type : social_network_type?.rawValue ?? "" ,
                     Constants.APIConstants.RequestKeys.Signup.social_network_id : social_network_id   ?? "" ,
                     Constants.APIConstants.RequestKeys.Signup.device_id : UIDevice.current.identifierForVendor!.uuidString,
                     Constants.APIConstants.RequestKeys.Signup.device_token : device_token ?? "",
                     Constants.APIConstants.RequestKeys.Signup.device_type : "ios"]
            
        case .loginSocial(let social_network_type,let social_network_id):
            return [
                Constants.APIConstants.RequestKeys.Signup.social_network_type : social_network_type.rawValue,
                Constants.APIConstants.RequestKeys.Signup.social_network_id : social_network_id,
                Constants.APIConstants.RequestKeys.Signup.device_id : UIDevice.current.identifierForVendor!.uuidString,
                Constants.APIConstants.RequestKeys.Signup.device_type : "ios",
                
                ] as [String:Any]
        case .forgotPassword(let username):
            return [
                Constants.APIConstants.RequestKeys.Signup.email : username
                ] as [String:Any]
        case .changePassword( let old_password,let new_password,let  new_confirm_password):
            return [
                Constants.APIConstants.RequestKeys.ChangePasword.old_password : old_password,
                Constants.APIConstants.RequestKeys.ChangePasword.new_password : new_password,
                Constants.APIConstants.RequestKeys.ChangePasword.new_confirm_password : new_confirm_password
            ]
        case .updateProfile(let full_name, let date_of_birth) :
            return [    Constants.APIConstants.RequestKeys.EditProfile.customer_name : full_name,
                        Constants.APIConstants.RequestKeys.EditProfile.customer_date_of_birth : date_of_birth
            ]
        case .logout(let auth_customer_id) :
            return [    Constants.APIConstants.RequestKeys.Logout.auth_customer_id : auth_customer_id]
        case .profile:
            return nil
        case .contactUS( let name,let  email,let  message):
            return [
                Constants.APIConstants.RequestKeys.ContactUS.name : name,
                Constants.APIConstants.RequestKeys.ContactUS.email : email,
                Constants.APIConstants.RequestKeys.ContactUS.message : message
            ]
        }
    }
}

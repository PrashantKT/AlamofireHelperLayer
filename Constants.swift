//
//  Constants.swift
//  NetworkLayerWithAlamofire5
//
//  Created by Prashant on 30/08/18.
//  Copyright © 2018 Prashnat. All rights reserved.
//

import Foundation

struct Constants {
    struct APIConstants {
        
        enum BaseURL:String {
            case production = "URL"
     
        }

        struct RequestKeys {
            
            static let APIVERSION = "APIVERSION"
            static let APIKEY = "APIKEY"
            static let AUTHTOKEN = "AUTHTOKEN"

            static let APIVERSION_Val = "1"
            static let APIKEY_Val = "HBDEV"

            static let LANGIDKEY = "lang_id"
            

            
            static let userName = "userName"
            static let password = "password"
            
            struct Signup {
               static let email =  "email"
               static let full_name = "full_name"
               static let password = "password"
               static let date_of_birth = "date_of_birth"
               static let latitude = "latitude"
               static let longitude = "longitude"
               static let social_network_type = "social_network_type"
               static let social_network_id = "social_network_id"
               static let device_id = "device_id"
              static let  device_token = "device_token"
               static let device_type = "device_type"
            }
            
            struct ChangePasword {
                static let old_password =  "old_password"
                static let new_password = "new_password"
                static let new_confirm_password = "new_confirm_password"
            }
            
            struct Logout {
                static let auth_customer_id =  "auth_customer_id"

            }
            struct StaticPages {
                static let page_code =  "page_code"
            }
            
            struct UpdateNotificationSettings {
                static let notification =  "notification"
                static let notification_id = "notification_id"
                static let auth_customer_id =  "auth_customer_id"

            }
            
            struct CampignModule {
                static let search_text =  "search_text"
                static let auth_customer_id =  "auth_customer_id"
                static let campaign_id =  "campaign_id"

            }
            struct ContactUS {
                static let name =  "name"
                static let email =  "email"
                static let message =  "message"
                
            }
            
            struct ScreenShots {
                static let screenshot_id =  "screenshot_id"
            }
            
            struct EditProfile {
                static let customer_name =  "customer_name"
                static let customer_date_of_birth =  "customer_date_of_birth"
                static let customer_profile_pic =  "customer_profile_pic"

            }
        }
        
    }
}

//
//  Constants.swift
//  NetworkLayerWithAlamofire5
//
//  Created by Prashant on 26/03/18.
//  Copyright © 2018 Prashant. All rights reserved.
//

import Foundation

struct Constants {
    struct APIConstants {
        
        enum BaseURL:String {
            case production = "https://production/v1"
            case localServer = "https://baseserver.com/v1"
        }
        
        struct RequestKeys {
            static let userName = "userName"
            static let password = "password"
        }
        
    }
}

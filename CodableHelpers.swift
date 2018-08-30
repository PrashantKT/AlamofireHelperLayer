//
//  CodableHelpers.swift
//  ArrayInspire
//
//  Created by Prashant on 30/08/18.
//  Copyright © 2018 Prashant. All rights reserved.
//

import Foundation
import Alamofire

class CodableHelper<T:Codable> {
    func decode(json:Result<Any>) -> (object:T?,error:Error?) {
        switch json {
        case .success(let value):
            do {
                let data = try JSONSerialization.data(withJSONObject: value, options: [])
                let object = try JSONDecoder().decode(T.self, from: data)
                return (object,nil)
                
            } catch {
                return (nil,error)
            }
            
        case .failure(let error):
            return (nil,error)
            
            
        }
    }
    
    func encode(object:T) -> (object:Any?,error:Error?) {
        do {
            let data = try JSONEncoder().encode(object)
            let json  = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            return (json,nil)
        } catch {
            return (nil,error)
        }
    }
}

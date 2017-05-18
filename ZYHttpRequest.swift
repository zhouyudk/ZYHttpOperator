//
//  ZYDataRequest.swift
//  ZYWheel
//
//  Created by yu zhou on 5/5/17.
//  Copyright © 2017 yu zhou. All rights reserved.
//

import Foundation
import Alamofire

enum ZYHTTPMethod:String{
    case get,put,post,delete
}

protocol Request {
    var path: String { get }
    
    var method: ZYHTTPMethod { get }
    var parameter: [String: Any] { get }
    var header : [String: String] { get }
    var safeKey: String { get }
    associatedtype Response: Decodable
}
extension Request {
    var header: [String: String] {
        return ["Authorization":parameterHash(parameters: parameter as [String : Any])]
    }
    
    var safeKey: String {
        return "ouj9s1ds^%dif@ss"
    }
    
    //根据需求对请求参数等 进行特殊处理
    private func parameterHash(parameters: [String:Any]) -> String {
        var s:String = ""
        
        for key in parameters.keys.sorted(by: <) {
            s += "&\(key)=\(parameters[key]!)"
        }
        
        if !(s == ""){
            s = (s as NSString).substring(from: 1)
        }
        
        return s.hmac_sha256(safeKey: safeKey)
    }
}

protocol Decodable {
    static func parse(result: [String:Any]) -> Self?
}


//针对返回的数据为list的情况
struct DecodableArray<T: Decodable>: Decodable {
    
    let value: [T]
    
    static func parse(result: [String : Any]) -> DecodableArray<T>? {
        var value = [T]()
        for subData in result["items"] as! [[String : Any]] {
            let r = T.parse(result: subData)
            value.append(r!)
        }
        return DecodableArray(value: value)
    }
}


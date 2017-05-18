//
//  ZYHttpClient.swift
//  ZYWheel
//
//  Created by yu zhou on 5/5/17.
//  Copyright © 2017 yu zhou. All rights reserved.
//

import Foundation
import Alamofire

protocol ZYHttpClient{
    var host: String { get }
}
extension ZYHttpClient {
    var host: String {
        return "https://www.baidu.com"
    }
    @discardableResult
    func send<T: Request>(_ r: T,handler:  @escaping (_ response:T.Response?,_  error:String) -> Void )  -> Alamofire.Request {
        //let url = try! (host + r.path).asURL()//URLConvertible.asURL(host+r.path)//URL(string: host + r.path)
        
        var method:HTTPMethod = .get
        switch r.method {
        case .get:
            method = .get
        case .delete:
            method = .delete
        case .put:
            method = .put
        case .post:
            method = .post
        }
        let request = Alamofire.request((host + r.path), method: method,parameters: [:],headers:r.header)
        
        request.responseJSON { (DataResponse) in
            handler(T.Response.parse(result: DataResponse.result.value as! [String:Any]),"")
        }
        return request
    }
    
}



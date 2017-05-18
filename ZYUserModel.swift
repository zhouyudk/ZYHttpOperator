//
//  ZYUserModel.swift
//  ZYWheel
//
//  Created by yu zhou on 5/5/17.
//  Copyright © 2017 yu zhou. All rights reserved.
//

import Foundation

struct User: Decodable {
    static func parse(result: [String:Any]) -> User? {
        var u = User()
        u.name = result["User"] as! String
        return u
    }

    var name: String = ""
}

struct userRequest: Request {
    var path: String  = ""
    var method: ZYHTTPMethod = .get
    var parameter: [String : Any] = [:]
    init(para:[String : Any]) {
        parameter = para
    }
    typealias Response = User//如果返回结果为数组DecodableArray<User>
}

struct userClient: ZYHttpClient {
    func ddd() {
        send(userRequest.init(para: [:])) { user in
            
        }
    }
}

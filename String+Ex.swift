//
//  String+Ex.swift
//  ZYHttpOperator
//
//  Created by yu zhou on 5/18/17.
//  Copyright © 2017 yu zhou. All rights reserved.
//

import Foundation
extension String {
    func hmac_sha256(safeKey k:String) -> String {
        let cKey = k.cString(using: String.Encoding.utf8)
        let cstr = self.cString(using: String.Encoding.utf8)
        var digest = [CUnsignedChar](repeating:0,count:Int(CC_SHA256_DIGEST_LENGTH))
        CCHmac(CCHmacAlgorithm(kCCHmacAlgSHA256), cKey!,cKey!.count-1, cstr!, cstr!.count-1, &digest)
        let hash = NSMutableString()
        for i in 0 ..< digest.count {
            hash.appendFormat("%02hhx", digest[i])
        }
        return hash as String
    }
    
    func hmac_sha1(safeKey k:String) -> String {
        let cKey = k.cString(using: String.Encoding.utf8)
        let cstr = self.cString(using: String.Encoding.utf8)//CC_SHA256_DIGEST_LENGTH
        var digest = [CUnsignedChar](repeating:0,count:Int(CC_SHA1_DIGEST_LENGTH))
        CCHmac(CCHmacAlgorithm(kCCHmacAlgSHA1), cKey!,cKey!.count-1, cstr!, cstr!.count-1, &digest)
        let hash = NSMutableString()
        for i in 0 ..< digest.count {
            hash.appendFormat("%02hhx", digest[i])
        }
        return hash as String
    }
}

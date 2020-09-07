//
//  ASNetwork.swift
//  ASPurchase-swift
//
//  Created by AllSale on 2020/7/24.
//  Copyright © 2020 AllSale. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


typealias NetworkResult = ()->()


enum MethodType {
    case get
    case post
}

struct Login: Encodable {
    let email:String
    let password:String
    
}

class ASRequest: NSObject {
    var url = ""
    var params:[String:Encodable] = [:]
    var method:HTTPMethod = .get
    
}

class ASNetwork: NSObject {
    
    public static func upload<T>(files: [T], param: Parameters, progress: @escaping (_ progress: Progress) -> Void, success: @escaping (_ success: Any) -> Void, fail: @escaping (_ fail: Error) -> Void, to URLString: String) {
        
        
    }
        
        
    class func requestExecute(request: ASRequest) {
        
        var paramters:[String:Encodable]? = nil
        
        if request.method != .get {
            paramters = request.params
        }
        
        let headers: HTTPHeaders = [
        "Content-type" : "application/json;charset=utf-8",
        "Accept":"application/json",
        "Authorization":"e74d78f0-24d0-4d6a-872b-835ccb0d36da",
        "app-version":"1.4.0"]
        
        let encoding:ParameterEncoding = JSONParameterEncoder.default as! ParameterEncoding
        
//        AF.request(request.url, method: request.method, parameters: Parameters, encoder: encoding as! ParameterEncoder, headers: headers)
//        .validate(statusCode: 200..<600)
//        .responseJSON(queue: DispatchQueue.main,
//                      options: JSONSerialization.ReadingOptions.allowFragments) { (response) in
//                        let data = response.value
//                        print("-----> [Request] - \(request.url)")
//                        print("-----> [Response] - \(data != nil ? data as Any : response as Any)")
//        
//        }
    }
    
    
    class func requestData(_ type: MethodType, urlString:String, params:Parameters, finishedCallback: @escaping (_ result:Any) -> ()) {
        
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        
//        let login = Login(email: "test@test.test", password: "testPassword")
        
//        let paramet: [String: [String]] = [
//            "foo": ["bar"],
//            "baz": ["a", "b"],
//            "qux": ["x", "y", "z"]
//        ]
        
//        let headers: HTTPHeaders = [
//            .authorization(bearerToken: "e74d78f0-24d0-4d6a-872b-835ccb0d36da"),
//            .accept("application/json"),
//            .contentType("application/json;charset=utf-8"),
//        ]
        
        let headers:HTTPHeaders =  [
                "Content-type" : "application/json;charset=utf-8",
                "Accept":"application/json",
                "Authorization":"e74d78f0-24d0-4d6a-872b-835ccb0d36da",
                "app-version":"1.4.0"]
        
        let url = "http://test.beautystudio.com.cn/dg/api/" + urlString
        
//        AF.request(url, method: method, parameters:params, encoder: JSONParameterEncoder.default, headers:headers).responseJSON { (response) in
////            debugPrint(response)
//            
//            // 3.获取结果
//            guard let result = response.result else {
//                print(response.result)
//                return
//            }
//            
//            // 4.将结果回调出去
//            finishedCallback(response)
//            
//        }
        
    
        
    }
    
    
    static func request(_ method:HTTPMethod = .post, path:String,_ param:ASPreRequest,_ callback:NetworkResult?) {
        
        let url = param.path
        param.path = path
        
        
        let json = param.para.jsonString()
        guard let jsonData = json.data(using: .utf8, allowLossyConversion: false) else { return }
        
        guard let u = URL(string: url) else {
            DLog("url=",url)
            DLog("para=",param.para)
            DLog("error = URL初始化失败！")
            return
        }
        
        var request = URLRequest(url: u)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
//        let resp = ASResponse()
        
        
        AF.request("", method: method, parameters: ["":""], encoder: JSONParameterEncoder.default).responseJSON { (response) in
            debugPrint(response)
        }
        
    }
    
    
}


class ASPreRequest: NSObject {
    
    var path:String = ""
    
    var para = Dictionary<String,Any>()
    
    
    
}

class ASNetworkResult: NSObject {
    
    
    
    
}

class ASResponse: NSObject {
    
    
    
}

//
//  XLZNetworking.swift
//  ASPurchase-swift
//
//  Created by AllSale on 2020/9/2.
//  Copyright © 2020 AllSale. All rights reserved.
//

import UIKit
import Foundation
import SwiftyJSON
import HandyJSON

/*
public enum HTTPMethod: String {
    case options = "OPTIONS"
    case get = "GET"
    case post = "POST"
    case head = "HEAD"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
    case trace = "TRACE"
    case connect = "CONNECT"
}
*/




open class XLZNetworking<T:Codable> {
    
    var op:Optionals = Optionals()
    
    
    public let session:URLSession
    
    // 处理数据的 block 泛型
    typealias CompletionJSONClosure = (_ data:T) -> Void
    var completionJSONClosure:CompletionJSONClosure = { _ in }
    
    
    // 处理数据 json 类型 @escaping (_ result : Any) -> ()
    typealias CallbackJSONBlock =  (_ result : Any) -> ()
    var callbackJSONBlock: CallbackJSONBlock = {_ in}
    
    
    //配置 request block
    typealias ConfigRequestClosure = (_ request:URLRequest) -> Void
    var configRequestClosure:ConfigRequestClosure = {_ in}
    
    
    public init() {
        self.session = URLSession.shared
    }
    
    
    ///JOSN的请求
    func requestJSON(_ url:XLZURLNetWorking,_ doneCloseure: CompletionJSONClosure? = nil, callback:@escaping CallbackJSONBlock) {
        
//        self.completionJSONClosure = doneCloseure!
        self.callbackJSONBlock = callback
        
        var request:URLRequest = NSURLRequest.init(url: url.asURL()) as URLRequest
        
        request.httpMethod = op.httpMethod.rawValue
        
        self.configRequestClosure(request)
        
        let task = self.session.dataTask(with: request) { (data, res, error) in
            if error == nil {
                let decoder = JSONDecoder()
                do {
                    print("解析 JSON 成功")
                    
                    let jsonModel = try decoder.decode(T.self, from: data!)

                    
                    self.completionJSONClosure(jsonModel)
                    
                    
                    
                } catch  {
                    print("解析 JSON 失败")
                }
            }
        }
        task.resume()
    }
    
    
    func method(_ md:HTTPMethod) -> XLZNetworking {
        self.op.httpMethod = md
        return self
    }
    
    func configRequest(_ c:@escaping ConfigRequestClosure) -> XLZNetworking {
        self.configRequestClosure = c
        return self
    }
    
    struct Optionals {
        var httpMethod:HTTPMethod = .GET
        
        
    }
    
    enum HTTPMethod: String {
        case GET,OPETIONS,POST,HEAD,PUT,PATCH,DELETE,TRACE,CONNECT
    }
    
}


public protocol XLZURLNetWorking {
    func asURL() -> URL
}

extension String: XLZURLNetWorking {
    
    public  func asURL() -> URL {
        guard let url = URL(string: self) else {
            return URL(string: ASBaseUrl)!
        }
        return url
    }
    
}







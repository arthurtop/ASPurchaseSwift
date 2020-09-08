//
//  ASAFNetwork.swift
//  ASPurchase-swift
//
//  Created by AllSale on 2020/7/25.
//  Copyright © 2020 AllSale. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
//import SwiftyJSON
import HandyJSON


typealias ASResponseSuccess = (_ response:String) -> Void
typealias ASResponseFail = (_ error: String) -> Void
typealias ASNetworkStatus = (_ NetworkStatus:Int32) -> Void
typealias ASProgressBlock = (_ progress:Int32) -> Void


enum NetworkStatus:Int32 {
    case unKnown        = -1 //未知网络
    case notReachable   = 0 //网络无连接
    case wwan           = 1 //2 3 4G网络
    case wifi           = 2 //WiFi
}


enum MethodTypes {
    case get
    case post
}


class ASAFNetwork<T: HandyJSON> {
//class ASAFNetwork {
    
    class func requestDatas(_ type : MethodTypes,
                            urlString: String,
                            parameters: [String : Any]? = nil,
                            encoder: ParameterEncoder = URLEncodedFormParameterEncoder.default,
                            headers: HTTPHeaders? = nil,
                            finishedCallback :  @escaping (_ result : T) -> ()) {
        
        // 1.获取类型
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        
        let token:String = ASUserCenter.shared.user!.token
        
        var asHeaders: HTTPHeaders = [:]
        
        if headers != nil {
            asHeaders = ["Content-type" : "application/json;charset=utf-8",
            "Accept":"application/json",
            "Authorization": token,
             "app-version": "1.4.0"]
        }
        
        
        let baseUrl = ASBaseUrl + urlString
        
        
        // 2.发送网络请求
        AF.request(baseUrl, method: method, parameters: parameters, headers: asHeaders)
            .responseString { (response) in
                
//                print(response.value!)
//                finishedCallback(response.value!)
                
                
                let model = JSONDeserializer<T>.deserializeFrom(json: response.value)!
                
                
//                finishedCallback(response.value as! T)
                
                finishedCallback(model)
                
                
                
        }
        
        
//            .responseJSON { (response) in
//
//            // 3.获取结果
////            let data = JSON(response.value ?? "")["data"].dictionaryValue
////            DLog(data)
//
//            // 4.将结果回调出去
//                finishedCallback(response )
//        }
//        .responseData { (responseData) in
//            guard let json = responseData.data else {return}
//
//            switch responseData.result {
//            case let .success(responseData):
//                do {
//                    let decoder = JSONDecoder()
//                    let baseModel = try? decoder.decode(T.self, from: json)
//                    guard let model = baseModel else {
////                        if let failureBlack = sel
//                        return
//                    }
//
//                    finishedCallback(json)
//                }
//
//            case .failure(_):
//                print("解析失败")
//            }
//
//        }
        
        
        
    }
    
    
}












    /*
    static let share = ASNetworkRequest()
    private var sessionManager: Session?
    
    override init() {
        super.init()
        
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 60
        
//        sessionManager = Session.init(configuration: config, delegate: SessionDelegate.init(), rootQueue: nil, startRequestsImmediately: <#T##Bool#>, requestQueue: <#T##DispatchQueue?#>, serializationQueue: <#T##DispatchQueue?#>, interceptor: <#T##RequestInterceptor?#>, serverTrustManager: <#T##ServerTrustManager?#>, redirectHandler: <#T##RedirectHandler?#>, cachedResponseHandler: <#T##CachedResponseHandler?#>, eventMonitors: <#T##[EventMonitor]#>)
        
        
    }
    
    private var netStatus: NetworkStatus = NetworkStatus.wifi
    
    public func getWith(url:String, params:[String:Any]?, success:@escaping ASResponseSuccess, error: @escaping ASResponseFail) {
        
        requestWith(url: url, httpMethod: 0, params: params, success: success, error:error)
        
        
    }
    
    public func postWith(url: String,
                             params: [String: Any]?,
                             success: @escaping ASResponseSuccess,
                             error: @escaping ASResponseFail) {
            //根绝业务需求变动
            //参数拼接url
//            let url = ASRequestData.share.getUrlAddParams(params: params, url: url)
//            //数据进行加密
//            let dic = ASRequestData.share.getReqData(params: params)
//            requestWith(url: url,
//                        httpMethod: 1,
//                        params: dic,
//                        success: success,
//                        error: error)
        }
    
    
     public func requestWith(url: String,
                                httpMethod: Int32,
                                params: [String: Any]?,
                                success: @escaping ASResponseSuccess,
                                error: @escaping ASResponseFail) {
            //get
            if httpMethod == 0 {
                manageGet(url: url, params: params, success: success, error: error)
            } else {
                managePost(url: url, params: params!, success: success, error: error)
            }
        }

    
    private func managePost(url: String,
                                params: [String: Any],
                                success: @escaping ASResponseSuccess,
                                error: @escaping ASResponseFail) {
            //请求头信息
            var header = HTTPHeaders()
//            header.add(name: "dragon-system", value: FSRequestData.share.getHeaderJson())
            AF.request(url,
                            method: .post,
                            parameters: params,
                            encoding: URLEncoding.default,
                            headers: header).responseJSON { (response) in
                                switch response.result {
                                case .success:
                                    let json = String(data: response.data!, encoding: String.Encoding.utf8)
                                    success(json ?? "")
                                case .failure:
                                    let statusCode = response.response?.statusCode
                                    error("\(statusCode ?? 0)请求失败")
                                    debugPrint(response.response as Any)
                                }
            }
        }
        
        private func manageGet(url: String,
                               params: [String: Any]?,
                               success: @escaping ASResponseSuccess,
                               error: @escaping ASResponseFail) {
            //请求头信息
            var header = HTTPHeaders()
//            header.add(name: "dragon-system", value: FSRequestData.share.getHeaderJson())
            AF.request(url,
                            method: .get,
                            parameters: params,
                            encoding: URLEncoding.default,
                            headers: header).responseJSON { (response) in
                                switch response.result {
                                case .success:
                                    let json = String(data: response.data!, encoding: String.Encoding.utf8)
                                    success(json ?? "")
                                case .failure:
                                    let statusCode = response.response?.statusCode
                                    error("\(statusCode ?? 0)请求失败")
                                    debugPrint(response.response as Any)
                                }
            }
        }
    
}


class ASAFNetwork: NSObject {
    
}

*/

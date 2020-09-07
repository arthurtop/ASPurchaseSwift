//
//  ASBaseMoyaAPI.swift
//  ASPurchase-swift
//
//  Created by AllSale on 2020/7/23.
//  Copyright © 2020 AllSale. All rights reserved.
//

import UIKit
import Moya


#if DEBUG
let ASHostUrls = "http://test.beautystudio.com.cn/dg/api/"//测试环境

let ASH5HostUrl =  ASHostUrls + "/dg-app-h5/1.4.0"  //H5生产

#else
let ASHostUrl = "https://awstest.beautystudio.com.cn/dg/api"//生产环境

let ASH5HostUrl =  ASHostUrls + "/dg-app-h5/1.4.0"  //H5生产

#endif





enum ASBaseMoyaAPI {
    
    case getLogin(_ name:String, _ password:String)
    
    case getResgin
    
    case getFindhome
    
    case getHome
    
    case getBussinessHome
    
    
    
}


extension ASBaseMoyaAPI: TargetType {
    
    
    var baseURL: URL {
        return URL(string: ASHostUrls)!
    }
    
    var path: String {
        switch self {
        case .getBussinessHome:
            return "/saleStatistic/home"
        case .getLogin(_,_):
            return ""
        
        case .getResgin:
            return ""
        case .getFindhome:
            return ""
        case .getHome:
            return ""
        }
    }
    
    /*
    var parameters: [String: Any]? {
           switch self {
           case .getBussinessHome:
               return ["":""]
           case .getLogin(let name, let password):
               return ["title": title, "body": body]
           }
    }
    */
    
    var method: Moya.Method {
        switch self {
        case .getBussinessHome:
            return .get
        case .getLogin(_, _):
            return .post
        case .getResgin:
            return .get
        case .getFindhome:
            return .get
        case .getHome:
            return .get
        }
    }
    
    
    /// 测试
    var sampleData: Data {return Data(base64Encoded: "just for test")!}
    
    
    var task: Task {
        return .requestPlain
    }
    
//    e74d78f0-24d0-4d6a-872b-835ccb0d36da
    // MARK: - 设置请求头部信息
    var headers: [String : String]?{
        return ["Content-type" : "application/json;charset=utf-8",
                "Accept":"application/json",
                 "Authorization":"e74d78f0-24d0-4d6a-872b-835ccb0d36da",
                 "app-version":"1.4.0"]
        
    }
}




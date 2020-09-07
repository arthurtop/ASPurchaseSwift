//
//  Router.swift
//  NetworkTool
//
//  Created by OrderPlus on 2018/7/17.
//  Copyright © 2018年 zhaofengYue. All rights reserved.
//

import UIKit
import Alamofire

enum Router: String, URLConvertible {
    
    case tianqi = "saleStatistic/home"
    
    /// 实现协议方法
    func asURL() throws -> URL {
        return try URL(string: urlString)!.asURL()
    }
    
    /// 主机地址
    static var baseUrl: String  = ASBaseUrl
    
    /// 拼接过的地址链接
    private var urlString: String {
        return Router.baseUrl.appending(rawValue)
    }
}

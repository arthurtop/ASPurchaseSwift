//
//  ASConfig.swift
//  ASPurchase-swift
//
//  Created by AllSale on 2020/7/23.
//  Copyright © 2020 AllSale. All rights reserved.
//

import UIKit
import Foundation

//import Moya
import SnapKit
import RxSwift
//import RxCocoa
import HandyJSON
//import XCGLogger
import Kingfisher
//import SwiftyJSON
//import Toast_Swift
import RxDataSources
//import IQKeyboardManagerSwift





func DLog(_ items: Any..., lineFeed:Bool = false) {
    if isPrint {
        if lineFeed {
            print(items,"\n")
        } else {
            print(items)
        }
    }
}



//let ASHostUrl @"http://test.beautystudio.com.cn"//测试环境
//let ASHostUrl @"https://awstest.beautystudio.com.cn"//生产


//// 获取邀请码  PHP地址
//let ASPHPHostUrl @"http://codetest.beautystudio.com.cn"  // 测试环境

//let ASH5HostUrl [NSString stringWithFormat:@"%@/dg-app-h5/1.4.0",ASHostUrl] //H5生产


/// 测试 http://test.beautystudio.com.cn/dg/api/
let ASBaseUrl = "http://test.beautystudio.com.cn/dg/api/"
/// 生产
//let ASBaseUrl = "https://awstest.beautystudio.com.cn/dg/api/"





#if DEBUG
let isPrint = true // true 打印日志、false 不打印日志

#else
let isPrint = false // true 打印日志、false 不打印日志

#endif




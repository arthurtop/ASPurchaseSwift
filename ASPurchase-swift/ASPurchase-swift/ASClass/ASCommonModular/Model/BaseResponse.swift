//
//  BaseResponse.swift
//  ASPurchase-swift
//
//  Created by AllSale on 2020/9/3.
//  Copyright © 2020 AllSale. All rights reserved.
//

import UIKit
import HandyJSON


class BaseResponse<T: HandyJSON>: HandyJSON {
    
    var code: Int?   //服务器返回码
    
    var data: T?    //data 数据 具体数据类型不确定 使用泛型
    
    var message:String?
    
    var timestamp:String?
    
    
    public required init() {}
    
}

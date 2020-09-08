//
//  BaseDataModel.swift
//  ASPurchase-swift
//
//  Created by AllSale on 2020/9/7.
//  Copyright © 2020 AllSale. All rights reserved.
//

import UIKit


public protocol BaseDataModel {
    
    var code: Int? { get set }
    var message: String? { get set }
    var timestamp: Float64? { get set }
    
    
    
    
}

//
//  ASHomeViewModel.swift
//  ASPurchase-swift
//
//  Created by AllSale on 2020/9/8.
//  Copyright © 2020 AllSale. All rights reserved.
//

import UIKit
import HandyJSON

class ASHomeViewModel {
    
    lazy var homeModel: HomeModel = HomeModel()
    
    
    
    func homeRequestData(finishCallback:@escaping (_ result: HomeModel) -> ()) {
            
        
        ASAFNetwork<HomeModel>.requestDatas(.get, urlString: "home") { (response) in
            
            finishCallback(response)
            
        }
        
        
        
            
    }
    
    
    
    
    
    
    
    
    
    
}

//
//  ASMineHeaderView.swift
//  ASPurchase-swift
//
//  Created by AllSale on 2020/8/24.
//  Copyright © 2020 AllSale. All rights reserved.
//

import UIKit



class ASMineHeaderView: UIView {
    
    
    

}



extension ASMineHeaderView {
    class func mineHeaderView() -> ASMineHeaderView {
        return Bundle.main.loadNibNamed("ASMineHeaderView", owner: nil, options: nil)?.first as! ASMineHeaderView
    }
}










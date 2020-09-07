//
//  ASTabBarController.swift
//  ASPurchase-swift
//
//  Created by AllSale on 2020/7/22.
//  Copyright © 2020 AllSale. All rights reserved.
//

import UIKit

class ASTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        controllerLoad()
        
        
        
    }
    
    
    func controllerLoad() {
        
        let home = ASHomeViewController().navigation("首页","tabbar_hy","tabbar_hy_h")
        let find = ASFindViewController().navigation("发现","tabbar_fx","tabbar_fx_h")
        let shop = ASShopViewController().navigation("店铺","icon_tabbar_store_normal","icon_tabbar_store")
        let business = ASBusinessController().navigation("生意","tabbar_zb","tabbar_zb_h")
        let mine = ASMineViewController().navigation("我的","tabbar_me","tabbar_me_h")
        
        viewControllers = [home,find,shop,business,mine];
        
    }
    
    
    
    

}

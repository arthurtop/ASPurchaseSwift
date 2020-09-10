//
//  ASTabBarController.swift
//  ASPurchase-swift
//
//  Created by AllSale on 2020/7/22.
//  Copyright © 2020 AllSale. All rights reserved.
//

import UIKit

class ASTabBarController: UITabBarController {
    
    
    
    
    var asTabbar = ASTabbar()
    var shopMiddle = ASNavigationController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        controllerLoad()
        

        
//        let customView = UIView(frame: tabBar.bounds)
//        customView.backgroundColor = .white
//        UITabBar.appearance().insertSubview(customView, at: 0)
        
        
    }
    
    
    func controllerLoad() {
        
//        setLayer()
        
        let home = ASHomeViewController().navigation("首页","tabbar_hy","tabbar_hy_h")
        let find = ASFindViewController().navigation("发现","tabbar_fx","tabbar_fx_h")
//        let shop = ASShopViewController().navigation("店铺","icon_tabbar_store_normal","icon_tabbar_store")
        let shop = ASShopViewController().navigation("店铺","","")
        shopMiddle = shop
        
        let business = ASBusinessController().navigation("生意","tabbar_zb","tabbar_zb_h")
        let mine = ASMineViewController().navigation("我的","tabbar_me","tabbar_me_h")
        
//        viewControllers = [home,find,shop,business,mine];
        
        addChild(home)
        addChild(find)
        addChild(shop)
        addChild(business)
        addChild(mine)
        
        
        addComposeButton()
        
        
    }

}

//pragma mark - 添加中间的按钮
extension ASTabBarController {

    func addComposeButton() {
        
        let tabbar = ASTabbar()
        asTabbar = tabbar
        
        tabbar.callBack = {
            self.selectedIndex = 2
            self.tabBarController(self, didSelect: self.shopMiddle)
        }
        
        tabbar.layer.shadowColor = k_7F7F7F.withAlphaComponent(0.2).cgColor
        tabbar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabbar.layer.shadowOpacity = 1
        tabbar.layer.shadowRadius = 15
        
        self.setValue(tabbar, forKey: "tabBar")
        
        
    }
}


extension ASTabBarController: UITabBarControllerDelegate {
    
    /// 自定义 tabbar 控制中间按钮点击
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        let navCtl:ASNavigationController = viewController as! ASNavigationController

        let tabb = navCtl.viewControllers.first!.isKind(of: ASShopViewController.self)
        
//        print(!tabb,self.asTabbar.centerBtn.isSelected)
        
        self.asTabbar.centerBtn.isSelected = tabb
        
    }
    
}


/*
 设置中间按钮 只是显示 凸出部分不能点击   未使用
 */
extension ASTabBarController {
    
    fileprivate func setLayer() {
        let bezier = UIBezierPath()
        bezier.move(to: CGPoint.zero)
        bezier.addLine(to: CGPoint(x: k_screen_width * 0.5 - 27, y: 0))
        
        bezier.append(UIBezierPath(arcCenter: CGPoint(x: k_screen_width * 0.5, y: 15), radius: 30, startAngle: 0, endAngle: CGFloat.pi * -1, clockwise: false))
        
        bezier.move(to: CGPoint(x: k_screen_width * 0.5 + 27, y: 0))
        bezier.addLine(to: CGPoint(x: k_screen_width, y: 0))
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = bezier.cgPath
        shapeLayer.lineWidth = 1
        shapeLayer.fillColor = #colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9764705882, alpha: 1).cgColor
        shapeLayer.strokeColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1).cgColor
        tabBar.backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9764705882, alpha: 1)
        tabBar.layer.insertSublayer(shapeLayer, at: 0)
        
        tabBar.shadowImage = UIImage()
        tabBar.backgroundImage = UIImage()
    }
    
}

//
//  ASBaseViewController.swift
//  ASPurchase-swift
//
//  Created by AllSale on 2020/7/22.
//  Copyright © 2020 AllSale. All rights reserved.
//

import UIKit

class ASBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navSetting()
        
        
    }
    
    
    func navSetting() {
        if self.navigationController?.viewControllers.count ?? 0 > 1 {
            setNavLeft()
        }
        
        view.backgroundColor = k_F5F5F5
    }
    
    func setNavLeft() {
        
        self.navigationItem.hidesBackButton = true
        let custom = UIButton(type: .custom)
        custom.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        custom.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        
        let imgView = UIImageView(frame: CGRect(x: 2, y: (custom.frame.height-16)/2-1, width: 9, height: 16))
        imgView.image = UIImage(named: "nav_back_white")
        custom.addSubview(imgView)
        
        let backBarBtnItem = UIBarButtonItem(customView: custom)
        self.navigationItem.leftBarButtonItem = backBarBtnItem
        
    }
    
    
    func setNavLeft(_ imageName:String) {
        self.navigationItem.hidesBackButton = true
        
        let custom = UIButton(type: .custom)
        custom.frame = CGRect(x: 0, y: 0, width: 40, height: 44)
        custom.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        let imv = UIImageView(frame: CGRect(x: 2, y: (custom.frame.height - 16)/2 - 1, width: 9, height: 16))
        imv.image = UIImage(named: imageName)
        custom.addSubview(imv)
        let backBarButtonItem = UIBarButtonItem(customView:custom)
        self.navigationItem.leftBarButtonItem = backBarButtonItem
        
    }
    
    
    @objc func backAction() {
           navigationController?.popViewController(animated: true)
       }
    
}


extension ASBaseViewController {
    
    func navigation(_ title:String, _ normalIcon:String, _ selectIcon:String) -> ASNavigationController {
        
        let nav = ASNavigationController(rootViewController: self)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = UIImage(named: normalIcon)?.withRenderingMode(.alwaysOriginal)
        nav.tabBarItem.selectedImage = UIImage(named: selectIcon)?.withRenderingMode(.alwaysOriginal)
        
        // 全局设置title选中颜色
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor:k_333333], for: .selected)
        
        
        return nav
    }
    
    
    
}

extension UITabBar {
    open override var traitCollection: UITraitCollection {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return UITraitCollection(horizontalSizeClass: .compact)
        }
        return super.traitCollection
    }
    
}


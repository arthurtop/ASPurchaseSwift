//
//  ASNavigationController.swift
//  ASPurchase-swift
//
//  Created by AllSale on 2020/7/22.
//  Copyright © 2020 AllSale. All rights reserved.
//

import UIKit


class ASNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
        self.navigationBar.isTranslucent = false
//        if iOS.isIphoneXLater {
//            self.navigationBar.setBackgroundImage(UIImage(named: "navigationBackView-1"), for: .default)
//        } else {
//            self.navigationBar.setBackgroundImage(UIImage(named: "navigationBackView"), for: .default)
//        }
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.font:kFont18,NSAttributedString.Key.foregroundColor:k_2B2B2B]
    }
    
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
           if !self.viewControllers.isEmpty {
               viewController.hidesBottomBarWhenPushed = true
           }
           super.pushViewController(viewController, animated: animated)
           //解决iPhone X push的时候tabbar上移
           var frame = self.tabBarController?.tabBar.frame ?? CGRect.zero
           frame.origin.y = frame.size.height == 0 ? 0 : k_screen_height - frame.size.height
           self.tabBarController?.tabBar.frame = frame
        
//        self.tabBarController.AS
       }
       
       override func popViewController(animated: Bool) -> UIViewController? {
           super.popViewController(animated: animated)
           return self
       }
    
}

//
//  BaseCtlProtocolEx.swift
//  ASPurchase-swift
//
//  Created by AllSale on 2020/9/11.
//  Copyright © 2020 AllSale. All rights reserved.
//

import UIKit

//BaseCtlProtocolEx


// MARK -- 主题协议扩展
protocol ThemeProvider {
    
    func applyDarkMode()
    func removeDarkMode()
}


extension ThemeProvider where Self: UIViewController{
    
    func applyDarkMode() {
        view.backgroundColor = .black
    }
    
    func removeDarkMode(){
        view.backgroundColor = .white
    }
    
    func isCuttentDark()-> Bool {
        return view.backgroundColor == .black
    }
    
}

// MARK -- 错误处理 协议扩展
protocol ErrorPresentable {
    func showAlert(error: Error)
}


extension ErrorPresentable where Self: UIViewController {
    
    func showAlert(error: Error) {
        let alert: UIAlertController = UIAlertController(title: error.localizedDescription, message: nil, preferredStyle: .alert)
        alert.addAction(.init(title: "Dismiss", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
}



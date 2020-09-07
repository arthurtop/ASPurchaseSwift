//
//  LoginView.swift
//  ASPurchase-swift
//
//  Created by AllSale on 2020/8/18.
//  Copyright © 2020 AllSale. All rights reserved.
//

import UIKit
import RxSwift


class LoginView: UIView {

    @IBOutlet weak var accoutTextF: UITextField!
    
    
    @IBOutlet weak var passwordTextF: UITextField!
    
    
    let disposeBag = DisposeBag()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
        
        autoresizingMask = UIView.AutoresizingMask()
        
        
        
        accoutTextF.text = "Username has to be at least"
        passwordTextF.text = "Password has to be at least"
        
        
        
        
        /***  1. 输入用户名-》用户名是否有效-〉用户名提示是否隐藏/密码输入框是否可用   ***/
        
        let usernameValid = accoutTextF.rx.text.orEmpty
            .map { $0.count >= 8}
        .share()
        
        usernameValid.bind(to: passwordTextF.rx.isEnabled)
        .disposed(by: disposeBag)
        
        usernameValid.bind(to: accoutTextF.rx.isHidden)
        .disposed(by: disposeBag)
        
        
        
        /***  2. 输入密码-》密码是否有效-〉密码提示是否隐藏   ***/
        let passwordValid = passwordTextF.rx.text.orEmpty
            .map{ $0.count >= 8}
        .share()
        
        passwordValid.bind(to: passwordTextF.rx.isHidden)
        .disposed(by: disposeBag)
        
        
        /*
        3. 密码是否有效/用户名是否有效-》登录按钮是否可用
        */
//        let everythingVaild = Observable
//            .combineLatest(usernameValid,passwordValid){ $0 && $1}
//        .share()
        
//        everythingVaild
//        .bind(to: dos)
        
        
        
        
        
    }
    
    
    
    
    

}

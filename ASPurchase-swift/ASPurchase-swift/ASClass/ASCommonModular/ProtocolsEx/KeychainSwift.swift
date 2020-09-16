//
//  KeychainSwift.swift
//  ASPurchase-swift
//
//  Created by AllSale on 2020/9/11.
//  Copyright © 2020 AllSale. All rights reserved.
//

import UIKit
import Foundation
//import ke

protocol TokenStore {
    var accessToken: String { get set}
    var refreshToken: String { get set}
}


//extension KeychainSwift: TokenStore {
//
//    private enum Keys {
//        static let accessToken = ""
//        static let refreshToken = ""
//    }
//    var accessToken: String {
//    get { return get(Keys.accessToken) }
//    set { set(newValue, forKey: Keys.accessToken) }
//}

//var refreshToken: String {
//    get { return get(Keys.refreshToken) }
//    set { set(newValue, forKey: Keys.refreshToken)}
//}

//}

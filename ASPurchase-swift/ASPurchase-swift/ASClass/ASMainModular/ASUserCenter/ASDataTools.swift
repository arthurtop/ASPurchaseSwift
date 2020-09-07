//
//  ASDataTools.swift
//  ASPurchase-swift
//
//  Created by AllSale on 2020/7/24.
//  Copyright © 2020 AllSale. All rights reserved.
//

import UIKit

open class ASDataTools: NSObject {

    @discardableResult
    static func saveObject(_ obj:Any,forKey key:String) -> Bool {
        if key == "" {
            return false
        }
        let userDefalut = UserDefaults.standard
        if (obj as AnyObject).isEqual(NSNull()) {
            userDefalut.removeObject(forKey: key)
            return false
        }
        
        
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: obj, requiringSecureCoding: false)
            userDefalut.set(data, forKey: key)
            
            print("归档成功!!!")
        } catch {
             print("写入失败: \(error)")
        }
        
        
        return userDefalut.synchronize()
    }
    
    
    @discardableResult
    static func getObject(forKey key:String) -> AnyObject? {
        if key == "" {
            return nil
        }
        let userDefalut = UserDefaults.standard
        if let data = userDefalut.object(forKey: key) as? Data {
//            return NSKeyedUnarchiver.unarchiveObject(with: data) as AnyObject?
            
            //解档
            do {
                let model = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? UserModel
                return model
            }
//            catch {
//                print("获取data数据失败: \()")
//            }
            
        }
        return nil
    }
    
    static func removeObject(_ key:String) {
        let userDefalut = UserDefaults.standard
        userDefalut.removeObject(forKey: key)
        userDefalut.synchronize()
    }
    
    @discardableResult
    static func saveObjectEncode<T>(_ obj:T,forKey key:String) -> Bool? where T : Encodable {
        if key == "" {
            return false
        }
        let userDefalut = UserDefaults.standard
        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(obj)
            userDefalut.set(jsonData, forKey: key)
            userDefalut.synchronize()
        } catch {
            print(error.localizedDescription)
            return false
        }
        return true
    }
    
    @discardableResult
    static func getObjectDecode<T>(_ type: T.Type, forKey key: String) -> T? where T : Decodable {
        if key == "" {
            return nil
        }
        let userDefalut = UserDefaults.standard
        do {
            if let jsonData = userDefalut.object(forKey: key) as? Data {
                let decoder = JSONDecoder()
                let decoded = try decoder.decode(type, from: jsonData)
                return decoded
            }
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    static func cacheObject(_ obj:Any,forKey key:String) -> Bool {
        if (obj as AnyObject).isEqual(NSNull()) || key == "" {
            return false
        }
        let fm = FileManager.default
        let path:String = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
        let cachePath = path + "/important"
        if !fm.fileExists(atPath: cachePath) {
            do {
                try fm.createDirectory(atPath: cachePath, withIntermediateDirectories: true, attributes: nil)
            } catch _{
                
            }
        }
        let finishPath = cachePath.appendingFormat("/%@.plist",key)
        
        return NSKeyedArchiver.archiveRootObject(obj, toFile: finishPath)
    }
    
    static func getCacheObject(forKey key:String) -> AnyObject? {
        if key == "" {
            return nil
        }
        let fm = FileManager.default
        let path:String = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
        let cachePath = path + "/important"
        if !fm.fileExists(atPath: cachePath) {
            do {
                try fm.createDirectory(atPath: cachePath, withIntermediateDirectories: true, attributes: nil)
            } catch _{
                
            }
        }
        let finishPath = cachePath.appendingFormat("/%@.plist",key)
        return NSKeyedUnarchiver.unarchiveObject(withFile: finishPath) as AnyObject?
    }
    
    static func removeCacheObject(forKey key:String) -> Bool {
        if key == "" {
            return false
        }
        let fm = FileManager.default
        let path:String = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
        let cachePath = path + "/important"
        let finishPath = cachePath.appendingFormat("/%@.plist",key)
        if !fm.fileExists(atPath: finishPath) {
            return false
        }
        do {
            try fm .removeItem(atPath: finishPath)
        } catch _{
            
        }
        return true
    }
    
}

extension ASDataTools {
    
    /*
    static var homeStore:UBStoreModel? {
        get {
            if let tab = k_delegate.window?.rootViewController as? UITabBarController {
                if let hnv = tab.viewControllers?.first as? UINavigationController {
                    if let h = hnv.viewControllers.first as? ASHomeViewController {
                        return h.viewModel.store
                    }
                }
            }
            return nil
        }
    }

    static func randomProducts(_ callback:((_ list:[UBStoreProductModel])->())?) {
        if let store = ASDataTools.homeStore {
            if let block = callback {
                block(store.random().random())
            }
        }
    }
    */
    
    
    //        UBDataTools.randomProducts { [weak self] (advice) in
    //            self?.viewModel.advices = advice
    //            self?.collection.reloadData()
    //        }
    
    //        UBDataTools.randomProducts { [weak self] (advice) in
    //            self?.viewModel.advices = advice
    //            self?.collection.reloadData()
    //        }
    
}


extension ASDataTools {
    
    static func jsLocal() -> Array<String> {
        let ptath = Bundle.main.bundlePath + "/WebAss/libs/min"
        let fm = FileManager.default
        if let arr = fm.subpaths(atPath: ptath) {
            let arr1 = arr.filter { (name) -> Bool in
                return name.hasSuffix(".js")
            }
            let arr2 = arr1.map { (val) -> String in
                return val.replacingOccurrences(of: ".js", with: "")
            }
            return arr2
        }
        return [String]()
    }
    
    static func checkjs(_ url:String) -> (Bool,Data?) {
        DLog("------ url = ",url)
        guard let last = url.components(separatedBy: "/").last else {
            return (false,nil)
        }
        let name = last.replacingOccurrences(of: ".js", with: "")
//        DLog("------ name = ",name)
        var loacalJsName = ""
        for item in ASDataTools.jsLocal() {
            if name.contains(item) {
                loacalJsName = item
                break
            }
        }
        if !loacalJsName.isEmpty {
            let u = Bundle.main.url(forResource: loacalJsName, withExtension: "js", subdirectory: "WebAss/libs/min")
            guard let url = u else {
                return (false,nil)
            }
            do {
                let data = try Data(contentsOf: url)
                return (true,data)
            } catch {
                
            }
        }
        return (false,nil)
    }
}

extension ASDataTools {
    
    static func refresh(_ time:Int) -> String {
        let h = String(time/3600)
        let m = String((time%3600)/60)
        let s = String(time%60)
        let hh = h.count >= 2 ? h : ("0" + h)
        let mm = m.count >= 2 ? m : ("0" + m)
        let ss = s.count >= 2 ? s : ("0" + s)
        return hh + ":" + mm + ":" + ss
    }
    
}

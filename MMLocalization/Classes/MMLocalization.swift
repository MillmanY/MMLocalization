//
//  MMLocaliztion.swift
//  Pods
//
//  Created by MILLMAN on 2016/8/15.
//
//

import UIKit
let TableName = "LocalizationTable"
public enum TableType {
    case system
    case custom(tableName:String)
}

open class MMLocalization: NSObject {
    var type:TableType = .system {
        didSet {
            switch type {
            case .custom(let tableName):
                UserDefaults.standard.setValue(tableName, forKey: TableName)
            default:
                UserDefaults.standard.removeObject(forKey: TableName)
            }
            UserDefaults.standard.synchronize()
        }
    }
    
    static let shared = MMLocalization()
    
    open static func set(type:TableType) {
        MMLocalization.shared.type = type
    }
    
    open static func loadSetting() -> Bool {
        if let tableName = UserDefaults.standard.value(forKey: TableName) as? String{
        
            MMLocalization.shared.type = .custom(tableName: tableName)
            return true
        }
        return false
    }
}

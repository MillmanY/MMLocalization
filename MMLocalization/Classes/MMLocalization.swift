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
    
    public static func start() {
        UILabel.replaceSetText()
        UINavigationItem.replaceSetText()
        UIButton.replaceSizeMethod()
    }

    public static func set(type:TableType) {
        MMLocalization.shared.type = type
    }
    
    public static func loadSetting() -> Bool {
        if let tableName = UserDefaults.standard.value(forKey: TableName) as? String{
            MMLocalization.shared.type = .custom(tableName: tableName)
            return true
        }
        return false
    }
}

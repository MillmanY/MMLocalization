//
//  MMLocaliztion.swift
//  Pods
//
//  Created by MILLMAN on 2016/8/15.
//
//

import UIKit
let TableName = "LocalizationTable"

open class MMLocalization: NSObject {
    var tableName:String?
    static let shareInstance = MMLocalization()
    
    open static func loadSetting() -> Bool {
        if let table = UserDefaults.standard.value(forKey: TableName) as? String{
            MMLocalization.shareInstance.tableName = table
            return true
        }
        return false
    }
    
    open static func setLocalizedStrinbTable(_ tableName:String) {
        MMLocalization.shareInstance.tableName = tableName
    }
    
    open static func save() {
        UserDefaults.standard.setValue(MMLocalization.shareInstance.tableName, forKey: TableName)
    }
}

//
//  MMLocaliztion.swift
//  Pods
//
//  Created by MILLMAN on 2016/8/15.
//
//

import UIKit
let TableName = "LocalizationTable"
public func localString(str:String) -> String {
    if let tableName = MMLocalization.shareInstance.tableName {
        return (str.isEmpty) ? str :  NSLocalizedString(str, tableName:tableName, comment: "")
    } else {
        // If you didn't setting your table return original string
        return str
    }
}

public class MMLocalization: NSObject {
    var tableName:String?
    static let shareInstance = MMLocalization()
    
    public static func loadSetting() -> Bool {
        if let table = NSUserDefaults.standardUserDefaults().valueForKey(TableName) as? String{
            MMLocalization.shareInstance.tableName = table
            return true
        }
        return false
    }
    
    public static func setLocalizedStrinbTable(tableName:String) {
        MMLocalization.shareInstance.tableName = tableName
    }
    
    public static func save() {
        NSUserDefaults.standardUserDefaults().setValue(MMLocalization.shareInstance.tableName, forKey: TableName)
    }
}

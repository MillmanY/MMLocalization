//
//  StringExtension.swift
//  Pods
//
//  Created by Millman YANG on 2017/4/13.
//
//

import Foundation

public extension String {
    
    public func localize() -> String {
        
        if let tableName = MMLocalization.shareInstance.tableName {
            return self.localizeWith(value: self, table: tableName)
        } else {
            // If you didn't setting your table return original string
            return self
        }
    }
    
    public func localize(table:String) -> String {
        return self.localizeWith(value: self, table: table)
    }
    
    
    private func localizeWith(value:String ,table:String) -> String {
        return (self.isEmpty) ? self :  NSLocalizedString(self, tableName:table, comment: "")
    }
    
}

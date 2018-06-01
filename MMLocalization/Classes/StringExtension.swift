//
//  StringExtension.swift
//  Pods
//
//  Created by Millman YANG on 2017/4/13.
//
//

import Foundation

public extension String {
    
    public func localize(arg: CVarArg...) -> String {
        switch MMLocalization.shared.type {
        case .system:
            let local = NSLocalizedString(self, comment: "")
            if arg.count > 0 {
                return String(format: local,arguments: arg)
            } else {
                return local
            }
        case .custom(let tableName):
            let local = self.localizeWith(value: self, table: tableName)
            if arg.count > 0 {
                return String(format: local,arguments: arg)
            } else {
                return local
            }
        }
    }
    
    public func localize(table:String) -> String {
        return self.localizeWith(value: self, table: table)
    }
    
    private func localizeWith(value:String ,table:String) -> String {
        return (self.isEmpty) ? self :  NSLocalizedString(self, tableName:table, comment: "")
    }
}

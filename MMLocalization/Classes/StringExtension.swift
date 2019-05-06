//
//  StringExtension.swift
//  Pods
//
//  Created by Millman YANG on 2017/4/13.
//
//

import Foundation

public extension String {
    
    func localize(arg: CVarArg...) -> String {
        switch MMLocalization.shared.type {
        case .systemWith(let lproj):
            guard let path = Bundle.main.path(forResource: lproj, ofType: "lproj"),
                let bundle = Bundle(path: path) else {
                    return ""
            }
            let local = NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
            return self.combine(value: local, arg: arg)
        case .system:
            let local = NSLocalizedString(self, comment: "")
            return self.combine(value: local, arg: arg)
        case .custom(let tableName):
            let local = NSLocalizedString(self, tableName:tableName, comment: "")
            return self.combine(value: local, arg: arg)
        }
    }
    
    func combine(value: String, arg: CVarArg...) -> String {
        if self.isEmpty {
            return ""
        } else if arg.count > 0 {
            return String(format: value,arguments: arg)
        } else {
            return value
        }
    }
}

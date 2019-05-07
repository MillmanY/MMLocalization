//
//  UIBar+Localize.swift
//  MMLocalization
//
//  Created by Millman on 2019/5/6.
//

import Foundation
private var titleTextKey = "UIBarItem+Text+Key"

extension UIBarItem {
    var textKey: String? {
        set {
            objc_setAssociatedObject(self, &titleTextKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        } get {
            guard let key = objc_getAssociatedObject(self, &titleTextKey) as? String else {
                return nil
            }
            return key
        }
    }
}


extension UITabBar {
    @objc func customDidMoveToWindow() {
        self.customDidMoveToWindow()
        self.reloadWithLocalize()
    }
    
    func reloadWithLocalize() {
        self.items?.forEach({ (item) in
            let title = item.title
            if let local = title?.localize(), local != title {
                item.textKey = title
            }
            if let local = item.textKey?.localize(), local != title {
                item.title = local
            }
        })
    }
    
    static func replaceSetText(){
        let originalSelector = #selector(UITabBar.didMoveToWindow)
        let swizzledSelector = #selector(UITabBar.customDidMoveToWindow)
        self.replaceSelector(from: originalSelector, to: swizzledSelector)
    }
}


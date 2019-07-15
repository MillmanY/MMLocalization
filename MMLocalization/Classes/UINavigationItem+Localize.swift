//
//  UINavigationItem+Localize.swift
//  ETNews
//
//  Created by Millman YANG on 2017/4/20.
//  Copyright © 2017年 Sen Informatoin co. All rights reserved.
//

import UIKit
private var titleTextKey = "UINavigationItem+Text+Key"
extension UINavigationItem {

    private var textKey: String? {
        set {
            objc_setAssociatedObject(self, &titleTextKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        } get {
            guard let key = objc_getAssociatedObject(self, &titleTextKey) as? String else {
                return nil
            }
            return key
        }
    }
    
    static func replaceSetText(){
        var originalSelector = #selector(setter: UINavigationItem.title)
        var swizzledSelector = #selector(UINavigationItem.itemTitle(_:))
        self.replaceSelector(from: originalSelector, to: swizzledSelector)
        
        originalSelector = #selector(getter: UINavigationItem.title)
        swizzledSelector = #selector(UINavigationItem.getItemTitle)
        self.replaceSelector(from: originalSelector, to: swizzledSelector)
    }
    
    @objc func getItemTitle() -> String? {
        return self.textKey?.localize()
    }
    
    @objc func itemTitle(_ input: String?) {
        if let t = input {
            let local = t.localize()
            self.textKey = t
            self.itemTitle(local)
        } else {
            self.textKey = nil
        }
    }
}


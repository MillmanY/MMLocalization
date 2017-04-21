//
//  UINavigationItem+Localize.swift
//  ETNews
//
//  Created by Millman YANG on 2017/4/20.
//  Copyright © 2017年 Sen Informatoin co. All rights reserved.
//

import UIKit
extension UINavigationItem {

    static func replaceSetText(){
        let originalSelector = #selector(setter: UINavigationItem.title)
        let swizzledSelector = #selector(UINavigationItem.itemTitle(_:))
        
        let originalMethod = class_getInstanceMethod(self, originalSelector)
        let swizzledMethod = class_getInstanceMethod(self, swizzledSelector)
        
        let didAddMethod = class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
        
        if didAddMethod {
            class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }
    
    func itemTitle(_ input: String?) {
        if let t = input {
            self.itemTitle(t.localize())
        }
    }
}

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
        self.replaceSelector(from: originalSelector, to: swizzledSelector)
    }
    
    func itemTitle(_ input: String?) {
        if let t = input {
            self.itemTitle(t.localize())
        }
    }
}

//
//  UIButton+Localize.swift
//  MMLocalization
//
//  Created by Millman on 2019/11/5.
//

//
//  UIButton+Localize.swift
//  MMLocalization
//
//  Created by Millman on 2019/1/31.
//

import Foundation
private var titleTextKey = "UINavigationItem+Text+Key"
extension UIButton {
    
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
        var originalSelector = #selector(UIButton.didMoveToWindow)
        var swizzledSelector = #selector(UIButton.customDidMoveToWindow)
        self.replaceSelector(from: originalSelector, to: swizzledSelector)
        
        
        originalSelector = #selector(UIButton.setTitle(_:for:))
        swizzledSelector = #selector(UIButton.customSetTitle(_:for:))
        self.replaceSelector(from: originalSelector, to: swizzledSelector)
        
    }
    
    @objc func customSetTitle(_ title: String?, for state: UIControl.State) {
        if let t = title {
            let local = t.localize()
            if local != t {
                self.textKey = t
            }
            self.customSetTitle(local, for: state)
        } else {
            self.textKey = nil
            self.customSetTitle(nil, for: state)
        }
    }
    
    @objc func customDidMoveToWindow() {
        self.customDidMoveToWindow()
        if let key = self.titleLabel?.textKey {
            self.textKey = key
        }
        if let key = self.textKey, self.currentTitle != key.localize() {
            self.setTitle(key.localize(), for: .normal)
        }
    }
}

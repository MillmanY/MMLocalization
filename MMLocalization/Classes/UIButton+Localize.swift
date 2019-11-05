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
        let originalSelector = #selector(UIButton.didMoveToWindow)
        let swizzledSelector = #selector(UIButton.customDidMoveToWindow)
        self.replaceSelector(from: originalSelector, to: swizzledSelector)
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

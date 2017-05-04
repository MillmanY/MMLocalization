//  Created by MILLMAN on 2016/7/8.
//  Copyright © 2016年 MILLMAN. All rights reserved.
//

import UIKit
private var ChangeKey = "ChangeAllText"
private var originalKey = "TextKey"
private var defaultValue = ["Label",""]
public extension UILabel {
    
    fileprivate var textKey:String? {
        set {
            if let new = newValue , !defaultValue.contains(new)   {
                let key = (new != new.localize() ) ? new : nil
                objc_setAssociatedObject(self, &originalKey, key, .OBJC_ASSOCIATION_RETAIN)
            }
        } get {
            if let key = objc_getAssociatedObject(self, &originalKey) as? String {
                return key
            } else {
                return nil
            }
        }
    }
    
    static func replaceSetText(){
        let originalSelector = #selector(setter: UILabel.text)
        let swizzledSelector = #selector(UILabel.customSetText(_:))
        let originalMethod = class_getInstanceMethod(self, originalSelector)
        let swizzledMethod = class_getInstanceMethod(self, swizzledSelector)
        
        let didAddMethod = class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
        
        if didAddMethod {
            class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        
        textKey = self.text
        if let att = self.attributedText{
            let attribue = NSMutableAttributedString(string: att.string.localize())
            let length = (attribue.length < att.length) ? attribue.length :att.length
            att.enumerateAttributes(in: NSMakeRange(0, length), options: .longestEffectiveRangeNotRequired, using: { (obj, range, stop) in
                
                attribue.addAttributes(obj, range: range)
            })
            self.attributedText = attribue
        } else {
            let t = self.text
            self.text = (t)
        }
    }
    
    open override func didMoveToWindow() {
        if let key = self.textKey {
            self.text = key
        } else if let t = self.text , !t.isEmpty , t != t.localize() {
            self.text = t
        }
    }
    
    func customSetText(_ input: String?) {
        if let t = input {
            let local = t.localize()
            self.textKey = t
            let needResize = (local != self.text && self.text != nil && local != t && self.textKey != nil)
            self.customSetText(local)
            
            if needResize {
                self.sizeToFit()
            }
        } else if input == nil && self.text != nil{
            self.textKey = nil
            self.customSetText(nil)
        }
    }
}

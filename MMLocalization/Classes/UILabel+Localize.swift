//  Created by MILLMAN on 2016/7/8.
//  Copyright © 2016年 MILLMAN. All rights reserved.
//

import UIKit
private var ChangeKey = "ChangeAllText"
private var originalKey = "TextKey"
private var defaultValue = ["Label",""]
extension UILabel {
    
    fileprivate var textKey:String? {
        set {
            if let new = newValue , !defaultValue.contains(new)   {
                let key = (new != new.localize() ) ? new : nil
                objc_setAssociatedObject(self, &originalKey, key, .OBJC_ASSOCIATION_RETAIN)
            }
            if newValue == nil {
                objc_setAssociatedObject(self, &originalKey, nil, .OBJC_ASSOCIATION_RETAIN)
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
        var originalSelector = #selector(setter: UILabel.text)
        var swizzledSelector = #selector(UILabel.customSetText(_:))
        self.replaceSelector(from: originalSelector, to: swizzledSelector)
        
        originalSelector = #selector(UILabel.awakeFromNib)
        swizzledSelector = #selector(UILabel.customAwakeFromNib)
        self.replaceSelector(from: originalSelector, to: swizzledSelector)
        
        originalSelector = #selector(UILabel.didMoveToWindow)
        swizzledSelector = #selector(UILabel.customDidMoveToWindow)
        self.replaceSelector(from: originalSelector, to: swizzledSelector)
    }
    
    @objc func customAwakeFromNib() {
        self.customAwakeFromNib()
        textKey = self.text
        if let att = self.attributedText, !att.string.isEmpty {
            let attribue = NSMutableAttributedString(string: att.string.localize())
            let length = (attribue.length < att.length) ? attribue.length :att.length
            att.enumerateAttributes(in: NSMakeRange(0, length), options: .longestEffectiveRangeNotRequired, using: { (obj, range, stop) in
                
                attribue.addAttributes(obj, range: range)
            })
            self.attributedText = attribue
        } else if let t = self.text, !t.isEmpty {
            self.text = t
        }
    }
    
    @objc func customDidMoveToWindow() {
        self.customDidMoveToWindow()
        if let key = self.textKey {
            self.text = key
        } else if let t = self.text , !t.isEmpty , t != t.localize() {
            self.text = t
        }
    }

    @objc func customSetText(_ input: String?) {
        guard let t = input else {
            self.textKey = nil
            self.customSetText(nil)
            return
        }
        
        let local = t.localize()
        if local == self.text {
            return
        } else if t.isEmpty {
            self.textKey = nil
            self.customSetText("")
        } else {
            self.textKey = t
            let needResize = (local != self.text && local != t && self.textKey != nil && self.constraints.count == 0)
            self.customSetText(local)
            if needResize {
                self.sizeToFit()
            }
        }
    }
}


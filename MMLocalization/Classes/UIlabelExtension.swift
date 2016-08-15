//
//  UIlabelExtension.swift
//  LocalLizeDemo
//
//  Created by MILLMAN on 2016/7/8.
//  Copyright © 2016年 MILLMAN. All rights reserved.
//

import UIKit
private var ChangeKey = "ChangeAllText"
private var originalKey = "TextKey"
public extension UILabel {
    
    private var textKey:String? {
        set {
            objc_setAssociatedObject(self, &originalKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        } get {
            if let key = objc_getAssociatedObject(self, &originalKey) as? String {
                return key
            } else {
                return nil
            }
        }
    }
    
    public override class func initialize() {
        
        struct Static {
            static var token: dispatch_once_t = 0
        }
        
        if self !== UILabel.self {
            return
        }
        
        dispatch_once(&Static.token){
            self.replaceSetText()
        }
    }
    
    static func replaceSetText(){
        let originalSelector = Selector("setText:")
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
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        textKey = self.text

        if let att = self.attributedText{
            let attribue = NSMutableAttributedString(string: localString(att.string))
            let length = (attribue.length < att.length) ? attribue.length :att.length
            att.enumerateAttributesInRange(NSMakeRange(0, length), options: .LongestEffectiveRangeNotRequired, usingBlock: { (obj, range, stop) in
                
                attribue.addAttributes(obj, range: range)
            })
            self.attributedText = attribue
        } else {
            self.text = (text)
        }
    }
    
    public override func didMoveToWindow() {
        if let key = self.textKey {
            self.text = key
        }
    }
    
    func customSetText(t: String) {
        let text = localString(t)
        if text != self.text {
            textKey = t
            self.customSetText(text)
            self.resetWidth()
        }
    }
    
    private func resetWidth() {
        var frame = self.frame
        frame.size.width = self.calculateWidth()
        self.frame = frame
    }
    
    private func calculateWidth() -> CGFloat {
        let currentWidth = CGRectGetWidth(self.frame)
        let fixWidth = self.intrinsicContentSize().width
        return (currentWidth > fixWidth) ? currentWidth : fixWidth
    }
}



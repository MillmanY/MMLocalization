//
//  UIButton+Localize.swift
//  MMLocalization
//
//  Created by Millman on 2019/1/31.
//

import Foundation
extension UIButton {
    
    static func replaceSetText(){
        let originalSelector = #selector(UIButton.awakeFromNib)
        let swizzledSelector = #selector(UIButton.customAwakeFromNib)
        self.replaceSelector(from: originalSelector, to: swizzledSelector)
    }
    
    @objc func customAwakeFromNib() {
        self.customAwakeFromNib()
        self.setTitle(self.titleLabel?.text?.localize(), for: self.state)
    }
}

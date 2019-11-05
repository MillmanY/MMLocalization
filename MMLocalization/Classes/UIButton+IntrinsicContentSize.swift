//
//  UIButton+IntrinsicContentSize.swift
//  MMLocalization
//
//  Created by Millman YANG on 2017/10/19.
//

import Foundation


extension UIButton {
    
    static func replaceSizeMethod() {
        let from = #selector(getter: self.intrinsicContentSize)
        let to = #selector(UIButton.customIntrinsicContentSize)
        self.replaceSelector(from: from, to: to)
    }
    
    @objc func customIntrinsicContentSize() -> CGSize {
        if let classType = NSClassFromString("_UIModernBarButton"),
               self.isKind(of: classType) == true {
            guard let buttonClass = NSClassFromString("UIButtonLabel") else {
                return self.customIntrinsicContentSize()
            }
            let view = self.subviews.first(where: { $0.isKind(of: buttonClass) == true })
            return view?.sizeThatFits(.zero) ?? self.customIntrinsicContentSize()
        } else if let key = self.titleLabel?.textKey, let titleLab = self.titleLabel {
            let currentW = titleLab.frame.width
            let keyW = key.calWidthWith(height: titleLab.frame.height, font: self.titleLabel?.font)
            var will = self.customIntrinsicContentSize()
            let willW = will.width-(keyW-currentW)
            if willW > 0 {
                will.width = willW
            }
            return will
        }
        
        return self.customIntrinsicContentSize()
    }
    
}

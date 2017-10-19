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
        } else {
            return self.customIntrinsicContentSize()
        }
    }
    
}

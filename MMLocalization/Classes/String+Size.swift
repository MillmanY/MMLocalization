//
//  String+Size.swift
//  MMLocalization
//
//  Created by Millman on 2019/11/5.
//

import Foundation

extension String {
    func calWidthWith(height: CGFloat, font: UIFont?) -> CGFloat {
        
        guard let f = font else {
            return .zero
        }
        
        let size = CGSize(width: CGFloat.greatestFiniteMagnitude, height: height)
        let textH = (self as NSString).boundingRect(with: size,
                                                 options: .usesLineFragmentOrigin,
                                                 attributes: [NSAttributedString.Key.font: f], context: NSStringDrawingContext()).size.width
        return ceil(textH)
    }
}

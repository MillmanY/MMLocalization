//
//  UIApplication+Load.swift
//  Pods
//
//  Created by Millman YANG on 2017/4/21.
//
//

import Foundation

import UIKit

extension UIApplication {
    
    private static let runOnce: Void = {
        UILabel.replaceSetText()
        UINavigationItem.replaceSetText()
    }()
    
    override open var next: UIResponder? {
        // Called before applicationDidFinishLaunching
        UIApplication.runOnce
        return super.next
    }
}

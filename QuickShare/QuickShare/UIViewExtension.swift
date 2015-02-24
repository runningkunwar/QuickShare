//
//  UIViewExtension.swift
//  QuickShare
//
//  Created by Kunwar on 2/23/15.
//  Copyright (c) 2015 Kunwar. All rights reserved.
//

import UIKit

extension UIView {
    
    var width: Float {
        get {
            return Float(CGRectGetWidth(self.bounds))
        }
    }

    var height: Float {
        get {
            return Float(CGRectGetHeight(self.bounds))
        }
    }
    
    var left: Float {
        get {
            return Float(CGRectGetMinX(self.frame))
        }
    }
    
    var right: Float {
        get {
            return Float(CGRectGetMaxX(self.frame))
        }
    }
    
    var top: Float {
        get {
            return Float(CGRectGetMinY(self.frame))
        }
    }
    
    var bottom: Float {
        get {
            return Float(CGRectGetMaxY(self.frame))
        }
    }
    
}
//
//  UIView+FrameExtensions.swift
//  QL
//
//  Created by LZX on 2021/2/21.
//

import UIKit

extension UIView {
    
    var x: CGFloat {
        get { return frame.origin.x }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.x    = newValue
            frame                 = tempFrame
        }
    }
    
    var right: CGFloat {
        get { return frame.origin.x + frame.size.width }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.x    = newValue - frame.size.width
            frame                 = tempFrame
        }
    }
    
    var y: CGFloat {
        get { return frame.origin.y }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.y    = newValue
            frame                 = tempFrame
        }
    }
    
    var height: CGFloat {
        get { return frame.size.height }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size.height = newValue
            frame                 = tempFrame
        }
    }
    
    var width: CGFloat {
        get { return frame.size.width }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size.width  = newValue
            frame = tempFrame
        }
    }
    
    var size: CGSize {
        get { return frame.size }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size        = newValue
            frame                 = tempFrame
        }
    }
    
    var origin: CGPoint {
        get { return frame.origin }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin      = newValue
            frame                 = tempFrame
        }
    }
    
    var centerX: CGFloat {
        get { return center.x }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.x            = newValue
            center                  = tempCenter
        }
    }
    
    var centerY: CGFloat {
        get { return center.y }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.y            = newValue
            center                  = tempCenter;
        }
    }
    
    var top: CGFloat {
        get { return frame.origin.y }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.y    = newValue
            frame                 = tempFrame
        }
    }

    var left: CGFloat {
        get { return frame.origin.x }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.x    = newValue
            frame                 = tempFrame
        }
    }
    
    var bottom: CGFloat {
        get { return frame.origin.y + frame.size.height }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.y    = newValue - frame.size.height
            frame                 = tempFrame
        }
    }
    
    var centerRect: CGRect {
        return CGRect(x: bounds.midX, y: bounds.midY, width: 0, height: 0)
    }
}

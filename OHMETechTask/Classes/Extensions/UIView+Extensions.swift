//
//  UIView+Extensions.swift
//  OHMETechTask
//
//  Created by Steve Lai on 25/9/2021.
//

import UIKit


extension UIView {
    func applyTransform(withScale scale: CGPoint, anchorPoint: CGPoint) {
        layer.anchorPoint = anchorPoint
        let scale = scale != .zero ? scale : CGPoint(x: CGFloat.leastNonzeroMagnitude, y: CGFloat.leastNonzeroMagnitude)
        let xPadding = 1/scale.x * (anchorPoint.x - 0.5)*bounds.width
        let yPadding = 1/scale.y * (anchorPoint.y - 0.5)*bounds.height
        transform = CGAffineTransform(scaleX: scale.x, y: scale.y).translatedBy(x: xPadding, y: yPadding)
    }
    
    
}

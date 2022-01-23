//
//  Interview.swift
//  Facebook-Interview
//
//  Created by J.A. Ramirez on 1/22/22.
//

import UIKit

// MARK: Hit Test
/*
 |----------------------------| A
 |                                          |
 |   |-----------| B        (5)      |
 |   |                |                     |      (1)
 |   |   (2)   |--------------| C   |
 |   |          |                     |     |
 |   |          | (3)                |     |
 |   |          |             (4)    |     |
 |   |          |                     |     |
 |   |          |--------------|     |
 |   |                 |                    |
 |   |-----------|                     |
 |-----------------------------|
 
 How would you implement hit test to return the UIView in which the tap occurred?
 If the user taps on (2), it should return B view.
 If the user taps on (3), it should return C view.
 If the user taps on (1), it should return nil.
 */

extension UIView {
    func hitTest(_ point: CGPoint) -> UIView? {
        
        if !self.point(inside: point, with: nil) || !isUserInteractionEnabled || isHidden {
            return nil
        }
        
        for subview in self.subviews.reversed() {
            if let hitView = subview.hitTest(point) {
                return hitView
            }
        }
        return nil
    }
}

// MARK: - CGRect Intersect


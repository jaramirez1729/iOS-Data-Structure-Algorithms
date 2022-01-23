//
//  Algorithms.swift
//  iOS-Interview
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

// MARK: - CGRect Contains
/*
 Given 2 CGRects, return true or false if rectangle 1 is contained in rectangle 2.
 */
func doesContain(_ rect1: CGRect, in rect2: CGRect) -> Bool {
    return false
}

// MARK: - CGRect Intersect
/*
 Given 2 CGRects, return true or false if rectangle 1 intersects rectangle 2.
 */
func doesIntersect(_ rect1: CGRect, with rect2: CGRect) -> Bool {
    return false
}

// MARK: - CGRect Equal
/*
 Given 2 CGRects, return true or false if rectangle 1 is the same size as rectangle 2.
 */
func areEqual(_ rect1: CGRect, to rect2: CGRect) -> Bool {
    return false
}

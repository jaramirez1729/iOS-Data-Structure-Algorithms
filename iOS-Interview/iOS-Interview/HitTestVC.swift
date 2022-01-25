//
//  HitTestVC.swift
//  iOS-Interview
//
//  Created by J.A. Ramirez on 1/24/22.
//

import Foundation
import UIKit

class HitTestVC: UIViewController {
    
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var purpleView: UIView!
    @IBOutlet weak var brownView: UIView!
    @IBOutlet weak var indigoView: UIView!
    @IBOutlet weak var tealView: UIView!
    @IBOutlet weak var orangeView: UIView!
    @IBOutlet weak var yellowView: UIView!
    @IBOutlet weak var redView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        tapGesture.numberOfTapsRequired = 1
        view.addGestureRecognizer(tapGesture)
        
        //indigoView.isUserInteractionEnabled = false
        //brownView.isHidden = true
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
//        let touch = sender.location(in: parentView)
//        print(parentView.hitTest(touch, with: nil)?.tag ?? -1)
//      
        
        let point = sender.location(in: parentView)
        if let hitView = parentView.testHitPoint(point) {
            print("Tapped on Rectangle with Tag: \(hitView.tag)")
        } else {
            print("View was not in the hierachy.")
        }
    }
}

// MARK: - Hit Test
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
 
 How would you implement hitTest to return the UIView in which the tap occurred?
 If the user taps on (2), it should return B view.
 If the user taps on (3), it should return C view.
 If the user taps on (1), it should return nil.
 */
extension UIView {
    func testHitPoint(_ point: CGPoint) -> UIView? {
        // The official hitTest method ignores any views that don't satisfy the conditions and continues.
        // it's important to know that the official hitTest method does NOT eventually return nil if a view does not
        // satisfy the conditions. This can fail inside the loop and return the correct view later.
        if isValidHit() && self.point(inside: point, with: nil) {
            for subview in subviews.reversed() {
                // If a subview has subviews, then the coordinate space is very different than the superview
                // where the touch originally occurred. If we don't convert, it can lead to invalid hits.
                if let hitView = subview.testHitPoint(subview.convert(point, from: self)) {
                    return hitView
                }
            }
            // If it has no subviews or it didn't find a hit in the subviews, then return itself since the
            // condition was already met.
            return self
        }
        return nil
    }
    
    private func isValidHit() -> Bool {
        return alpha >= 0.01 && isUserInteractionEnabled && !isHidden
    }
}

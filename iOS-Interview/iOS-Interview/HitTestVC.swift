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
            print("Rectangle: \(hitView.tag)")
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
        if isValidHit() && self.point(inside: point, with: nil) {
            for subview in subviews.reversed() {
                if let hitView = subview.testHitPoint(subview.convert(point, from: self)) {
                    return hitView
                }
            }
            return self
        }
        return nil
    }
    
    private func isValidHit() -> Bool {
        return alpha >= 0.01 && isUserInteractionEnabled && !isHidden
    }
}

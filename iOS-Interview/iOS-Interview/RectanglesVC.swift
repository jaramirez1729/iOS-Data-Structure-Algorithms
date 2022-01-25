//
//  ViewController.swift
//  iOS-Interview
//
//  Created by J.A. Ramirez on 1/22/22.
//

import UIKit

// MARK: - CGRect Intersect
/*
 Given 2 CGRects, return true or false if rectangle 1 intersects rectangle 2.
 (0,0)-------------x (100, 0)
 
 |------|
 |         |
 |------|
 
            |------|
            |         |
            |------|
 
 y (0, 100)
 */
func doesIntersect(_ rect1: CGRect, with rect2: CGRect) -> Bool {
    let isOutsideX = rect1.minX > rect2.maxX || rect1.maxX < rect2.minX
    let isOutsideY = rect1.minY > rect2.maxY || rect1.maxY < rect2.minY
    return !(isOutsideX || isOutsideY)
}

// MARK: - CGRect Contains
/*
 Given 2 CGRects, return true if rectangle 1 is contained within rectangle 2.
(0,0)-------------x (100, 0)

|------|
|    O    |
|------|

y (0, 100)
*/
func doesContain(rect1: CGRect, in rect2: CGRect) -> Bool {
    let isWithinX = rect1.minX >= rect2.minX && rect1.maxX <= rect2.maxX
    let isWithinY = rect1.minY >= rect2.minY && rect1.maxY <= rect2.maxY
    return isWithinX && isWithinY
}

// MARK: - CGRect Equal
/*
 Given 2 CGRects, return true or false if rectangle 1 is the same size as rectangle 2.
 By size only?
 By same "reference"?
 By same position?
 */
func areEqual(_ rect1: CGRect, to rect2: CGRect) -> Bool {
//    let isSameOrigin = rect1.origin == rect2.origin
    let isEqualSize = rect1.width == rect2.width && rect1.height == rect2.height
    
//    return isSameOrigin && isEqualSize
    return isEqualSize
}

// MARK: - View Controller
class RectanglesVC: UIViewController {

    @IBOutlet weak var purpleView: UIView!
    @IBOutlet weak var redView: UIView!
    @IBOutlet weak var tealView: UIView!
    @IBOutlet weak var yellowView: UIView!
    @IBOutlet weak var grayView: UIView!
    @IBOutlet weak var greenView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIntersections()
        checkContains()
        checkEqual()
    }
    
    private func checkIntersections() {
        assert(doesIntersect(redView.frame, with: purpleView.frame) == true)
        assert(doesIntersect(tealView.frame, with: purpleView.frame) == true)
        assert(doesIntersect(yellowView.frame, with: purpleView.frame) == false)
        assert(doesIntersect(grayView.frame, with: purpleView.frame) == true)
        assert(doesIntersect(tealView.frame, with: yellowView.frame) == false)
        assert(doesIntersect(redView.frame, with: yellowView.frame) == false)
        assert(doesIntersect(redView.frame, with: grayView.frame) == false)
        assert(doesIntersect(grayView.frame, with: greenView.frame) == true)
    }
    
    private func checkContains() {
        assert(doesContain(rect1: tealView.frame, in: purpleView.frame) == true)
        assert(doesContain(rect1: redView.frame, in: purpleView.frame) == false)
        assert(doesContain(rect1: yellowView.frame, in: grayView.frame) == true)
        assert(doesContain(rect1: grayView.frame, in: greenView.frame) == true)
        assert(doesContain(rect1: greenView.frame, in: grayView.frame) == true)
        assert(doesContain(rect1: tealView.frame, in: redView.frame) == false)
    }
    
    private func checkEqual() {
        assert(areEqual(tealView.frame, to: yellowView.frame) == true)
        assert(areEqual(tealView.frame, to: redView.frame) == false)
        assert(areEqual(grayView.frame, to: greenView.frame) == true)
        assert(areEqual(purpleView.frame, to: grayView.frame) == false)
        assert(areEqual(purpleView.frame, to: redView.frame) == false)
        
        let negView = UIView(frame: CGRect(x: 200, y: 200, width: -12, height: -12))
        let negView2 = UIView(frame: CGRect(x: 200, y: 200, width: 12, height: 12))
        negView2.backgroundColor = UIColor.darkGray
        view.addSubview(negView)
        view.addSubview(negView2)
        assert(areEqual(negView.frame, to: negView2.frame) == true)
    }
}

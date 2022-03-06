//
//  TwoPointersAlgorithmsTests.swift
//  DesignPatternsTests
//
//  Created by J.A. Ramirez on 2/27/22.
//

import XCTest
@testable import DesignPatterns

// MARK: - Remove Duplicates from Sorted Array (Easy)
class RemoveDuplicatesTests: XCTestCase {
    func test1() {
        var nums = [1, 2, 3, 3, 4, 5, 5, 6]
        XCTAssertEqual(removeDuplicates(&nums), 6)
    }
    
    func test2() {
        var nums = [1, 1, 2]
        XCTAssertEqual(removeDuplicates(&nums), 2)
    }
    
    func test3() {
        var nums = [0, 0, 1, 1, 1 ,2, 2, 3, 3, 4]
        XCTAssertEqual(removeDuplicates(&nums), 5)
    }
}

// MARK: - Remove Element (Easy)
class RemoveElementTests: XCTestCase {
    func test1() {
        
    }
}

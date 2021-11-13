//
//  ArrayAlgorithmsTests.swift
//  ArrayAlgorithmsTests
//
//  Created by J.A. Ramirez on 11/13/21.
//

import XCTest
@testable import ArrayAlgorithms

class ArrayAlgorithmsTests: XCTestCase {
    
    // MARK: - Find the Union of 2 Sorted Arrays
    func testFindUnionOfArrays() {
        var a = [2, 4, 6, 8, 12] 
        var b = [3, 5, 4, 8, 43, 100]
        var result = findUnionOfArrays(a: a, b: b)
        XCTAssertEqual(result, [4, 8])
        
        a = [2, 4, 6, 8, 12] 
        b = [3, 5, 43, 100]
        result = findUnionOfArrays(a: a, b: b)
        XCTAssertEqual(result, [])
        
        a = [] 
        b = []
        result = findUnionOfArrays(a: a, b: b)
        XCTAssertEqual(result, [])
        
        a = [] 
        b = [3, 5, 43, 100]
        result = findUnionOfArrays(a: a, b: b)
        XCTAssertEqual(result, [])
        
        a = [1, 1, 2, 3, 4, 5, 6, 6] 
        b = [1, 1, 1, 1, 2, 3, 4, 5, 6, 7, 8, 9]
        result = findUnionOfArrays(a: a, b: b)
        XCTAssertEqual(result, [1, 2, 3, 4, 5, 6])
    }
    
    // MARK: - Find the Factorial of a Given N
    func testFindFactorial() {
        var n = 5
        var result = findFactorial(of: n)
        XCTAssertEqual(result, 120)
        
        n = 4
        result = findFactorial(of: n)
        XCTAssertEqual(result, 24)
        
        n = 2
        result = findFactorial(of: n)
        XCTAssertEqual(result, 2)
        
        n = 1
        result = findFactorial(of: n)
        XCTAssertEqual(result, 1)
        
        n = 0
        result = findFactorial(of: n)
        XCTAssertEqual(result, 1)
    }
    
    // MARK: - Find the Maximum Index
    func testFindMaximumIndex() {
        var a = [1, 10]
        var result = findMaximumIndex(in: a)
        XCTAssertEqual(result, 1)
        
        a = [34, 8, 10, 3, 2, 80, 30, 33, 1]
        result = findMaximumIndex(in: a)
        XCTAssertEqual(result, 6)
    }
}

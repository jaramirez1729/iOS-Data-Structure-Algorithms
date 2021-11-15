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
    
    // MARK: - Two Numbers That Sum to a Given Value
    func testFindNumbersThatSum() {
        var list = [4, 3, 32, 1, 5, 1, 5, 8, 15, 0]
        var result = findNumbersThatSum(to: 18, from: list)
        XCTAssertEqual(result, [3, 15])
        
        result = findNumbersThatSum(to: 8, from: list)
        XCTAssertEqual(result, [3, 5])
        
        list = [ 5, -8, 10]
        result = findNumbersThatSum(to: -3, from: list)
        XCTAssertEqual(result, [5, -8])
        
        list = [-5, -8, -20, -30, -50, -10]
        result = findNumbersThatSum(to: -18, from: list)
        XCTAssertEqual(result, [-8, -10])
        
        list = [9, 9]
        result = findNumbersThatSum(to: 10, from: list)
        XCTAssertEqual(result, [])
        
        list = [3, 5, 9, 10, 20, 9]
        result = findNumbersThatSum(to: 18, from: list)
        XCTAssertEqual(result, [9, 9])
    }
    
    // MARK: - Implement the Binary Search Algorithm
    func testBinarySearch() {
        let list = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        var result = binarySearch(val: 4, on: list)
        XCTAssertEqual(result, 3)
        
        result = binarySearch(val: 6, on: list)
        XCTAssertEqual(result, 5)
        
        let result = binarySearch(val: 9, on: list)
        XCTAssertEqual(result, 8)
        
        result = binarySearch(val: 12, on: list)
        XCTAssertEqual(result, -1)
        
        result = binarySearch(val: 1, on: list)
        XCTAssertEqual(result, 0)
        
        result = binarySearch(val: 10, on: list)
        XCTAssertEqual(result, 9)
        
        result = binarySearch(val: 4, on: [5])
        XCTAssertEqual(result, -1)
        
        result = binarySearch(val: 4, on: [])
        XCTAssertEqual(result, -1)
    }
}

//
//  DynamicTests.swift
//  DynamicTests
//
//  Created by J.A. Ramirez on 12/28/21.
//

import XCTest
@testable import Dynamic

// MARK: - Triple Steps
class TripleStepTests: XCTestCase {
    func test1() {
        let result = tripleSteps(5)
        XCTAssertEqual(result, 13)
    }
    
    func test2() {
        let result = tripleSteps(2)
        XCTAssertEqual(result, 2)
    }
    
    func test3() {
        let result = tripleSteps(3)
        XCTAssertEqual(result, 4)
    }
}

// MARK: - Robot in a Grid
class MoveRobotInGridTests: XCTestCase {
    func test1() {
        var grid = [["  ", "  ", "❌", "  "], 
                    ["  ", "  ", "  ", "❌"], 
                    ["  ", "  ", "❌", "  "], 
                    ["❌", "  ", "  ", "  "]]
        moveRobotInGrid(&grid, pos: (0, 0))
    }
    
    func test2() {
        var grid = [["  ", "  ", "  ", "  "], 
                    ["  ", "  ", "  ", "  "], 
                    ["  ", "  ", "  ", "  "], 
                    ["  ", "  ", "  ", "  "]]
        moveRobotInGrid(&grid, pos: (0, 0))
    }
    
    func test3() {
        var grid = [["  ", "  ", "  ", "❌"], 
                    ["  ", "  ", "❌", "  "], 
                    ["  ", "❌", "  ", "  "], 
                    ["  ", "  ", "  ", "  "]]
        moveRobotInGrid(&grid, pos: (0, 0))
    }
    
    func test4() {
        var grid = [["  ", "❌", "  ", "  "], 
                    ["  ", "  ", "  ", "  "], 
                    ["  ", "❌", "❌", "❌"], 
                    ["  ", "  ", "  ", "❌"],
                    ["  ", "  ", "❌", "  "],
                    ["❌", "  ", "  ", "  "]]
        moveRobotInGrid(&grid, pos: (0, 0))
    }
    
    func test5() {
        var grid = [["  ", "  ", "  ", "  "], 
                    ["  ", "❌", "  ", "  "], 
                    ["  ", "❌", "  ", "❌"], 
                    ["❌", "  ", "  ", "❌"],
                    ["  ", "❌", "  ", "  "],
                    ["❌", "  ", "  ", "  "]]
        moveRobotInGrid(&grid, pos: (0, 0))
    }
    
    func test6() {
        var grid = [["  ", "  ", "  ", "  "], 
                    ["  ", "❌", "  ", "  "], 
                    ["  ", "❌", "  ", "❌"], 
                    ["  ", "❌", "❌", "❌"],
                    ["  ", "  ", "  ", "  "],
                    ["❌", "  ", "  ", "  "]]
        moveRobotInGrid(&grid, pos: (0, 0))
    }
    
    func test7() {
        var grid = [["  ", "  ", "  ", "  ", "  "], 
                    ["  ", "❌", "  ", "  ", "  "], 
                    ["  ", "❌", "  ", "  ", "  "], 
                    ["  ", "❌", "  ", "  ", "  "],
                    ["  ", "❌", "❌", "❌", "❌"],
                    ["  ", "  ", "  ", "  ", "  "]]
        moveRobotInGrid(&grid, pos: (0, 0))
    }
}

// MARK: - Magic Index
class FindMagicIndexTests: XCTestCase {
    func test1() {
        let list = [-10, -5, 0, 3, 5, 6, 70, 80, 90, 100]
        let result = findMagicIndex(in: list)
        XCTAssertEqual(result, 3)
    }
    
    func test2() {
        let list = [-10, -5, -2, -1, 0, 3, 5, 7, 90, 100]
        let result = findMagicIndex(in: list)
        XCTAssertEqual(result, 7)
    }
    
    func test3() {
        let list = [-20, -19, -18, -17, -16, -15, -14, -13, -12,
                     -11, -10, -9, -8, -7, -6, -5, -4, -3, -2, -1]
        let result = findMagicIndex(in: list)
        XCTAssertEqual(result, -1)
    }
    
    func test4() {
        let list = [-20, -19, -18, 3, 20, 21, 22, 23, 24,
                     25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35]
        let result = findMagicIndex(in: list)
        XCTAssertEqual(result, 3)
    }
    
    func test5() {
        let list = [-5, -4, -3, -2, -1, 5]
        let result = findMagicIndex(in: list)
        XCTAssertEqual(result, 5)
    }
    
    func test6() {
        let list = [-5, -4, 2, 5, 6, 9]
        let result = findMagicIndex(in: list)
        XCTAssertEqual(result, 2)
    }
    
    func test7() {
        let list = [-20, -19, -18, -17, -16, -15, -14, -13, -12,
                     -11, -10, -9, -8, -7, -6, -5, 16, 19, 20, 23]
        let result = findMagicIndex(in: list)
        XCTAssertEqual(result, 16)
    }
    
    func test8() {
        let result = findMagicIndex(in: [])
        XCTAssertEqual(result, -1)
    }
    
    func test9() {
        let list = [20]
        let result = findMagicIndex(in: list)
        XCTAssertEqual(result, -1)
    }
}

// MARK: - Recursive Multiply
class MultiplyTests: XCTestCase {
    func test1() {
        let result = multiply(2, by: 6)
        XCTAssertEqual(result, 12)
    }
    
    func test2() {
        let result = multiply(5, by: 10)
        XCTAssertEqual(result, 50)
    }
}

//
//  3-TwoPointersPatternTests.swift
//  GrokkingTheCodingInterviewTests
//
//  Created by J.A. Ramirez on 2/14/22.
//

import XCTest
@testable import GrokkingTheCodingInterview

// MARK: - Pair with Target Sum (Easy)
class PairWithTargetSumTests: XCTestCase {
    func test1() {
        let list = [1, 2, 3, 4, 6]
        let sum = 6
        let result = [1, 3]
        XCTAssertEqual(pairWithTargetSum(sum, in: list), result)
    }
    
    func test2() {
        let list = [2, 5, 9, 11]
        let sum = 11
        let result = [0, 2]
        XCTAssertEqual(pairWithTargetSum(sum, in: list), result)
    }
    
    func test3() {
        let list = [2, 5, 9, 11]
        let sum = 55
        let result = [-1, -1]
        XCTAssertEqual(pairWithTargetSum(sum, in: list), result)
    }
    
    func test4() {
        let list = [2]
        let sum = 2
        let result = [-1, -1]
        XCTAssertEqual(pairWithTargetSum(sum, in: list), result)
    }
    
    func test5() {
        let list = [Int]()
        let sum = 1
        let result = [-1, -1]
        XCTAssertEqual(pairWithTargetSum(sum, in: list), result)
    }
}

// MARK: - Remove Duplicates (Easy)
class RemoveDuplicatesTests: XCTestCase {
    func test1() {
        var list = [2, 3, 3, 3, 6, 9, 9]
        let result = 4
        XCTAssertEqual(removeDuplicates(in: &list), result)
    }
    
    func test2() {
        var list = [2, 2, 2, 11]
        let result = 2
        XCTAssertEqual(removeDuplicates(in: &list), result)
    }
    
    func test3() {
        var list = [11]
        let result = 1
        XCTAssertEqual(removeDuplicates(in: &list), result)
    }
    
    func test4() {
        var list = [Int]()
        let result = 0
        XCTAssertEqual(removeDuplicates(in: &list), result)
    }
    
    // MARK: Remove Key Duplicates (Easy)
    func testA() {
        var list = [3, 2, 3, 6, 3, 10, 9, 3]
        let key = 3
        XCTAssertEqual(removeDuplicates(in: &list, of: key), 4)
    }
    
    func testB() {
        var list = [2, 11, 2, 2, 1]
        let key = 2
        XCTAssertEqual(removeDuplicates(in: &list, of: key), 2)
    }
}

// MARK: - Squaring a Sorted Array (Easy)
class MakeSortedSquaresTests: XCTestCase {
    func test1() {
        let list = [-2, -1, 0, 2, 3]
        let result = [0, 1, 4, 4, 9]
        XCTAssertEqual(makeSortedSquares(from: list), result)
    }
    
    func test2() {
        let list = [-3, -1, 0, 1, 2]
        let result = [0, 1, 1, 4, 9]
        XCTAssertEqual(makeSortedSquares(from: list), result)
    }
    
    func test3() {
        let list = [Int]()
        let result = [Int]()
        XCTAssertEqual(makeSortedSquares(from: list), result)
    }
    
    func test4() {
        let list = [-5, 5]
        let result = [25, 25]
        XCTAssertEqual(makeSortedSquares(from: list), result)
    }
    
    func test5() {
        let list = [10]
        let result = [100]
        XCTAssertEqual(makeSortedSquares(from: list), result)
    }
}

// MARK: - // MARK: - Triplet Sum Close to Target (Medium)
class TripletsWithZeroSumTests: XCTestCase {
    func test1() {
        let input = [-3, 0, 1, 2, -1, 1, -2]
        let output = [[-3, 1, 2], [-2, 0, 2], [-2, 1, 1], [-1, 0, 1]]
        XCTAssertEqual(tripletsWithZeroSum(in: input), output)
    }
    
    func test2() {
        let input = [-5, 2, -1, -2, 3]
        let output = [[-5, 2, 3], [-2, -1, 3]]
        XCTAssertEqual(tripletsWithZeroSum(in: input), output)
    }
}

// MARK: - Triplet Sum Close to Target (Medium)
class TripletSumCloseToTargetTests: XCTestCase {
    func test1() {
        let input = [-2, 0, 1, 2]
        let targetSum = 2
        let output = 1
        XCTAssertEqual(tripletSumCloseToTarget(in: input, targetSum: targetSum), output)
    }
    
    func test2() {
        let input = [-3, -1, 1, 2]
        let targetSum = 1
        let output = 0
        XCTAssertEqual(tripletSumCloseToTarget(in: input, targetSum: targetSum), output)
    }
    
    func test3() {
        let input = [1, 0, 1, 1]
        let targetSum = 100
        let output = 3
        XCTAssertEqual(tripletSumCloseToTarget(in: input, targetSum: targetSum), output)
    }
    
    func test4() {
        let input = [Int]()
        let targetSum = 1
        let output = Int.max
        XCTAssertEqual(tripletSumCloseToTarget(in: input, targetSum: targetSum), output)
    }
    
    func test5() {
        let input = [20, 10]
        let targetSum = 50
        let output = Int.max
        XCTAssertEqual(tripletSumCloseToTarget(in: input, targetSum: targetSum), output)
    }
    
    func test6() {
        let input = [20, 10, 5]
        let targetSum = 50
        let output = 35
        XCTAssertEqual(tripletSumCloseToTarget(in: input, targetSum: targetSum), output)
    }
}

// MARK: - Triplets with Smaller Sum (Medium)
class TripletWithSmallerSumTests: XCTestCase {
    func test1() {
        let input = [-1, 0, 2, 3]
        let target = 3
        let output = 2
        XCTAssertEqual(tripletWithSmallerSum(in: input, targetSum: target), output)
    }
    
    func test2() {
        let input = [-1, 4, 2, 1, 3]
        let target = 5
        let output = 4
        XCTAssertEqual(tripletWithSmallerSum(in: input, targetSum: target), output)
    }
    
    func testA() {
        let input = [-1, 0, 2, 3]
        let target = 3
        let output = [[-1, 0, 3], [-1, 0, 2]]
        XCTAssertEqual(tripletsWithSmallerSum(in: input, targetSum: target), output)
    }
    
    func testB() {
        let input = [-1, 4, 2, 1, 3]
        let target = 5
        let output = [[-1, 1, 4], [-1, 1, 3], [-1, 1, 2], [-1, 2, 3]]
        XCTAssertEqual(tripletsWithSmallerSum(in: input, targetSum: target), output)
    }
}

// MARK: - Subarrays with Product Less than a Target (Medium)
class FindSubarraysLessThanTargetTests: XCTestCase {
    func test1() {
        let input = [2, 5, 3, 10]
        let target = 30
        let output = [[2], [5], [2, 5], [3], [5, 3], [10]]
        XCTAssertEqual(findSubarraysLessThanTarget(target: target, in: input), output)
    }
    
    func test2() {
        let input = [8, 2, 6, 5]
        let target = 50
        let output = [[8], [2], [8, 2], [6], [2, 6], [5], [6, 5]]
        XCTAssertEqual(findSubarraysLessThanTarget(target: target, in: input), output)
    }
    
    func test3() {
        let input = [2, 3, 4]
        let target = 10
        let output = [[2], [3], [2, 3], [4]]
        XCTAssertEqual(findSubarraysLessThanTarget(target: target, in: input), output)
    }
    
    func test4() {
        let input = [5]
        let target = 2
        let output = [[Int]]()
        XCTAssertEqual(findSubarraysLessThanTarget(target: target, in: input), output)
    }
}

// MARK: - Dutch National Flag Problem (Medium)
class DutchFlagSortTests: XCTestCase {
    func test1() {
        var input = [1, 0, 2, 1, 0]
        let output = [0, 0, 1, 1, 2]
        dutchFlagSort(&input)
        XCTAssertEqual(input, output)
    }
    
    func test2() {
        var input = [2, 2, 0, 1, 2, 0]
        let output = [0, 0, 1, 2, 2, 2]
        dutchFlagSort(&input)
        XCTAssertEqual(input, output)
    }
}

// MARK: - Problem Challenge 1: Quadruple Sum to Target (Medium)
class QuadrupletsEqualToSumTests: XCTestCase {
    func test1() {
        let input = [4, 1, 2, -1, 1, -3]
        let target = 1
        let output = [[-3, -1, 1, 4], [-3, 1, 1, 2]]
        XCTAssertEqual(quadrupletsEqualToSum(sum: target, in: input), output)
    }
    
    func test2() {
        let input = [2, 0, -1, 1, -2, 2]
        let target = 2
        let output = [[-2, 0, 2, 2], [-1, 0, 1, 2]]
        XCTAssertEqual(quadrupletsEqualToSum(sum: target, in: input), output)
    }
    
    func test3() {
        let input = [2, 0, -1]
        let target = 2
        let output = [[Int]]()
        XCTAssertEqual(quadrupletsEqualToSum(sum: target, in: input), output)
    }
    
    func test4() {
        let input = [1, 2, 3, 4]
        let target = 11
        let output = [[Int]]()
        XCTAssertEqual(quadrupletsEqualToSum(sum: target, in: input), output)
    }
    
    func test5() {
        let input = [1, 4]
        let target = 5
        let output = [[Int]]()
        XCTAssertEqual(quadrupletsEqualToSum(sum: target, in: input), output)
    }
}

// MARK: - Problem Challenge 2: Comparing Strings containing Backspaces (Medium)
class BackspaceCompareTests: XCTestCase {
    func test1() {
        let str1 = "xy#z"
        let str2 = "xzz#"
        XCTAssertTrue(backspaceCompare(firstStr: str1, with: str2))
    }
    
    func test2() {
        let str1 = "xy#z"
        let str2 = "xyz#"
        XCTAssertFalse(backspaceCompare(firstStr: str1, with: str2))
    }
    
    func test3() {
        let str1 = "xp#"
        let str2 = "xyz##"
        XCTAssertTrue(backspaceCompare(firstStr: str1, with: str2))
    }
    
    func test4() {
        let str1 = "xywrrmp"
        let str2 = "xywrrmu#p"
        XCTAssertTrue(backspaceCompare(firstStr: str1, with: str2))
    }
}

// MARK: - Problem Challenge 3: Minimum Window Sort (Medium)
class ShortestWindowSortTests: XCTestCase {
    func test1() {
        let input = [1, 2, 5, 3, 7, 10, 9, 12]
        let output = 5
        XCTAssertEqual(ShortestWindowSort(for: input), output)
    }
    
    func test2() {
        let input = [1, 3, 2, 0, -1, 7, 10]
        let output = 5
        XCTAssertEqual(ShortestWindowSort(for: input), output)
    }
    
    func test3() {
        let input = [1, 2, 3]
        let output = 0
        XCTAssertEqual(ShortestWindowSort(for: input), output)
    }
    
    func test4() {
        let input = [3, 2, 1]
        let output = 3
        XCTAssertEqual(ShortestWindowSort(for: input), output)
    }
}

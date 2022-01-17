//
//  LeetCodeTests.swift
//  ArrayAlgorithmsTests
//
//  Created by J.A. Ramirez on 11/18/21.
//

import XCTest
@testable import ArrayAlgorithms

// MARK: - Remove Duplicates from Sorted Array
class LeetCodeRemoveDuplicatesTests: XCTestCase {
    func testRemoveDuplicates() {
        var nums = [0,0,1,1,1,2,2,3,3,4]
        let k = removeDuplicates(&nums)
        XCTAssertEqual(k, 5)
    }
    
    func testRemoveDuplicates2() {
        var nums = [1, 1, 2]
        let k = removeDuplicates(&nums)
        XCTAssertEqual(k, 2)
    }
    
    func testRemoveDuplicates3() {
        var nums = [1, 1]
        let k = removeDuplicates(&nums)
        XCTAssertEqual(k, 1)
    }
    
    func testRemoveDuplicates4() {
        var nums = [2]
        let k = removeDuplicates(&nums)
        XCTAssertEqual(k, 1)
    }
    
    func testRemoveDuplicates5() {
        var nums = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        let k = removeDuplicates(&nums)
        XCTAssertEqual(k, 10)
    }
}

// MARK: - Best Time to Buy and Sell Stock II
class LeetCodeMaxProfitTests: XCTestCase {    
    func testMaxProfit() {
        let prices = [7,1,5,3,6,4]
        let profit = maxProfit(prices)
        XCTAssertEqual(profit, 7)
    }
    
    func testMaxProfit2() {
        let prices = [1,2,3,4,5]
        let profit = maxProfit(prices)
        XCTAssertEqual(profit, 4)
    }
    
    func testMaxProfit3() {
        let prices = [1, 4, 4, 4, 5]
        let profit = maxProfit(prices)
        XCTAssertEqual(profit, 4)
    }
    
    func testMaxProfit4() {
        let prices =  [7,6,4,3,1]
        let profit = maxProfit(prices)
        XCTAssertEqual(profit, 0)
    }
}

// MARK: - Rotate Array
class LeetCodeRotateTests: XCTestCase {
    func testRotate() {
        var nums = [1,2,3,4,5,6,7]
        rotate(&nums, 3)
        XCTAssertEqual(nums, [5,6,7,1,2,3,4])
    }
    
    func testRotate2() {
        var nums = [1, 7]
        rotate(&nums, 3)
        XCTAssertEqual(nums, [7, 1])
    }
    
    func testRotate3() {
        var nums = [1, 7]
        rotate(&nums, 2)
        XCTAssertEqual(nums, [1, 7])
    }
    
    func testRotate4() {
        var nums = [-1, -100, 3, 99]
        rotate(&nums, 2)
        XCTAssertEqual(nums, [3,99, -1, -100])
    }
    
    func testRotate5() {
        var nums = [99]
        rotate(&nums, 0)
        XCTAssertEqual(nums, [99])
    }
    
    func testRotate6() {
        var nums = [99, -1]
        rotate(&nums, 1)
        XCTAssertEqual(nums, [-1, 99])
    }
}

// MARK: - Contains Duplicate
class LeetCodeContainsDuplicateTests: XCTestCase {
    func testContainsDuplicate() {
        let nums = [1, 2, 3, 1]
        let result = containsDuplicate(nums)
        XCTAssertTrue(result)
    }
    
    func testContainsDuplicate2() {
        let nums = [1, 2, 3]
        let result = containsDuplicate(nums)
        XCTAssertFalse(result)
    }
    
    func testContainsDuplicate3() {
        let nums = [1, 1]
        let result = containsDuplicate(nums)
        XCTAssertTrue(result)
    }
}

// MARK: - Single Number
class LeetCodeSingleNumberTests: XCTestCase {
    
    func testSingleNumber() {
        let nums = [2, 2, 1, 3, 3]
        let number = singleNumber(nums)
        XCTAssertEqual(number, 1)
    }
    
    func testSingleNumber2() {
        let nums = [4,1,2,1,2]
        let number = singleNumber(nums)
        XCTAssertEqual(number, 4)
    }
    
    func testSingleNumber3() {
        let nums = [1]
        let number = singleNumber(nums)
        XCTAssertEqual(number, 1)
    }
    
    func testSingleNumber4() {
        let nums = [1, 0, 1]
        let number = singleNumber(nums)
        XCTAssertEqual(number, 0)
    }
}

// MARK: - Intersection of Two Arrays II
class LeetCodeIntersectTests: XCTestCase {
    func testIntersect() {
        let nums1 = [1,2,2,1]
        let nums2 = [2,2]
        let result = intersect(nums1, nums2)
        XCTAssertEqual(result, [2, 2])
    }
    
    func testIntersect2() {
        let nums1 = [4,9,5]
        let nums2 = [9,4,9,8,4]
        let result = intersect(nums1, nums2)
        XCTAssertTrue(result == [9, 4] || result == [4, 9])
    }
}

// MARK: - Plus One
class LeetCodePlusOneTests: XCTestCase {
    func testPlusOne() {
        let digits = [1, 2, 3]
        let result = plusOne(digits)
        XCTAssertEqual(result, [1, 2, 4])
    }
    
    func testPlusOne2() {
        let digits = [4,3,2,1]
        let result = plusOne(digits)
        XCTAssertEqual(result, [4, 3, 2, 2])
    }
    
    func testPlusOne3() {
        let digits = [0]
        let result = plusOne(digits)
        XCTAssertEqual(result, [1])
    }
    
    func testPlusOne4() {
        let digits = [9]
        let result = plusOne(digits)
        XCTAssertEqual(result, [1, 0])
    }
    
    func testPlusOne5() {
        let digits = [9, 9, 9]
        let result = plusOne(digits)
        XCTAssertEqual(result, [1, 0, 0, 0])
    }
    
    func testPlusOne6() {
        let digits = [1, 0, 0, 0, 0]
        let result = plusOne(digits)
        XCTAssertEqual(result, [1, 0, 0, 0, 1])
    }
}

// MARK: - Move Zeroes
class LeetCodeMoveZeroesTests: XCTestCase {
    
    func testMoveZeroes() {
        var nums = [0,1,0,3,12]
        moveZeroes(&nums)
        XCTAssertEqual(nums, [1, 3, 12, 0, 0])
    }
    
    func testMoveZeroes2() {
        var nums = [0]
        moveZeroes(&nums)
        XCTAssertEqual(nums, [0])
    }
    
    func testMoveZeroes3() {
        var nums = [0, 0, 0, 1]
        moveZeroes(&nums)
        XCTAssertEqual(nums, [1, 0, 0, 0])
    }
    
    func testMoveZeroes4() {
        var nums = [0, 0, 0]
        moveZeroes(&nums)
        XCTAssertEqual(nums, [0, 0, 0])
    }
    
    func testMoveZeroes5() {
        var nums = [1, 1, 1]
        moveZeroes(&nums)
        XCTAssertEqual(nums, [1, 1, 1])
    }
}

// MARK: - Two Sum
class LeetCodeTwoSum: XCTestCase {
    func testTwoSum() {
        let nums = [2,7,11,15]
        let target = 9
        let result = twoSum(nums, target)
        XCTAssertEqual(result, [0, 1])
    }
}

// MARK: - Valid Sudoku
class LeetCodeIsValidSudokuTests: XCTestCase {
    func testIsValidSudoku() {
        let board: [[Character]] = 
        [["5","3",".",".","7",".",".",".","."]
         ,["6",".",".","1","9","5",".",".","."]
         ,[".","9","8",".",".",".",".","6","."]
         ,["8",".",".",".","6",".",".",".","3"]
         ,["4",".",".","8",".","3",".",".","1"]
         ,["7",".",".",".","2",".",".",".","6"]
         ,[".","6",".",".",".",".","2","8","."]
         ,[".",".",".","4","1","9",".",".","5"]
         ,[".",".",".",".","8",".",".","7","9"]]
        
        let result = isValidSudoku(board)
        XCTAssertTrue(result)
    }
    
    func testIsValidSudoku2() {
        let board: [[Character]] = 
        [["8","3",".",".","7",".",".",".","."]
         ,["6",".",".","1","9","5",".",".","."]
         ,[".","9","8",".",".",".",".","6","."]
         ,["8",".",".",".","6",".",".",".","3"]
         ,["4",".",".","8",".","3",".",".","1"]
         ,["7",".",".",".","2",".",".",".","6"]
         ,[".","6",".",".",".",".","2","8","."]
         ,[".",".",".","4","1","9",".",".","5"]
         ,[".",".",".",".","8",".",".","7","9"]]
        
        let result = isValidSudoku(board)
        XCTAssertFalse(result)
    }
}

// MARK: - Rotate Image
class LeetCodeRotateImageTests: XCTestCase {
    func testRotate() {
        var matrix = [[1,2,3],[4,5,6],[7,8,9]]
        rotate(&matrix)
        XCTAssertEqual(matrix, [[7,4,1],[8,5,2],[9,6,3]])
    }
    
    func testRotate2() {
        var matrix = [[5,1,9,11],[2,4,8,10],[13,3,6,7],[15,14,12,16]]
        rotate(&matrix)
        XCTAssertEqual(matrix, [[15,13,2,5],[14,3,4,1],[12,6,8,9],[16,7,10,11]])
    }
}

// MARK: - Merge Sorted Arrays
class LeetCodeMergeTests: XCTestCase {
    func test1() {
        var nums1 = [1,2,3,0,0,0]
        let m = 3
        let nums2 = [2,5,6]
        let n = 3
        merge(&nums1, m, nums2, n)
        XCTAssertEqual(nums1, [1, 2, 2, 3, 5, 6])
    }
    
    func test2() {
        var nums1 = [1]
        let m = 1, nums2: [Int] = [], n = 0
        merge(&nums1, m, nums2, n)
        XCTAssertEqual(nums1, [1])
    }
    
    func test3() {
        var nums1 = [0]
        let m = 0, nums2 = [1], n = 1
        merge(&nums1, m, nums2, n)
        XCTAssertEqual(nums1, [1])
    }
    
    func test4() {
        var nums1 = [1, 0]
        let m = 1, nums2 = [2], n = 1
        merge(&nums1, m, nums2, n)
        XCTAssertEqual(nums1, [1, 2])
    }
}

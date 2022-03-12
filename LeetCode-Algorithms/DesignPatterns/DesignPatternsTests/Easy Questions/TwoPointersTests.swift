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
        var nums = [3, 2, 2, 3]
        let val = 3
        XCTAssertEqual(removeElement(&nums, val), 2)
        print(nums)
    }
    
    func test2() {
        var nums = [0, 1, 2, 2, 3, 0, 4, 2]
        let val = 2
        XCTAssertEqual(removeElement(&nums, val), 5)
        print(nums)
    }
}

// MARK: - Implement strStr() (Easy)
class StrStrTests: XCTestCase {
    func test1() {
        let haystack = "hello", needle = "ll"
        XCTAssertEqual(strStr(haystack, needle), 2)
    }
    
    func test2() {
        let haystack = "aaaaa", needle = "bba"
        XCTAssertEqual(strStr(haystack, needle), -1)
    }
    
    func test3() {
        let haystack = "aaaaa", needle = "bba"
        XCTAssertEqual(strStr(haystack, needle), -1)
    }
}

// MARK: - Merge Sorted Array (Easy)
class MergeTests: XCTestCase {
    func test1() {
        var nums1 = [1, 2, 3, 0, 0, 0] 
        let m = 3
        let nums2 = [2, 5, 6]
        let n = 3
        merge(&nums1, m, nums2, n)
        XCTAssertEqual(nums1, [1, 2, 2, 3, 5, 6])
    }
    
    func test2() {
        var nums1 = [0] 
        let m = 0
        let nums2 = [1]
        let n = 1
        merge(&nums1, m, nums2, n)
        XCTAssertEqual(nums1, [1])
    }
    
    func test3() {
        var nums1 = [1] 
        let m = 1
        let nums2 = [0]
        let n = 0
        merge(&nums1, m, nums2, n)
        XCTAssertEqual(nums1, [1])
    }
    
    func test4() {
        var nums1 = [1, 2, 3, 0, 0, 0, 0] 
        let m = 3
        let nums2 = [4, 5, 6, 6]
        let n = 4
        merge(&nums1, m, nums2, n)
        XCTAssertEqual(nums1, [1, 2, 3, 4, 5, 6, 6])
    }
    
    func test5() {
        var nums1 = [1, 0] 
        let m = 1
        let nums2 = [10]
        let n = 1
        merge(&nums1, m, nums2, n)
        XCTAssertEqual(nums1, [1, 10])
    }
    
    func test6() {
        var nums1 = [100, 0] 
        let m = 1
        let nums2 = [10]
        let n = 1
        merge(&nums1, m, nums2, n)
        XCTAssertEqual(nums1, [10, 100])
    }
}

// MARK: - Two Sum III - Data structure design (Easy)
class TwoSumTests: XCTestCase {
    func test1() {
        let twoSum = TwoSum()
        for i in [1, 3, 5, 4, 7] {
            twoSum.add(i)
        }
        XCTAssertTrue(twoSum.find(4))
        XCTAssertTrue(twoSum.find(8))
        XCTAssertFalse(twoSum.find(20))
        XCTAssertFalse(twoSum.find(2))
    }
}

// MARK: - Strobogrammatic Number (Easy)
class IsStrobogrammaticTests: XCTestCase {
    func test1() {
        let num = "679"
        XCTAssertFalse(isStrobogrammatic(num))
    }
    
    func test2() {
        let num = "696969"
        XCTAssertTrue(isStrobogrammatic(num))
    }
    
    func test3() {
        let num = "18869881"
        XCTAssertTrue(isStrobogrammatic(num))
    }
    
    func test4() {
        let num = "18869881"
        XCTAssertTrue(isStrobogrammatic(num))
    }
    
    func test5() {
        XCTAssertTrue(isStrobogrammatic("1880881"))
    }
    
    func test6() {
        let num = "37"
        XCTAssertFalse(isStrobogrammatic(num))
    }
}

// MARK: - Intersection of Two Arrays (Easy)
class IsSubsequence: XCTestCase {
    func test1() {
        let s = "abc"
        let t = "ahbgdcgf"
        XCTAssertTrue(isSubsequence(s, t))
    } 
    
    func test2() {
        let s = "agf"
        let t = "ahbgdcgf"
        XCTAssertTrue(isSubsequence(s, t))
    }
    
    func test3() {
        let s = "acb"
        let t = "ahbgdcgf"
        XCTAssertFalse(isSubsequence(s, t))
    }
    
    func test4() {
        let s = "axc"
        let t = "ahbgdc"
        XCTAssertFalse(isSubsequence(s, t))
    }
    
    func test5() {
        let s = ""
        let t = "ahbgdc"
        XCTAssertTrue(isSubsequence(s, t))
    }
    
    func test6() {
        let s = "ahbgdc"
        let t = "ahbgdc"
        XCTAssertTrue(isSubsequence(s, t))
    }
    
    func test7() {
        let s = "abcabc"
        let t = "abcab"
        XCTAssertFalse(isSubsequence(s, t))
    }
}

// MARK: -  Intersection of Two Linked Lists (Easy)
class GetIntersectionNode: XCTestCase {
    func test1() {
        let nodeA1: ListNode? = ListNode(4)
        let nodeA2: ListNode? = ListNode(1)
        let nodeC1: ListNode? = ListNode(8)
        let nodeC2: ListNode? = ListNode(4)
        let nodeC3: ListNode? = ListNode(5)
        let nodeB1: ListNode? = ListNode(5)
        let nodeB2: ListNode? = ListNode(6)
        let nodeB3: ListNode? = ListNode(1)
        
        nodeA1?.next = nodeA2
        nodeA2?.next = nodeC1
        nodeC1?.next = nodeC2
        nodeC2?.next = nodeC3
        nodeB1?.next = nodeB2
        nodeB2?.next = nodeB3
        nodeB3?.next = nodeC1
        
        XCTAssertEqual(getIntersectionNode(nodeA1, nodeB1)?.val, 8)
    }
    
    func test2() {
        let nodeA1: ListNode? = ListNode(4)
        let nodeA2: ListNode? = ListNode(1)
        let nodeB1: ListNode? = ListNode(5)
        let nodeB2: ListNode? = ListNode(6)
        let nodeB3: ListNode? = ListNode(1)
        
        nodeA1?.next = nodeA2
        nodeB1?.next = nodeB2
        nodeB2?.next = nodeB3
        
        XCTAssertNil(getIntersectionNode(nodeA1, nodeB1)?.val)
    }
}

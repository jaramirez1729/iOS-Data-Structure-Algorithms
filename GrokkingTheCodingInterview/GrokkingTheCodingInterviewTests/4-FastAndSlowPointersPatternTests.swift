//
//  4-FastAndSlowPointersPatternTests.swift
//  GrokkingTheCodingInterviewTests
//
//  Created by J.A. Ramirez on 2/16/22.
//

import XCTest
@testable import GrokkingTheCodingInterview

// MARK: - LinkedList Cycle (Easy)
class HasCycleTests: XCTestCase {
    func test1() {
        let node6 = LinkedList<Int>(6)
        let node5 = LinkedList<Int>(5, next: node6)
        let node4 = LinkedList<Int>(4, next: node5)
        let node3 = LinkedList<Int>(3, next: node4)
        let node2 = LinkedList<Int>(2, next: node3)
        let head = LinkedList<Int>(1, next: node2)
        XCTAssertFalse(hasCycle(head))
    }
    
    func test2() {
        let node3 = LinkedList<Int>(3)
        let node6 = LinkedList<Int>(6, next: node3)
        let node5 = LinkedList<Int>(5, next: node6)
        let node4 = LinkedList<Int>(4, next: node5)
        node3.next = node4
        let node2 = LinkedList<Int>(2, next: node3)
        let head = LinkedList<Int>(1, next: node2)
        XCTAssertTrue(hasCycle(head))
    }
    
    func test3() {
        let head = LinkedList<Int>(1)
        XCTAssertFalse(hasCycle(head))
    }
    
    func test4() {
        let head = LinkedList<Int>(1)
        let node2 = LinkedList<Int>(2)
        head.next = node2
        node2.next = head
        XCTAssertTrue(hasCycle(head))
    }
    
    func testA() {
        let node3 = LinkedList<Int>(3)
        let node6 = LinkedList<Int>(6, next: node3)
        let node5 = LinkedList<Int>(5, next: node6)
        let node4 = LinkedList<Int>(4, next: node5)
        node3.next = node4
        let node2 = LinkedList<Int>(2, next: node3)
        let head = LinkedList<Int>(1, next: node2)
        XCTAssertEqual(getCycleLenght(head), 4)
    }
    
    func testB() {
        let head = LinkedList<Int>(1)
        let node2 = LinkedList<Int>(2)
        head.next = node2
        node2.next = head
        XCTAssertEqual(getCycleLenght(head), 2)
    }
}

// MARK: - Middle of the LinkedList (Easy)
class GetMiddleNodeTests: XCTestCase {
    func test1() {
        let node5 = LinkedList<Int>(5)
        let node4 = LinkedList<Int>(4, next: node5)
        let node3 = LinkedList<Int>(3, next: node4)
        let node2 = LinkedList<Int>(2, next: node3)
        let head = LinkedList<Int>(1, next: node2)
        XCTAssertEqual(getMiddleNode(in: head)?.value, node3.value)
    }
    
    func test2() {
        let node6 = LinkedList<Int>(6)
        let node5 = LinkedList<Int>(5, next: node6)
        let node4 = LinkedList<Int>(4, next: node5)
        let node3 = LinkedList<Int>(3, next: node4)
        let node2 = LinkedList<Int>(2, next: node3)
        let head = LinkedList<Int>(1, next: node2)
        XCTAssertEqual(getMiddleNode(in: head)?.value, node4.value)
    }
    
    func test3() {
        let node3 = LinkedList<Int>(3)
        let node2 = LinkedList<Int>(2, next: node3)
        let head = LinkedList<Int>(1, next: node2)
        XCTAssertEqual(getMiddleNode(in: head)?.value, node2.value)
    }
    
    func test4() {
        let node4 = LinkedList<Int>(4)
        let node3 = LinkedList<Int>(3, next: node4)
        let node2 = LinkedList<Int>(2, next: node3)
        let head = LinkedList<Int>(1, next: node2)
        XCTAssertEqual(getMiddleNode(in: head)?.value, node3.value)
    }
    
    func test5() {
        let node7 = LinkedList<Int>(7)
        let node6 = LinkedList<Int>(6, next: node7)
        let node5 = LinkedList<Int>(5, next: node6)
        let node4 = LinkedList<Int>(4, next: node5)
        let node3 = LinkedList<Int>(3, next: node4)
        let node2 = LinkedList<Int>(2, next: node3)
        let head = LinkedList<Int>(1, next: node2)
        XCTAssertEqual(getMiddleNode(in: head)?.value, node4.value)
    }
    
    func test6() {
        let head = LinkedList<Int>(1)
        XCTAssertEqual(getMiddleNode(in: head)?.value, head.value)
    }
    
    func test7() {
        let node2 = LinkedList<Int>(2)
        let head = LinkedList<Int>(1, next: node2)
        XCTAssertEqual(getMiddleNode(in: head)?.value, node2.value)
    }
}

// MARK: - Start of LinkedList Cycle (Medium)
class GetCycleStartNodeTests: XCTestCase {
    func test1() {
        let node3 = LinkedList<Int>(3)
        let node6 = LinkedList<Int>(6, next: node3)
        let node5 = LinkedList<Int>(5, next: node6)
        let node4 = LinkedList<Int>(4, next: node5)
        node3.next = node4
        let node2 = LinkedList<Int>(2, next: node3)
        let head = LinkedList<Int>(1, next: node2)
        XCTAssertEqual(getCycleStartNode(head)?.value, node3.value)
    }
    
    func test2() {
        let head = LinkedList<Int>(1)
        let node2 = LinkedList<Int>(2)
        head.next = node2
        node2.next = head
        XCTAssertEqual(getCycleStartNode(head)?.value, head.value)
    }
}

// MARK: - Happy Number (Medium)
class IsHappyNumberTests: XCTestCase {
    func test1() {
        XCTAssertTrue(isHappyNumber(23))
    }
    
    func test2() {
        XCTAssertFalse(isHappyNumber(12))
    }
}

// MARK: - Problem Challenge 1: Palindrome LinkedList (Medium)
class IsPalindromeTests: XCTestCase {
    func test1() {
        let node5 = LinkedList<Int>(2)
        let node4 = LinkedList<Int>(4, next: node5)
        let node3 = LinkedList<Int>(6, next: node4)
        let node2 = LinkedList<Int>(4, next: node3)
        let head: LinkedList<Int>? = LinkedList<Int>(2, next: node2)
        XCTAssertTrue(isPalindrome(head))
    }
    
    func test2() {
        let node6 = LinkedList<Int>(2)
        let node5 = LinkedList<Int>(2, next: node6)
        let node4 = LinkedList<Int>(4, next: node5)
        let node3 = LinkedList<Int>(6, next: node4)
        let node2 = LinkedList<Int>(4, next: node3)
        let head: LinkedList<Int>? = LinkedList<Int>(2, next: node2)
        XCTAssertFalse(isPalindrome(head))
    }
}

// MARK: - Problem Challenge 2: Rearrange a LinkedList (Medium)
class ReorderLinkedListTests: XCTestCase {
    func test1() {
        let node6 = LinkedList<Int>(12)
        let node5 = LinkedList<Int>(10, next: node6)
        let node4 = LinkedList<Int>(8, next: node5)
        let node3 = LinkedList<Int>(6, next: node4)
        let node2 = LinkedList<Int>(4, next: node3)
        var head: LinkedList<Int>? = LinkedList<Int>(2, next: node2)
        reorder(&head)
        XCTAssertEqual(head?.description, "2 -> 12 -> 4 -> 10 -> 6 -> 8 -> nil")
    }
    
    func test2() {
        let node5 = LinkedList<Int>(10)
        let node4 = LinkedList<Int>(8, next: node5)
        let node3 = LinkedList<Int>(6, next: node4)
        let node2 = LinkedList<Int>(4, next: node3)
        var head: LinkedList<Int>? = LinkedList<Int>(2, next: node2)
        reorder(&head)
        XCTAssertEqual(head?.description, "2 -> 10 -> 4 -> 8 -> 6 -> nil")
    }
    
    func test3() {
        let node2 = LinkedList<Int>(4)
        var head: LinkedList<Int>? = LinkedList<Int>(2, next: node2)
        reorder(&head)
        XCTAssertEqual(head?.description, "2 -> 4 -> nil")
    }
    
    func test4() {
        var head: LinkedList<Int>? = LinkedList<Int>(2)
        reorder(&head)
        XCTAssertEqual(head?.description, "2 -> nil")
    }
    
    func test5() {
        let node3 = LinkedList<Int>(6)
        let node2 = LinkedList<Int>(4, next: node3)
        var head: LinkedList<Int>? = LinkedList<Int>(2, next: node2)
        reorder(&head)
        XCTAssertEqual(head?.description, "2 -> 6 -> 4 -> nil")
    }
}

// Problem Challenge 3: Cycle in a Circular Array (Hard)
class DoesArrayHaveCycleTests: XCTestCase {
    func test1() {
        let input = [1, 2, -1, 2, 2]
        XCTAssertTrue(doesArrayHaveCycle(input))
    }
    
    func test2() {
        let input = [2, 2, -1, 2]
        XCTAssertTrue(doesArrayHaveCycle(input))
    }
    
    func test3() {
        let input = [2, 1, -1, -2]
        XCTAssertFalse(doesArrayHaveCycle(input))
    }
    
    func test4() {
        let input = [2, 1]
        XCTAssertFalse(doesArrayHaveCycle(input))
    }
    
    func test5() {
        let input = [1]
        XCTAssertFalse(doesArrayHaveCycle(input))
    }
    
    func test6() {
        let input = [-1, -1]
        XCTAssertTrue(doesArrayHaveCycle(input))
    }
}

// MARK: - // MARK: - Triplet Sum Close to Target (Medium)


// MARK: - Triplet Sum Close to Target (Medium)

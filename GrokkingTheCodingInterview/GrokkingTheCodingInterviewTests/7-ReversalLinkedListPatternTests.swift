//
//  7-ReversalLinkedListPatternTests.swift
//  GrokkingTheCodingInterviewTests
//
//  Created by J.A. Ramirez on 2/23/22.
//

import XCTest
@testable import GrokkingTheCodingInterview

// MARK: - Reverse a LinkedList (Easy)
class ReverseLinkedListTests: XCTestCase {
    func test1() {
        let node4 = LinkedList<Int>(4)
        let node3 = LinkedList<Int>(3, next: node4)
        let node2 = LinkedList<Int>(2, next: node3) 
        let head = LinkedList<Int>(1, next: node2)
        XCTAssertEqual(reverseLinkedList(head)?.description, "4 -> 3 -> 2 -> 1 -> nil")
    }
}

// MARK: - Reverse a Sub-list (Medium)
class ReverseSubListTests: XCTestCase {
    func test1() {
        // 1 -> 2 -> 3 -> 4 -> 5 -> nil
        let node5 = LinkedList<Int>(5)
        let node4 = LinkedList<Int>(4, next: node5)
        let node3 = LinkedList<Int>(3, next: node4)
        let node2 = LinkedList<Int>(2, next: node3) 
        var head: LinkedList<Int>? = LinkedList<Int>(1, next: node2)
        XCTAssertEqual(reverseSubList(&head, from: 2, to: 4)?.description, "1 -> 4 -> 3 -> 2 -> 5 -> nil")
    }
    
    func test2() {
        // 1 -> 2 -> 3 -> 4 -> 5 -> nil
        let node5 = LinkedList<Int>(5)
        let node4 = LinkedList<Int>(4, next: node5)
        let node3 = LinkedList<Int>(3, next: node4)
        let node2 = LinkedList<Int>(2, next: node3) 
        var head: LinkedList<Int>? = LinkedList<Int>(1, next: node2)
        XCTAssertEqual(reverseSubList(&head, from: 1, to: 2)?.description, "2 -> 1 -> 3 -> 4 -> 5 -> nil")
    }
    
    func test3() {
        // 1 -> 2 -> 3 -> 4 -> 5 -> nil
        let node5 = LinkedList<Int>(5)
        let node4 = LinkedList<Int>(4, next: node5)
        let node3 = LinkedList<Int>(3, next: node4)
        let node2 = LinkedList<Int>(2, next: node3) 
        var head: LinkedList<Int>? = LinkedList<Int>(1, next: node2)
        XCTAssertEqual(reverseSubList(&head, from: 1, to: 1)?.description, "1 -> 2 -> 3 -> 4 -> 5 -> nil")
    }
    
    func test4() {
        // 1 -> 2 -> 3 -> 4 -> 5 -> nil
        let node5 = LinkedList<Int>(5)
        let node4 = LinkedList<Int>(4, next: node5)
        let node3 = LinkedList<Int>(3, next: node4)
        let node2 = LinkedList<Int>(2, next: node3) 
        var head: LinkedList<Int>? = LinkedList<Int>(1, next: node2)
        XCTAssertEqual(reverseSubList(&head, from: 5, to: 5)?.description, "1 -> 2 -> 3 -> 4 -> 5 -> nil")
    }
}

// MARK: - Reverse every K-element Sub-list (Medium)
class ReverseKElementSubListTests: XCTestCase {
    func test1() {
        // 1 -> 2 -> 3 -> 4 -> 5 -> 6 -> 7 -> 8 -> nil
        let node8 = LinkedList<Int>(8)
        let node7 = LinkedList<Int>(7, next: node8)
        let node6 = LinkedList<Int>(6, next: node7)
        let node5 = LinkedList<Int>(5, next: node6)
        let node4 = LinkedList<Int>(4, next: node5)
        let node3 = LinkedList<Int>(3, next: node4)
        let node2 = LinkedList<Int>(2, next: node3) 
        var head: LinkedList<Int>? = LinkedList<Int>(1, next: node2)
        let expected = "3 -> 2 -> 1 -> 6 -> 5 -> 4 -> 8 -> 7 -> nil"
        XCTAssertEqual(reverseKElementSubList(&head, k: 3)?.description, expected)
    }
    
    func test2() {
        // 1 -> 2 -> 3 -> 4 -> 5 -> 6 -> 7 -> 8 -> nil
        let node8 = LinkedList<Int>(8)
        let node7 = LinkedList<Int>(7, next: node8)
        let node6 = LinkedList<Int>(6, next: node7)
        let node5 = LinkedList<Int>(5, next: node6)
        let node4 = LinkedList<Int>(4, next: node5)
        let node3 = LinkedList<Int>(3, next: node4)
        let node2 = LinkedList<Int>(2, next: node3) 
        var head: LinkedList<Int>? = LinkedList<Int>(1, next: node2)
        let expected = "2 -> 1 -> 4 -> 3 -> 6 -> 5 -> 8 -> 7 -> nil"
        XCTAssertEqual(reverseKElementSubList(&head, k: 2)?.description, expected)
    }
}

// MARK: - Problem Challenge #1: Reverse Alternating K-Element Sub-List (Medium)
class ReverseAlternatingKElementSubListTests: XCTestCase {
    func test1() {
        // 1 -> 2 -> 3 -> 4 -> 5 -> 6 -> 7 -> 8 -> nil
        let node8 = LinkedList<Int>(8)
        let node7 = LinkedList<Int>(7, next: node8)
        let node6 = LinkedList<Int>(6, next: node7)
        let node5 = LinkedList<Int>(5, next: node6)
        let node4 = LinkedList<Int>(4, next: node5)
        let node3 = LinkedList<Int>(3, next: node4)
        let node2 = LinkedList<Int>(2, next: node3) 
        var head: LinkedList<Int>? = LinkedList<Int>(1, next: node2)
        let expected = "2 -> 1 -> 3 -> 4 -> 6 -> 5 -> 7 -> 8 -> nil"
        XCTAssertEqual(reverseAlternatingKElementSubList(&head, k: 2)?.description, expected)
    }
}

// MARK: - Problem Challenge #2: Rotate a LinkedList (medium)
class RotateLinkedListTests: XCTestCase {
    func test1() {
        // 1 -> 2 -> 3 -> 4 -> 5 -> 6 -> nil
        let node6 = LinkedList<Int>(6)
        let node5 = LinkedList<Int>(5, next: node6)
        let node4 = LinkedList<Int>(4, next: node5)
        let node3 = LinkedList<Int>(3, next: node4)
        let node2 = LinkedList<Int>(2, next: node3) 
        var head: LinkedList<Int>? = LinkedList<Int>(1, next: node2)
        let expected = "4 -> 5 -> 6 -> 1 -> 2 -> 3 -> nil"
        XCTAssertEqual(rotateLinkedList(&head, by: 3)?.description, expected)
    }
    
    func test2() {
        // 1 -> 2 -> 3 -> 4 -> 5 -> 6 -> nil
        let node6 = LinkedList<Int>(6)
        let node5 = LinkedList<Int>(5, next: node6)
        let node4 = LinkedList<Int>(4, next: node5)
        let node3 = LinkedList<Int>(3, next: node4)
        let node2 = LinkedList<Int>(2, next: node3) 
        var head: LinkedList<Int>? = LinkedList<Int>(1, next: node2)
        let expected = "5 -> 6 -> 1 -> 2 -> 3 -> 4 -> nil"
        XCTAssertEqual(rotateLinkedList(&head, by: 2)?.description, expected)
    }
    
    func test3() {
        // 1 -> 2 -> 3 -> 4 -> 5 -> 6 -> nil
        let node6 = LinkedList<Int>(6)
        let node5 = LinkedList<Int>(5, next: node6)
        let node4 = LinkedList<Int>(4, next: node5)
        let node3 = LinkedList<Int>(3, next: node4)
        let node2 = LinkedList<Int>(2, next: node3) 
        var head: LinkedList<Int>? = LinkedList<Int>(1, next: node2)
        let expected = "6 -> 1 -> 2 -> 3 -> 4 -> 5 -> nil"
        XCTAssertEqual(rotateLinkedList(&head, by: 1)?.description, expected)
    }
    
    func test4() {
        // 1 -> 2 -> 3 -> nil
        // 1 -> 2 -> 3 ->; Valid rotations is 2 (5 % 3)
        // 1(Last) -> 2 -> 3 ->; Skip Lenght is 1
        // 2 -> 3 -> 1 -> nil
        let node3 = LinkedList<Int>(3)
        let node2 = LinkedList<Int>(2, next: node3) 
        var head: LinkedList<Int>? = LinkedList<Int>(1, next: node2)
        let expected = "2 -> 3 -> 1 -> nil"
        XCTAssertEqual(rotateLinkedList(&head, by: 5)?.description, expected)
    }
}

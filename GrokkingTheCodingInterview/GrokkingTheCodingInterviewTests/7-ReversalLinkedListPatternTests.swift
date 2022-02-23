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
        let node5 = LinkedList<Int>(5)
        let node4 = LinkedList<Int>(4, next: node5)
        let node3 = LinkedList<Int>(3, next: node4)
        let node2 = LinkedList<Int>(2, next: node3) 
        var head: LinkedList<Int>? = LinkedList<Int>(1, next: node2)
        XCTAssertEqual(reverseSubList(&head, from: 2, to: 4)?.description, "1 -> 4 -> 3 -> 2 -> 5 -> nil")
    }
}

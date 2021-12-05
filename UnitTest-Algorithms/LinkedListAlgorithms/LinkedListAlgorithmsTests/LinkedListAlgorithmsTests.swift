//
//  LinkedListAlgorithmsTests.swift
//  LinkedListAlgorithmsTests
//
//  Created by J.A. Ramirez on 11/21/21.
//

import XCTest
@testable import LinkedListAlgorithms

// MARK: -  Delete Node in a Linked List
class LeetCodeDeleteNodeTests: XCTestCase {
    func test1() {
        let node1 = ListNode(4)
        let node2 = ListNode(5)
        let node3 = ListNode(1)
        let node4 = ListNode(9)
        node1.next = node2
        node2.next = node3
        node3.next = node4
        deleteNode(node2)
        XCTAssertEqual(node1.description, "4 -> 1 -> 9")
    }
    
    func test2() {
        let node1 = ListNode(4)
        let node2 = ListNode(5)
        let node3 = ListNode(1)
        let node4 = ListNode(9)
        node1.next = node2
        node2.next = node3
        node3.next = node4
        deleteNode(node3)
        XCTAssertEqual(node1.description, "4 -> 5 -> 9")
    }
    
    func test3() {
        let node1 = ListNode(0)
        let node2 = ListNode(1)
        node1.next = node2
        deleteNode(node1)
        XCTAssertEqual(node1.description, "1")
    }
    
    func test4() {
        let node1 = ListNode(-3)
        let node2 = ListNode(5)
        let node3 = ListNode(-99)
        node1.next = node2
        node2.next = node3
        deleteNode(node1)
        XCTAssertEqual(node1.description, "5 -> -99")
    }
}

//  MARK: - Remove Nth Node From End of List
class LeetCodeRemoventhFromEndTests: XCTestCase {
    func test1() {
        let node1 = ListNode(1)
        let node2 = ListNode(2)
        let node3 = ListNode(3)
        let node4 = ListNode(4)
        let node5 = ListNode(5)
        node1.next = node2
        node2.next = node3
        node3.next = node4
        node4.next = node5
        let head = removeNthFromEnd(node1, 2)
        XCTAssertEqual(head?.description, "1 -> 2 -> 3 -> 5")
    }
    
    func test2() {
        let node1 = ListNode(1)
        let node2 = ListNode(2)
        let node3 = ListNode(3)
        let node4 = ListNode(4)
        let node5 = ListNode(5)
        node1.next = node2
        node2.next = node3
        node3.next = node4
        node4.next = node5
        let head = removeNthFromEnd(node1, 1)
        XCTAssertEqual(head?.description, "1 -> 2 -> 3 -> 4")
    }
    
    func test3() {
        let node1 = ListNode(1)
        let node2 = ListNode(2)
        node1.next = node2
        let head = removeNthFromEnd(node1, 2)
        XCTAssertEqual(head?.description, "2")
    }
    
    func test4() {
        let node1 = ListNode(1)
        let head = removeNthFromEnd(node1, 1)
        XCTAssertEqual(head?.description, nil)
    }

    func test5() {
        let node1 = ListNode(1)
        let node2 = ListNode(2)
        node1.next = node2
        let head = removeNthFromEnd(node1, 1)
        XCTAssertEqual(head?.description, "1")
    }
}

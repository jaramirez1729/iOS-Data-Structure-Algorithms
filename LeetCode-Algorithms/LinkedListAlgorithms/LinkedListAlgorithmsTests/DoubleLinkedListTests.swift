//
//  DoubleLinkedListTests.swift
//  DoubleLinkedListTests
//
//  Created by J.A. Ramirez on 12/13/21.
//

import XCTest
@testable import LinkedListAlgorithms

class DoubleLinkedListTests: XCTestCase {
    
    func testNodestPrintsCorrectly() {
        let head = DoubleListNode<Int>(1)
        let node2 = DoubleListNode<Int>(2)
        let node3 = DoubleListNode<Int>(3)
        let node4 = DoubleListNode<Int>(4)
        head.set(prev: nil, next: node2)
        node2.set(prev: head, next: node3)
        node3.set(prev: node2, next: node4)
        node4.set(prev: node3, next: nil)
        XCTAssertEqual(head.description, "1 <-> 2 <-> 3 <-> 4")
    }
    
    func testListPrintsCorrectly() {
        let list = DoubleLinkedList<Int>(2)
        list.append(4)
        list.append(6)
        list.append(8)
        list.append(10)
        XCTAssertEqual(list.description, "2 <-> 4 <-> 6 <-> 8 <-> 10")
        XCTAssertEqual(list.tail?.value, 10)
    }
    
    func testListArrayInitPrintsCorrectly() {
        let list = DoubleLinkedList<Int>([1, 2, 3, 4, 5])
        XCTAssertEqual(list.description, "1 <-> 2 <-> 3 <-> 4 <-> 5")
        XCTAssertEqual(list.tail?.value, 5)
    }
    
    func testListNewHeadReassigned() {
        let list = DoubleLinkedList<Int>([1, 2, 3, 4, 5])
        let newList = DoubleLinkedList<Int>([7, 7, 7, 7, 11])
        list.setNewHead(newList.head)
        XCTAssertEqual(list.description, "7 <-> 7 <-> 7 <-> 7 <-> 11")
        XCTAssertEqual(list.tail?.value, 11)
    }
}

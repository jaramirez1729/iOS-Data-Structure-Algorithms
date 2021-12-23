//
//  AlgorithmsTests.swift
//  LinkedListsTests
//
//  Created by J.A. Ramirez on 12/22/21.
//

import XCTest
@testable import LinkedLists

// MARK: - Remove Duplicates
class AlgorithmsTests: XCTestCase {
    
    func test1() {
        let list = SingleLinkedList<Int>()
        list.append(value: 1)
        list.append(value: 2)
        list.append(value: 3)
        list.append(value: 1)
        list.append(value: 5)
        list.append(value: 3)
        list.append(value: 2)
        removeDuplicates(from: list)
        XCTAssertEqual(list.description, "1 -> 2 -> 3 -> 5")
    }
    
    func test2() {
        let list = SingleLinkedList<Int>()
        list.append(value: 1)
        list.append(value: 2)
        list.append(value: 1)
        list.append(value: 10)
        removeDuplicates(from: list)
        XCTAssertEqual(list.description, "1 -> 2 -> 10")
    }
    
    func test3() {
        let list = SingleLinkedList<Int>()
        removeDuplicates(from: list)
        XCTAssertEqual(list.description, "")
    }
    
    func test4() {
        let list = SingleLinkedList<Int>()
        list.append(value: 1)
        list.append(value: 2)
        list.append(value: 3)
        removeDuplicates(from: list)
        XCTAssertEqual(list.description, "1 -> 2 -> 3")
    }
    
    func test5() {
        let list = SingleLinkedList<Int>()
        list.append(value: 1)
        list.append(value: 1)
        list.append(value: 1)
        list.append(value: 1)
        removeDuplicates(from: list)
        XCTAssertEqual(list.description, "1")
    }
}

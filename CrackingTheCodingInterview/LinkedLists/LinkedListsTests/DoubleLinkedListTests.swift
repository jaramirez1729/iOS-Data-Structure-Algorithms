//
//  DoubleLinkedListTests.swift
//  LinkedListsTests
//
//  Created by J.A. Ramirez on 12/22/21.
//

import XCTest
@testable import LinkedLists

class DoubleLinkedListTests: XCTestCase {
    
    func testDataStructure() {
        let list = DoubleLinkedList<Int>()
        list.append(value: 1)
        list.append(value: 2)
        list.append(value: 3)
        list.append(value: 4)
        XCTAssertEqual(list.description, "1 <-> 2 <-> 3 <-> 4")
    }
    
    func testBidirection() {
        let list = DoubleLinkedList<Int>()
        list.append(value: 1)
        list.append(value: 2)
        list.append(value: 3)
        list.append(value: 4)
        
        var tNode = list.tail
        var values: [Int] = []
        while tNode != nil {
            if let val = tNode?.value {
                values.append(val)
                tNode = tNode?.prev
            }
        }
        XCTAssertEqual(values, [4, 3, 2, 1])
    }
}

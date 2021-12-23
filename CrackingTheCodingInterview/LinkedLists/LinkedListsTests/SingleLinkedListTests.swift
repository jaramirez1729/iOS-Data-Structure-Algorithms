//
//  SingleLinkedListTests.swift
//  SingleLinkedListTests
//
//  Created by J.A. Ramirez on 12/22/21.
//

import XCTest
@testable import LinkedLists

class SingleLinkedListTests: XCTestCase {
    
    func testDataStructure() {
        let list = SingleLinkedList<Int>()
        list.append(value: 1)
        list.append(value: 2)
        list.append(value: 3)
        list.append(value: 4)
        XCTAssertEqual(list.description, "1 -> 2 -> 3 -> 4")
        XCTAssertEqual(list.head?.value, 1)
        XCTAssertEqual(list.tail?.value, 4)
    }
}

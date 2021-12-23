//
//  LRUCacheTests.swift
//  LinkedListAlgorithmsTests
//
//  Created by J.A. Ramirez on 12/13/21.
//

import XCTest
@testable import LinkedListAlgorithms

class LRUCacheTests: XCTestCase {
    
    // MARK: - Unit Tests
    func testNewValueMovesToTopOfList() {
        var cache = LRUCache<Int>(size: 3)
        cache.add(1)
        cache.add(2)
        cache.add(3)
        XCTAssertEqual(cache.description, "3 <-> 2 <-> 1")
    }
    
    func testNewValueRemovesLastWhenLimitReached() {
        var cache = LRUCache<Int>(size: 3)
        cache.add(1)
        cache.add(2)
        cache.add(3)
        cache.add(4)
        cache.add(5)
        XCTAssertEqual(cache.description, "5 <-> 4 <-> 3")
    }
    
    func testGetValueMovesNodeToTopOfList() {
        var cache = LRUCache<Int>(size: 4)
        cache.add(1)
        cache.add(2)
        cache.add(3)
        cache.add(4)
        XCTAssertEqual(cache.description, "4 <-> 3 <-> 2 <-> 1")
        XCTAssertEqual(cache.get(3), 3)
        XCTAssertEqual(cache.description, "3 <-> 4 <-> 2 <-> 1")
        XCTAssertEqual(cache.get(1), 1)
        XCTAssertEqual(cache.description, "1 <-> 3 <-> 4 <-> 2")
    }
    
    func testSizeMatchesCount() {
        var cache = LRUCache<Int>(size: 3)
        cache.add(1)
        cache.add(2)
        cache.add(3)
        cache.add(4)
        XCTAssertEqual(cache.count, 3)
    }
    
    func testRemoveAllClearsCache() {
        var cache = LRUCache<Int>(size: 5)
        cache.add(1)
        cache.add(2)
        cache.add(3)
        cache.add(4)
        cache.add(5)
        cache.removeAll()
        XCTAssertEqual(cache.dict.isEmpty, true)
        XCTAssertEqual(cache.count, 0)
        XCTAssertEqual(cache.list.description, "The list is empty.")
    }
    
    func testCacheWithDatabase() {
        var database = Database()
        XCTAssertEqual(database.getData(10), 11)
        XCTAssertEqual(database.getData(20), 21)
        XCTAssertEqual(database.getData(30), 31)
        XCTAssertEqual(database.getData(40), 41)
        XCTAssertEqual(database.getData(50), 51)
        XCTAssertEqual(database.getData(60), 61)
        XCTAssertEqual(database.getData(70), 71)
        XCTAssertEqual(database.cache.description, "71 <-> 61 <-> 51 <-> 41 <-> 31")
    }
    
    // MARK: - Test Doubles
    struct Database {
        private(set) var data: [Int] = Array(1...100)
        private(set) var cache = LRUCache<Int>(size: 5)
        
        init() {
            data = data.map { $0 + 1 }
        }
        
        mutating func getData(_ val: Int) -> Int {
            if let value = cache.dict[val] {
                return value?.value ?? -1
            } else {
                guard data.indices.contains(val - 1) else { return -1 }
                let item = data[val - 1]
                cache.add(item)
                return item
            }
        }
    }
}

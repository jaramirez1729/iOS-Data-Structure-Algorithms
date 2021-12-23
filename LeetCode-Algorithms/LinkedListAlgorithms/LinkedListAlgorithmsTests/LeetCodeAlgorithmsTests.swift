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
        let node1 = SingleListNode(4)
        let node2 = SingleListNode(5)
        let node3 = SingleListNode(1)
        let node4 = SingleListNode(9)
        node1.next = node2
        node2.next = node3
        node3.next = node4
        deleteNode(node2)
        XCTAssertEqual(node1.description, "4 -> 1 -> 9")
    }
    
    func test2() {
        let node1 = SingleListNode(4)
        let node2 = SingleListNode(5)
        let node3 = SingleListNode(1)
        let node4 = SingleListNode(9)
        node1.next = node2
        node2.next = node3
        node3.next = node4
        deleteNode(node3)
        XCTAssertEqual(node1.description, "4 -> 5 -> 9")
    }
    
    func test3() {
        let node1 = SingleListNode(0)
        let node2 = SingleListNode(1)
        node1.next = node2
        deleteNode(node1)
        XCTAssertEqual(node1.description, "1")
    }
    
    func test4() {
        let node1 = SingleListNode(-3)
        let node2 = SingleListNode(5)
        let node3 = SingleListNode(-99)
        node1.next = node2
        node2.next = node3
        deleteNode(node1)
        XCTAssertEqual(node1.description, "5 -> -99")
    }
}

//  MARK: - Remove Nth Node From End of List
class LeetCodeRemoveNthFromEndTests: XCTestCase {
    func test1() {
        let node1 = SingleListNode(1)
        let node2 = SingleListNode(2)
        let node3 = SingleListNode(3)
        let node4 = SingleListNode(4)
        let node5 = SingleListNode(5)
        node1.next = node2
        node2.next = node3
        node3.next = node4
        node4.next = node5
        let head = removeNthFromEnd(node1, 2)
        XCTAssertEqual(head?.description, "1 -> 2 -> 3 -> 5")
    }
    
    func test2() {
        let node1 = SingleListNode(1)
        let node2 = SingleListNode(2)
        let node3 = SingleListNode(3)
        let node4 = SingleListNode(4)
        let node5 = SingleListNode(5)
        node1.next = node2
        node2.next = node3
        node3.next = node4
        node4.next = node5
        let head = removeNthFromEnd(node1, 1)
        XCTAssertEqual(head?.description, "1 -> 2 -> 3 -> 4")
    }
    
    func test3() {
        let node1 = SingleListNode(1)
        let node2 = SingleListNode(2)
        node1.next = node2
        let head = removeNthFromEnd(node1, 2)
        XCTAssertEqual(head?.description, "2")
    }
    
    func test4() {
        let node1 = SingleListNode(1)
        let head = removeNthFromEnd(node1, 1)
        XCTAssertEqual(head?.description, nil)
    }

    func test5() {
        let node1 = SingleListNode(1)
        let node2 = SingleListNode(2)
        node1.next = node2
        let head = removeNthFromEnd(node1, 1)
        XCTAssertEqual(head?.description, "1")
    }
    
    func test6() {
        let node1 = SingleListNode(1)
        let node2 = SingleListNode(2)
        let node3 = SingleListNode(3)
        node1.next = node2
        node2.next  = node3
        let head = removeNthFromEnd(node1, 2)
        XCTAssertEqual(head?.description, "1 -> 3")
    }
}

// MARK: - Reverse Linked List
class LeetCodeReverseLinkedListTests: XCTestCase {
    func test1() {
        let node1 = SingleListNode(1)
        let node2 = SingleListNode(2)
        let node3 = SingleListNode(3)
        let node4 = SingleListNode(4)
        let node5 = SingleListNode(5)
        node1.next = node2
        node2.next = node3
        node3.next = node4
        node4.next = node5
        let head = reverseList(node1)
        XCTAssertEqual(head?.description, "5 -> 4 -> 3 -> 2 -> 1")
    }
    
    func test2() {
        let node1 = SingleListNode(1)
        let node2 = SingleListNode(2)
        let node3 = SingleListNode(3)
        node1.next = node2
        node2.next = node3
        let head = reverseList(node1)
        XCTAssertEqual(head?.description, "3 -> 2 -> 1")
    }
    
    func test3() {
        let node1 = SingleListNode(1)
        let node2 = SingleListNode(2)
        node1.next = node2
        let head = reverseList(node1)
        XCTAssertEqual(head?.description, "2 -> 1")
    }
    
    func test4() {
        let node1 = SingleListNode(1)
        let head = reverseList(node1)
        XCTAssertEqual(head?.description, "1")
    }
    
    func test5() {
        let head = reverseList(nil)
        XCTAssertEqual(head?.description, nil)
    }
}

// MARK: - Merge Two Sorted Lists
class LeetCodeMergeTwoListsTests: XCTestCase {
    func test1() {
        let list1 = SingleListNode(1, SingleListNode(2, SingleListNode(4)))
        let list2 = SingleListNode(1, SingleListNode(3, SingleListNode(4)))
        let sortedList = mergeTwoLists(list1, list2)
        XCTAssertEqual(sortedList?.description, "1 -> 1 -> 2 -> 3 -> 4 -> 4")
    }
    
    func test2() {
        let list1 = SingleListNode(1)
        let list2 = SingleListNode(1)
        let sortedList = mergeTwoLists(list1, list2)
        XCTAssertEqual(sortedList?.description, "1 -> 1")
    }
    
    func test3() {
        let list1 = SingleListNode(1, SingleListNode(2, SingleListNode(4)))
        let list2 = SingleListNode(1)
        let sortedList = mergeTwoLists(list1, list2)
        XCTAssertEqual(sortedList?.description, "1 -> 1 -> 2 -> 4")
    }
    
    func test4() {
        let list1 = SingleListNode(1)
        let list2 = SingleListNode(1, SingleListNode(2, SingleListNode(4)))
        let sortedList = mergeTwoLists(list1, list2)
        XCTAssertEqual(sortedList?.description, "1 -> 1 -> 2 -> 4")
    }
    
    func test5() {
        let sortedList = mergeTwoLists(nil, nil)
        XCTAssertEqual(sortedList?.description, nil)
    }
}

// MARK: - Palindrome Linked List
class LeetCodeIsPalindromeTests: XCTestCase {
    func test1() {
        let head = SingleListNode(1, SingleListNode(2, SingleListNode(2, SingleListNode(1))))
        let result = isPalindrome(head)
        XCTAssertTrue(result)
    }
    
    func test2() {
        let head = SingleListNode(1, SingleListNode(2, SingleListNode(2, SingleListNode(3))))
        let result = isPalindrome(head)
        XCTAssertFalse(result)
    }
    
    func test3() {
        let head = SingleListNode(1, SingleListNode(2))
        let result = isPalindrome(head)
        XCTAssertFalse(result)
    }
    
    func test4() {
        let head = SingleListNode(1, SingleListNode(1))
        let result = isPalindrome(head)
        XCTAssertTrue(result)
    }
    
    func test5() {
        let head = SingleListNode(1, SingleListNode(3, SingleListNode(3, SingleListNode(3, SingleListNode(1)))))
        let result = isPalindrome(head)
        XCTAssertTrue(result)
    }
    
    func test6() {
        let head = SingleListNode(1, SingleListNode(0, SingleListNode(0)))
        let result = isPalindrome(head)
        XCTAssertFalse(result)
    }
}

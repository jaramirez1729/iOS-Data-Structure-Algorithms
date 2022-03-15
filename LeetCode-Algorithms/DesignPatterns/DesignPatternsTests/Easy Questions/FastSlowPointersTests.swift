//
//  FastSlowPointersTests.swift
//  DesignPatternsTests
//
//  Created by J.A. Ramirez on 3/6/22.
//

import XCTest
@testable import DesignPatterns

// MARK: - Happy Number (Easy)
class IsHappyTests: XCTestCase {
    func test1() {
        let n = 19
        XCTAssertTrue(isHappy(n))
    }
    
    func test2() {
        let n = 2
        XCTAssertFalse(isHappy(n))
    }
    
    func test3() {
        let n = 100
        XCTAssertTrue(isHappy(n))
    }
}

// MARK: - Palindrome Linked list (Easy)
class IsPalindromeTests: XCTestCase {
    func test1() {
        let head = ListNode(1)
        head.next = ListNode(2)
        head.next?.next = ListNode(2)
        head.next?.next?.next = ListNode(1)
        XCTAssertTrue(isPalindrome(head))
    }
    
    func test2() {
        let head = ListNode(1)
        head.next = ListNode(2)
        head.next?.next = ListNode(3)
        head.next?.next?.next = ListNode(4)
        head.next?.next?.next?.next = ListNode(5)
        XCTAssertFalse(isPalindrome(head))
    }
    
    func test3() {
        let head = ListNode(1)
        head.next = ListNode(2)
        head.next?.next = ListNode(1)
        XCTAssertTrue(isPalindrome(head))
    }
    
    func test4() {
        let head = ListNode(5)
        head.next = ListNode(3)
        XCTAssertFalse(isPalindrome(head))
    }
    
    func test5() {
        let head = ListNode(1)
        head.next = ListNode(2)
        head.next?.next = ListNode(3)
        head.next?.next?.next = ListNode(1)
        XCTAssertFalse(isPalindrome(head))
    }
}

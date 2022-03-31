//
//  FastSlowPointersAlgorithms.swift
//  DesignPatterns
//
//  Created by J.A. Ramirez on 3/6/22.
//

import Foundation
import UIKit

/*
 These questions come from LeetCode that are filtered by the two pointers topic.
 These are specifically questions that use the slow and fast pointer approach, and not just 2 pointers.
 */

// MARK: - Happy Number (Easy)
/*
 Write an algorithm to determine if a number n is happy.

 A happy number is a number defined by the following process:

 Starting with any positive integer, replace the number by the sum of the squares of its digits.
 Repeat the process until the number equals 1 (where it will stay), or it loops endlessly in a cycle which does not include 1.
 Those numbers for which this process ends in 1 are happy.
 
 Return true if n is a happy number, and false if not.
 */
// We can use the slow & fast pointer approach. We will "happify" the number (slow), and then we will also have another pointer to "happify" the number twice (fast). If the slow and fast numbers eventually meet up, that means it's not a happy number and we can return false. if it's happy, we can return true after checking it's 1.
// Time O(log N), Space O(1)
func isHappy(_ n: Int) -> Bool {
    var slowCalculation = n
    var fastCalculation = n
    repeat {
        slowCalculation = sumDigitSquares(slowCalculation) // Slow "pointer"
        fastCalculation = sumDigitSquares(sumDigitSquares(fastCalculation)) // Fast "pointer"
        // Eventually they will meet up with each other if there is a cycle, so this repeat will end.
    } while slowCalculation != fastCalculation
    // The only cycle allowed is if both reached 1.
    return slowCalculation == 1
}

private func sumDigitSquares(_ n: Int) -> Int {
    var total = 0
    var num = n
    while num > 0 {
        let firstDigit = num % 10 // Get the first digit to square.
        total += firstDigit * firstDigit
        num = Int(floor(Double(num) / 10.0)) // Remove the first digit.
    }
    return total
}

// MARK: - Palindrome Linked list (Easy)
/*
 Given the head of a singly linked list, return true if it is a palindrome.
 
 Follow up: Could you do it in O(n) time and O(1) space?
 */
// To do it in O(n) time and O(1) space, we will need to manipulate the list itself. First, we need to get the middle node. Then, we need to reverse the rest of the list starting from the middle node. Then, we compare both halves if they match the values. Then, we reverse it back.
// Time O(N), Space O(1)
func isPalindrome(_ head: ListNode?) -> Bool {
    if head == nil || head?.next == nil { return true }
    var tHead = head
    
    var middleNode = getMiddleNode(tHead) // We'll reverse the list starting from here.
    var tHeadSecondHalf = reverseLinkedList(&middleNode) // Reverse the 2nd half of the list and get its head.
    var copyHeadSecondHalf = tHeadSecondHalf // To reverse the reversed list later.
    
    // Compare the first half by the second half. They will be the same size if they are valid palindromes.
    while tHead != nil && tHeadSecondHalf != nil {
        if tHead?.val != tHeadSecondHalf?.val { break }
        tHead = tHead?.next
        tHeadSecondHalf = tHeadSecondHalf?.next
    }
    
    // Since we directly changed the 2nd half, we need to reverse it again, and we don't care about it's head since it's technically the same as the middle node.
    _ = reverseLinkedList(&copyHeadSecondHalf)
    // If tHead is not nil, it's okay because it might contain an "extra" element in its list, which is the middleNode. So if it's not nil, we need to check if the 2nd half did finish comparing the rest of the list.
    if tHead == nil || tHeadSecondHalf == nil {
        return true
    }
    
    return false
}

private func getMiddleNode(_ head: ListNode?) -> ListNode? {
    var slowPointer = head
    var fastPointer = head
    while fastPointer != nil && fastPointer?.next != nil {
        slowPointer = slowPointer?.next
        fastPointer = fastPointer?.next?.next
    }
    return slowPointer
}

private func reverseLinkedList(_ head: inout ListNode?) -> ListNode? {
    var prev: ListNode? = nil
    while head != nil {
        let next = head?.next
        head?.next = prev
        prev = head
        head = next
    }
    return prev
}

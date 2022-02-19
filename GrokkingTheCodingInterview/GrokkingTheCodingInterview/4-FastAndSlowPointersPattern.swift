//
//  4-FastAndSlowPointersPattern.swift
//  GrokkingTheCodingInterview
//
//  Created by J.A. Ramirez on 2/16/22.
//

import Foundation
/*
 The Fast & Slow pointer approach, also known as the Hare & Tortoise algorithm, is a pointer algorithm that uses two pointers which move through the array (or sequence/LinkedList) at different speeds. This approach is quite useful when dealing with cyclic LinkedLists or arrays.
 */

// MARK: - LinkedList Cycle (Easy)
/*
 Given the head of a Singly LinkedList, write a function to determine if the LinkedList has a cycle in it or not.
 */
// Clyde's Cycle Finding Algorithm: A fast pointer moves 2 at a time, and the slow one moves 1 at a time. If there is no loop, the fast pointer will eventually reach the end, otherwise, it would have caught up with the slow pointer and show there is a cycle.
// Time O(N), Space O(1)
func hasCycle<T>(_ head: LinkedList<T>?) -> Bool {
    var slowPointer = head
    var fastPointer = head
    while fastPointer != nil && fastPointer?.next != nil {
        fastPointer = fastPointer?.next?.next
        slowPointer = slowPointer?.next
        if slowPointer === fastPointer {
            return true
        }
    }
    return false
}

/* Similar Problem #1:
 Given the head of a LinkedList with a cycle, find the length of the cycle.
 */
// Use Clyde's Cycle Finding algorithm. When the fast pointer has reached the slow pointer, start a new pointer from the position they met and start counting until it finds the slow pointer again.
// Time O(N), Space O(1)
func getCycleLenght<T>(_ head: LinkedList<T>?) -> Int {
    var slowPointer = head
    var fastPointer = head
    while fastPointer != nil && fastPointer?.next != nil {
        fastPointer = fastPointer?.next?.next
        slowPointer = slowPointer?.next
        if slowPointer === fastPointer {
            return calculateCycleLenght(slowPointer)
        }
    }
    return 0
}

private func calculateCycleLenght<T>(_ node: LinkedList<T>?) -> Int {
    var current = node
    var lenght = 0
    repeat {
        current = current?.next
        lenght += 1
    } while current !== node
    return lenght
}

// MARK: - Middle of the LinkedList (Easy)
/*
 Given the head of a Singly LinkedList, write a method to return the middle node of the LinkedList.

 If the total number of nodes in the LinkedList is even, return the second middle node.
 */
// Time O(N), Space O(1)
func getMiddleNode<T>(in head: LinkedList<T>?) -> LinkedList<T>? {
    var slowPointer = head
    var fastPointer = head
    while fastPointer != nil && fastPointer?.next != nil {
        slowPointer = slowPointer?.next
        fastPointer = fastPointer?.next?.next
    }
    return slowPointer
}

// MARK: - Start of LinkedList Cycle (Medium)
/*
 Given the head of a Singly LinkedList that contains a cycle, write a function to find the starting node of the cycle.
 */
// Move a second pointer N number of times forward where N is the length of the cycle. Then, move the first and second pointers by 1 and eventually they'll meet up at the starting cycle node.
// Time O(N), Space O(1)
func getCycleStartNode<T>(_ head: LinkedList<T>?) -> LinkedList<T>? {
    var length = getCycleLenght(head)
    var firstPointer = head
    var secondPointer = head
    // Move the second pointer 'length' number of times ahead first.
    while length != 0 {
        secondPointer = secondPointer?.next
        length -= 1
    }
    // Then move both pointers by 1 each time. Eventually, they will meet up at the start of the cycle node.
    while firstPointer !== secondPointer {
        firstPointer = firstPointer?.next
        secondPointer = secondPointer?.next
    }
    return firstPointer
}

// MARK: - Happy Number (Medium)
/*
 Any number will be called a happy number if, after repeatedly replacing it with a number equal to the sum of the square of all of its digits, leads us to number ‘1’. All other (not-happy) numbers will never reach ‘1’. Instead, they will be stuck in a cycle of numbers which does not include ‘1’.
 
 Write a function that determines if a number is happy or not.
 */
// Uses 2 number "pointers" to calculate the square sum. One will move faster than the other one. They will eventually meet up at the same calculation, which means the faster one has completed the entire cycle of calculation already. When we leave the loop, we want to know if the slow pointer is stuck on 1 since it will remain there forever. If it did, then it's a happy number.
// Time O(log N), Space O(1)
func isHappyNumber(_ num: Int) -> Bool {
    var slowCalculation = num
    var fastCalculation = num
    repeat {
        // Calculate the next square sum one step at a time.
        slowCalculation = findSquareSum(slowCalculation)
        // Calculate the next square sum two steps at a time.
        fastCalculation = findSquareSum(findSquareSum(fastCalculation))
    } while slowCalculation != fastCalculation // They will eventually meet at the same calculation, so stop.
    
    // If the slower calculation is 1, that means it's a happy number since going down to 1 cuases a cycle back to 1.
    return slowCalculation == 1
}

private func findSquareSum(_ num: Int) -> Int {
    var sum = 0
    var mNum = num
    while mNum > 0 {
        // Get the first digit to square.
        let firstDigit = mNum % 10
        sum += firstDigit * firstDigit
        // Get the digits left after removing the first digit.
        mNum = Int(floor(Double(mNum) / 10.0))
    }
    return sum
}

// MARK: - Problem Challenge 1: Palindrome LinkedList (Medium)
/*
 Given the head of a Singly LinkedList, write a method to check if the LinkedList is a palindrome or not.

 Your algorithm should use constant space and the input LinkedList should be in the original form once the algorithm is finished. The algorithm should have O(N) time complexity where ‘N’ is the number of nodes in the LinkedList.
 */
// The algorithm reverses the 2nd half of the linked list, and then compares both halves value by value. After the comparisons, the 2nd half is reversed again to revert the original list back to how it was.
// Time O(N), Space (1)
func isPalindrome<T>(_ head: LinkedList<T>?) -> Bool {
    if head == nil || head?.next == nil { return true }
    var mHead = head
    
    var middleNode = getMiddleNode(in: mHead)
    // Contains the 2nd half of the list in reverse. This also causes the original list to only contain the first half because the middle node's next value has been set to nil.
    var headSecondHalf = reverseLinkedList(&middleNode)
    var copyHeadSecondHalf = headSecondHalf // Store the head of the reverse list for later.
    
    // Compare the first half and second half. Both lists at this point are a half of the list each, so they are the same size if it's a valid palindrome.
    while mHead != nil && headSecondHalf != nil {
        if mHead?.value != headSecondHalf?.value { break }
        mHead = mHead?.next
        headSecondHalf = headSecondHalf?.next
    }

    // Reverse the reversed list back to normal. Even though copyHeadSecondHalf only contains the 2nd half, the last node of the first half is still pointing to the last node of this list. This is why the full list is still present when it's reversed again. Basically: (1 -> 2 -> [6) <- 4 <- 2]
    _ = reverseLinkedList(&copyHeadSecondHalf)
    if mHead == nil || headSecondHalf == nil { // If both halves reached the end, then they match.
        return true
    }
    
    return false
}

private func reverseLinkedList<T>(_ head: inout LinkedList<T>?) -> LinkedList<T>? {
    var prev: LinkedList<T>? = nil
    while head != nil {
        let next = head?.next
        head?.next = prev
        prev = head
        head = next
    }
    return prev
}

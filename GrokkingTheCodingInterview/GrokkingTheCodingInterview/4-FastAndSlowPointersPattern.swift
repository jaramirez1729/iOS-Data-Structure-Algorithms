//
//  4-FastAndSlowPointersPattern.swift
//  GrokkingTheCodingInterview
//
//  Created by J.A. Ramirez on 2/16/22.
//

import Foundation
/*
 COMPLETED
 
 The Fast & Slow pointer approach, also known as the Hare & Tortoise algorithm, is a pointer algorithm that uses two pointers which move through the collection at different speeds. This approach is quite useful when dealing with cyclic collections.
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
// Use Clyde's Cycle Finding Algorithm first. After both pointers have met, then start a new traversal from that point while couting the nodes. Stop when it has reached the slowPointer again and that is the length.
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

// Simply starts counting after the current node until it reaches it again.
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
// Since the fast pointer moves twice as fast, when it reaches the end of the list, the slow pointer will be left in the middle of the list.
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
// First, get the length of the cycle. Move a second pointer N number of times forward where N is the length of the cycle. Then, move the first and second pointers by 1 and eventually they'll meet up at the starting cycle node.
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
    // Then move both pointers by 1 each time. Eventually, they will meet up at the start of the cycle node. This is because pointer2 will have completed a cycle.
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
// When realizing there is a cycle to observe, consider uses a slow and fast pointer approach. Uses 2 number "pointers" to calculate the square sum. One will move faster than the other one. They will eventually meet up at the same calculation, which means the faster one has completed the entire cycle of calculation already. When we leave the loop, we want to know if the slow pointer is stuck on 1 since it will remain there forever. If it did, then it's a happy number.
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
// First, get the middle node. The algorithm reverses the 2nd half of the linked list, and then compares both halves value by value. After the comparisons, the 2nd half is reversed again to revert the original list back to how it was.
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
    // If either reached the end, it's a match. This is because the mHead will contain 1 more where the final node has a reference to the middle node still.
    if mHead == nil || headSecondHalf == nil {
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

// MARK: - Problem Challenge 2: Rearrange a LinkedList (Medium)
/*
 Given the head of a Singly LinkedList, write a method to modify the LinkedList such that the nodes from the second half of the LinkedList are inserted alternately to the nodes from the first half in reverse order. So if the LinkedList has nodes 1 -> 2 -> 3 -> 4 -> 5 -> 6 -> null, your method should return 1 -> 6 -> 2 -> 5 -> 3 -> 4 -> null.

 Your algorithm should not use any extra space and the input LinkedList should be modified in-place.
 */
// Time O(N), Space O(1)
func reorder<T>(_ head: inout LinkedList<T>?) {
    if head == nil || head?.next == nil { return }
    
    var middleNode = getMiddleNode(in: head)
    var headSecondHalf = reverseLinkedList(&middleNode)
    var headFirstHalf = head
    // Rearrange in alternate order. First we update the point from the first half to point to an item in the second half, then we update the second half to point to an item in the first half and continue.
    while headFirstHalf != nil && headSecondHalf != nil {
        var temp = headFirstHalf?.next
        headFirstHalf?.next = headSecondHalf
        headFirstHalf = temp
        
        temp = headSecondHalf?.next
        headSecondHalf?.next = headFirstHalf
        headSecondHalf = temp
    }
    
    // Set the next of the last node to nil in case the previous loop stopped because headSecondHalf.
    if headFirstHalf != nil {
        headFirstHalf?.next = nil
    }
}

// Problem Challenge 3: Cycle in a Circular Array (Hard)
/*
 We are given an array containing positive and negative numbers. Suppose the array contains a number ‘M’ at a particular index. Now, if ‘M’ is positive we will move forward ‘M’ indices and if ‘M’ is negative move backwards ‘M’ indices. You should assume that the array is circular which means two things:

 1) If, while moving forward, we reach the end of the array, we will jump to the first element to continue the movement. 
 2) If, while moving backward, we reach the beginning of the array, we will jump to the last element to continue the movement.
 
 Write a method to determine if the array has a cycle. The cycle should have more than one element and should follow one direction which means the cycle should not contain both forward and backward movements.
 */
// Uses 2 pointers on the indexes. For every number, we will check if there is a loop by running a loop and looking if there are any. If not, then continue to the next number. 
// Time O(N^2), Space O(1)
func doesArrayHaveCycle(_ nums: [Int]) -> Bool {
    
    for i in 0..<nums.endIndex {
        let isForward = nums[i] >= 0
        var slowIndex = i
        var fastIndex = i
        // if either become -1, this means we can't find a cycle for this number; continue with the other numbers.
        while true {
            // Move on step for the slow one.
            slowIndex = findNextIndex(in: nums, isForward: isForward, currentIndex: slowIndex)
            fastIndex = findNextIndex(in: nums, isForward: isForward, currentIndex: fastIndex)
            // Move an additional step for the fast index.
            if fastIndex != -1 {
                fastIndex = findNextIndex(in: nums, isForward: isForward, currentIndex: fastIndex)
            }
            // -1 if no cycles or a single cycle found.
            if slowIndex == -1 || fastIndex == -1 || slowIndex == fastIndex {
                break
            }
        }
        
        // They eventually met up when both were not -1, which means there's a cycle.
        if slowIndex != -1 && slowIndex == fastIndex {
            return true
        }
    }
    
    return false
}

private func findNextIndex(in nums: [Int], isForward: Bool, currentIndex: Int) -> Int {
    let direction = nums[currentIndex] >= 0
    if isForward != direction {
        return -1 // Direction has changed, so stop. Only a single direction is allowed.
    }
    // Jump by the current number. We use mod to ensure that the index is only within the bounds of the array. This is the same as if it wrapped around after passing the end.
    var nextIndex = (currentIndex + nums[currentIndex]) % nums.count
    if nextIndex < 0 {
        nextIndex += nums.count // Wrap around for negative numbers.
    }
    if nextIndex == currentIndex {
        nextIndex = -1 // One element cycle, return -1 since it passed around to the same index it was just in.
    }
    return nextIndex
}

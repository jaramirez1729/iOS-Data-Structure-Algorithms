//
//  LeetCode.swift
//  LinkedListAlgorithms
//
//  Created by J.A. Ramirez on 11/21/21.
//

import Foundation

// MARK: -  Delete Node in a Linked List
/*
 Write a function to delete a node in a singly-linked list. You will not be given access to the head of the list, instead you will be given access to the node to be deleted directly.

 It is guaranteed that the node to be deleted is not a tail node in the list.
 */
func deleteNode(_ node: ListNode?) {
    guard let node = node else { return }
    node.val = node.next?.val ?? 0
    node.next = node.next?.next
}

//  MARK: - Remove Nth Node From End of List
/*
 Given the head of a linked list, remove the nth node from the end of the list and return its head.
 */
// Listen, Example, Brute, Optimize (BUD), Walkthrough, Implement, Test
// Example: 2 -> 3 -> 5 -> 1 -> 6 -> 8 -> 10
// Brute: Traverse the list to get the total number of nodes (7). If n = 3, then traverse again up until 7 - 3 = 4.
// The node after the stopping point is the one to remove. So set the last traversed node's next to nil and return the head.
// Time O(n), Space O(1)
func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
    if head == nil { return nil }
    
    var totalNodes = 0
    var tNode = head
    while tNode != nil {
        totalNodes += 1
        tNode = tNode?.next
    }
    
    // If the node to remove is at the start, return the next node.
    if totalNodes == n {
        return head?.next
    }
    
    // Find the node to remove.
    var stopIndex = totalNodes - n
    tNode = head
    while stopIndex != 1 {
        stopIndex -= 1
        tNode = tNode?.next
    }
    tNode?.next = tNode?.next?.next
    
    return head
}

// Optimize: We can use 2 pointers. The first pointer starts at the beginning. The second pointer will go n times forward.
// Both pointers will move ahead by 1 at the same time. Stop when the 2nd pointer has reached the last node. The first pointer's next value will be the node to remove.
// 2p -> 3 -> 5 -> 1p -> 6 -> 8 -> 10
// 2 -> 3p -> 5 -> 1 -> 6p -> 8 -> 10
// 2 -> 3 -> 5p -> 1 -> 6 -> 8p -> 10
// 2 -> 3 -> 5 -> 1p -> 6 -> 8 -> 10p
// 
// 1p -> 2t
// Time O(n), Space O(1)
//func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
//    if head == nil { return nil }
//    var frontPointer = head
//    var endPointer = head
//    // Move the 2nd pointer n number of times forward from the front pointer.
//    for _ in 1...n {
//        endPointer = endPointer?.next
//    }
//    
//    while endPointer?.next != nil {
//        frontPointer = frontPointer?.next
//        endPointer = endPointer?.next
//    }
//    
//    if frontPointer === head {
//        return frontPointer?.next
//    }
//    
//    frontPointer?.next = frontPointer?.next?.next
//    
//    return head
//}

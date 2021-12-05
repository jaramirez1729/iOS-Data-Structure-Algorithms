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
func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
    
    
    return head
}

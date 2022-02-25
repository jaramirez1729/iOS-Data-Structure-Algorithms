//
//  7-ReversalLinkedListPattern.swift
//  GrokkingTheCodingInterview
//
//  Created by J.A. Ramirez on 2/23/22.
//

import Foundation

/*
 In a lot of problems, we are asked to reverse the links between a set of nodes of a LinkedList. Often, the constraint is that we need to do this in-place, i.e., using the existing node objects and without using extra memory.

 In-place Reversal of a LinkedList pattern describes an efficient way to solve the above problem. In the following chapters, we will solve a bunch of problems using this pattern.
 */

// MARK: - Reverse a LinkedList (Easy)
/*
 Given the head of a Singly LinkedList, reverse the LinkedList. Write a function to return the new head of the reversed LinkedList.
 */
// Time O(N), Space O(1)
func reverseLinkedList<T>(_ head: LinkedList<T>?) -> LinkedList<T>? {
    var currentNode = head
    var previousNode: LinkedList<T>?
    while currentNode != nil {
        let next = currentNode?.next // Temporarily store the next value.
        currentNode?.next = previousNode // Reverse the current node before we move to the next node, point previous to the current node.
        previousNode = currentNode
        currentNode = next
    }
    return previousNode
}

// MARK: - Reverse a Sub-list (Medium)
/*
 Given the head of a LinkedList and two positions ‘p’ and ‘q’, reverse the LinkedList from position ‘p’ to ‘q’.
 */
// 
// Time O(N), Space O(1)
func reverseSubList<T>(_ head: inout LinkedList<T>?, from p: Int, to q: Int) -> LinkedList<T>? {
    if p == q { return head }
    
    var currentNode = head
    var previousNode: LinkedList<T>?
    var i = 0
    // After skipping p-1 nodes, current will point to pth node.
    while currentNode != nil && (i < p - 1) {
        previousNode = currentNode
        currentNode = currentNode?.next
        i += 1
    }

    // we are interested in three parts of the LinkedList, the part before index 'p', the part between 'p' and 'q', and the part after index 'q'.
    // The previousNode right now will end up as the last node when sub-list is reversed.
    let lastNodeOfFirstPart = previousNode
    // After reversing the list, current will become the last node of the sub-list.
    let lastNodeOfSubList = currentNode
    // Will be used to temporarily store the next node for traversal.
    var nextNode: LinkedList<T>?
    // Reverse the sub-list where i is the index for that portion.
    i = 0
    while currentNode != nil && (i < q - p + 1) {
        nextNode = currentNode?.next
        currentNode?.next = previousNode
        previousNode = currentNode
        currentNode = nextNode
        i += 1
    }
    
    // Connect with the first part.
    if lastNodeOfFirstPart != nil {
        // Previous is now the first node of the sub-list.
        lastNodeOfFirstPart?.next = previousNode
    } else {
        // This means p == 1, we are changing the first node of the list.
        head = previousNode
    }
    // Coonnect with the last part.
    lastNodeOfSubList?.next = currentNode
    
    return head
}

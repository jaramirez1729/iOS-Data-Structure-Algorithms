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

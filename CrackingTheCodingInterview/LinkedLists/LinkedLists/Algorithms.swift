//
//  Algorithms.swift
//  LinkedLists
//
//  Created by J.A. Ramirez on 12/22/21.
//

import Foundation

// MARK: - Remove Duplicates
/*
 Write an algorithm that removes duplicates from an unsorted linked list.
 */

// Approach #1 (Brute, Faster): We can loop through linked list and store the values we visit into an array. As we go through the list, we will be checking if the value is already in the array and if it is, remove that node and keep going until the loop is done.
// O(N), O(N)
func removeDuplicates<T>(from list: SingleLinkedList<T>) {
    var values: [T] = []
    var tNode = list.head
    if let val = tNode?.value { values.append(val) }
    
    while tNode?.next != nil {
        if let val = tNode?.next?.value {
            if !values.contains(val) {
                values.append(val)
                // We should only move forward if we saved the value as it did not contain
                // a duplicate.
                tNode = tNode?.next
            } else {
                // We do not move the tNode if we updated the list since the ordering
                // will be incorrect and can miss checking the next node.
                tNode?.next = tNode?.next?.next
            }
        }
    }
}

// Approach #2 (Space Saving): We can loop through the list with 2 pointers. The first pointer is to keep the current position, and the 2nd pointer will loop the rest of the list and remove any nodes that match the value of the current node. This will cause the 2nd pointer to keep looping through the list, getting smaller each iteration as nodes are removed, but it's not fast. 

// MARK: - Return the Kth to Last Element
/*
 Implement an algorithm to find the kth to last element of a singly linked list.
 */

// MARK: - Delete Middle Node
/*
 Implement an algorithm to delete a node in the middle (i.e., any node but the first and last node, not necessarily the exact middle) of a singly linked list, given only access to that node.
 */

// MARK: - Partition
/*
 Write code to partition a linked list around a value x, such that all nodes less than x come before all nodes greater than or equal to x. If x is contained within the list, the values of x only need to be after the elements less than x (see below). The partition element x can appear anywhere in the "right partition"; it does not need to appear between the left and right partitions.
 */

// MARK: - Sum Lists
/*
 You have two numbers represented by a linked list, where each node contains a single digit.The digits are stored in reverse order, such that the 1 's digit is at the head of the list. Write a function that adds the two numbers and returns the sum as a linked list.
 */

// MARK: - Palindrome
/*
 Implement a function to check if a linked list is a palindrome.
 */

// MARK: - Intersection
/*
 Given two (singly) linked lists, determine if the two lists intersect. Return the inter­ secting node. Note that the intersection is defined based on reference, not value.That is, if the kth node of the first linked list is the exact same node (by reference) as the jth node of the second linked list, then they are intersecting.
 */

// MARK: Loop Detection
/*
 Given a circular linked list, implement an algorithm that returns the node at the
 beginning of the loop.
 */

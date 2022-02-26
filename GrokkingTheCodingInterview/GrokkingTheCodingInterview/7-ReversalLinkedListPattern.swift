//
//  7-ReversalLinkedListPattern.swift
//  GrokkingTheCodingInterview
//
//  Created by J.A. Ramirez on 2/23/22.
//

import Foundation

/*
 COMPLETED
 
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
// First, we count up to the p node. Then, we store references for the sub-list to connect to after it has been reversed. Reverse the list only up to i < q - p + 1 position. Then, connect back to the original list.
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

/* Similar Question #1: Reverse the first ‘k’ elements of a given LinkedList. */

/* Similar Question #2: Given a LinkedList with ‘n’ nodes, reverse it based on its size in the following way:
 1) If ‘n’ is even, reverse the list in a group of n/2 nodes.
 2) If n is odd, keep the middle node as it is, reverse the first ‘n/2’ nodes and reverse the last ‘n/2’ nodes.
 */

// MARK: - Reverse every K-element Sub-list (Medium)
/*
 Given the head of a LinkedList and a number ‘k’, reverse every ‘k’ sized sub-list starting from the head.

 If, in the end, you are left with a sub-list with less than ‘k’ elements, reverse it too.
 */
// Similar to reverseSubList. Uses an pointer to keep track of where we are in the list. Uses an outer loop that controls every reversal. In the loop, we will reverse k nodes. When the pointer reaches the end, we are done.
// Time O(N), Space O(1)
func reverseKElementSubList<T>(_ head: inout LinkedList<T>?, k: Int) -> LinkedList<T>? {
    if k <= 1 || head == nil { return head }
    
    var currentNode = head
    var previousNode: LinkedList<T>?
    // Every loop will reverse a sub-list of size k.
    while true {
        let lastNodeOfFirstPart = previousNode
        // After reversing the linked list, current will become the last node of the sub-list.
        let lastNodeOfSubList = currentNode
        // Will be used temporarily for traversal.
        var nextNode: LinkedList<T>?
        var i = 0
        while currentNode != nil && i < k { // Reverse 'k' nodes
            nextNode = currentNode?.next
            currentNode?.next = previousNode
            previousNode = currentNode
            currentNode = nextNode
            i += 1
        }
        
        // Reconnect the reversed nodes back into the list.
        if lastNodeOfFirstPart != nil {
            lastNodeOfFirstPart?.next = previousNode
        } else {
            head = previousNode
        }
        lastNodeOfSubList?.next = currentNode
        
        // The end of the list has been reached.
        if currentNode == nil { break }
        previousNode = lastNodeOfSubList
    }
    return head
}

// MARK: - Problem Challenge #1: Reverse Alternating K-Element Sub-List (Medium)
// Similar to reverseKElementSubList. The only difference is we need to skip k nodes before the next loop starts.
// Time O(N), Space O(1)
func reverseAlternatingKElementSubList<T>(_ head: inout LinkedList<T>?, k: Int) -> LinkedList<T>? {
    if k <= 1 || head == nil { return head }
    
    var currentNode = head
    var previousNode: LinkedList<T>?
    // Every loop will reverse a sub-list of size k.
    while currentNode != nil { // Break if we've reached the end of the list.
        let lastNodeOfFirstPart = previousNode
        // After reversing the linked list, current will become the last node of the sub-list.
        let lastNodeOfSubList = currentNode
        // Will be used temporarily for traversal.
        var nextNode: LinkedList<T>?
        var i = 0
        while currentNode != nil && i < k { // Reverse 'k' nodes
            nextNode = currentNode?.next
            currentNode?.next = previousNode
            previousNode = currentNode
            currentNode = nextNode
            i += 1
        }
        
        // Reconnect the reversed nodes back into the list.
        if lastNodeOfFirstPart != nil {
            lastNodeOfFirstPart?.next = previousNode
        } else {
            head = previousNode
        }
        lastNodeOfSubList?.next = currentNode
        
        // The end of the list has been reached.
        if currentNode == nil { break }
        previousNode = lastNodeOfSubList

        // Skip 'k' nodes to reverse the next sub-list.
        i = 0
        while currentNode != nil && i < k {
            previousNode = currentNode
            currentNode = currentNode?.next
            i += 1
        }
    }
    return head
}

// MARK: - Problem Challenge #2: Rotate a LinkedList (medium)
/*
 Given the head of a Singly LinkedList and a number ‘k’, rotate the LinkedList to the right by ‘k’ nodes.
 */
// First, we get the size of the list and a reference to the last node. Then, we calculate a valid rotation number based on the size of the list. Then, we get a reference to the node that will end up at the end of the list by calculating the list length - valid rotations. Then, adjust the new head and tail.
// Time O(N), Space(1)
func rotateLinkedList<T>(_ head: inout LinkedList<T>?, by rotations: Int) -> LinkedList<T>? {
    if head == nil || head?.next == nil || rotations <= 0 { return head }
    
    // Find the lenght and the last node of the list.
    var lastNode = head
    var listLenght = 1
    while lastNode?.next != nil {
        lastNode = lastNode?.next
        listLenght += 1
    }
    
    lastNode?.next = head // Connect the last node with the head to make a circular list.
    let validRotations = rotations % listLenght // Get a valid rotation thats within the list bounds.
    // The skip length will be used to get a pointer to the node that will end up at the end after rotations.
    let skipLenght = listLenght - validRotations
    var lastNodeOfRotatedList = head
    for _ in 0..<skipLenght - 1 { 
        lastNodeOfRotatedList = lastNodeOfRotatedList?.next
    }
    
    // lastNodeOfRotatedList is pointing to the sub-list of k ending nodes.
    head = lastNodeOfRotatedList?.next
    lastNodeOfRotatedList?.next = nil
    
    return head
}

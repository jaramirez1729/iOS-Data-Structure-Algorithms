//
//  main.swift
//  LinkedListsAlgorithms
//
//  Created by Jozeee on 1/14/20.
//  Copyright © 2020 AdaloveSoftware. All rights reserved.
//

/*
 Linked List Questions
 Reverse a linked list.
 Detect loop in a link list.
 Return nth node from the end in a link list.
 Remove duplicates from a linked list.
 */


// MARK: -
// Reverse a linked list.
// Listen. Example: []x, [1]x, [1, 2], [1, 2, 3]
// Brute Force: Loop through and read every single value and add it into an array, reverse the array, and then loop through
// the list again and replace every value with every value in the array.
// Bottlenecks? Looping to read each value, and reversing the array. Also causes space to go up with size of the list total.
// we don't have to reverse the array; we can just loop backwards.
// Unnecessary work? We're looping twice.
// Duplicate work? 2 loops to the list.
// Time: O(n) where n is the size of the list.
// Space: O(n) Since the space grows in relation to the list size.
func reverseSingleLinkedList(_ list: SingleLinkedList<Int>) -> SingleLinkedList<Int> {
    guard list.count > 1 else { return list }
    
    var nums: [Int] = []
    var tNode = list.first
    // Store every node into an array in same order as list.
    for _ in 0..<list.count { // Loops n times where n is the number of nodes.
        if let val = tNode?.value {
            nums.append(val)
        }
        tNode = tNode?.next
    }
    
    // Traverse again and replacing every value with the reverse index of the array.
    tNode = list.first
    for i in (0..<nums.count).reversed() { // Loops n times where n is the number of elements of the array.
        tNode?.value = nums[i]
        tNode = tNode?.next
    }
    
    return list
}


// MARK: -
// Rerverses a linked list using a stack.
// Time O(n)
// Space O(n)
func reverseStackSingleLinkedList(_ list: SingleLinkedList<Int>) -> SingleLinkedList<Int> {
    guard list.count > 1 else { return list }
    let stack = Stack<Int>()
    var tNode = list.first
    
    for _ in 0..<list.count {   // O(n)
        if let val = tNode?.value {
            stack.push(val)
        }
        tNode = tNode?.next
    }
    
    // Restart the traversal again changing each value of the list from the stack.
    tNode = list.first
    
    while !stack.isEmpty {  // O(n)
        if let val = stack.pop() {
            tNode?.value = val
        }
        tNode = tNode?.next
    }
    
    return list
}


// MARK: -
// Reverse a linked list using recursion.
//
// Use recursion when you want to keep a reference to a previous object that you can not directly access since when the recursion
// starts going back, the argument remains available for that previous object.
// Time: O(n) where n is the size of the list. It makes n - 1 recursive calls. It's also linear.
// Space: O(n) the space is allocated for the list size of n. The references are changed, and they are already stored in memory.
func reverseSingleLinkedListRecursively(_ list: SingleLinkedList<Int>) -> SingleLinkedList<Int> {
    let reversedList = SingleLinkedList<Int>()
    reversedList.setHead(reverseSingleLinkedListRecursivelyNode(list.first))
    return reversedList
}

private func reverseSingleLinkedListRecursivelyNode(_ node: SingleNode<Int>?) -> SingleNode<Int>? {
    if let node = node {
        if node.next == nil {
            // We recursively reached the end of the list.
            return node
        }
        // The reference to the last node, which will become the head.
        let lastNode = reverseSingleLinkedListRecursivelyNode(node.next)
        // Set the current's next next node back to itself and remove the next connection.
        // This ensures the current node now points to its previous node.
        node.next?.next = node
        node.next = nil
        // Returning the new head back up the recursive calls.
        return lastNode
    }
    return nil
}


// MARK: -
// Detect loop in a linked list.
// Note that if there is a loop, it will always be the last loop that causes the loop since single is 1 directional.
// If head points to itself, then it's trivial. If the head.next points to head, then it's trivial.
// Listen; Example [1 -> 2 -> 3 -> 4 -> 2]; Brute: Check if the tail node is pointing to an existing node in the list.
// Time: O(n) where n is the size of the list.
func detectLoopInSingleLinkedList(_ list: SingleLinkedList<Int>) {
    // Only the tail can cause a loop.
    if list.last?.next != nil {
        var tNode = list.first
        while list.last?.next !== tNode {
            tNode = tNode?.next
        }
        print("Loop detected: node \(list.last?.value ?? 0) points to node \(tNode?.value ?? 0).")
        return
    }
    print("There is no loop.")
}


// MARK: -
// Detect loop in a linked list.
// What if there was no reference to the tail?
// Store each node reference in a dictionary as a key, and the value to what node it points to. If there is a loop, one of the values
// will match one of the keys that has already been added.
// Time: O(n) where n is the list of the list. It will keep looping until it gets to the end.
// Space: O(n) l is the size of the list. k is the number of keys stored, and v is the number of values stored. These grow depending on list size.
func detectLoopInSingleLinkedListNoTail(_ list: SingleLinkedList<Int>) {
    var tNode = list.first
    var dict: [UnsafeMutableRawPointer: UnsafeMutableRawPointer] = [:]
    while true {
        if let node = tNode, let next = node.next {
            if dict[Unmanaged.passRetained(next).toOpaque()] != nil {
                // If the next node's address has already been registered, that means the traversal has already passed it, and thus there is a loop.
                print("Loop Detected: Node \(node.value) points to node \(next.value).")
                return
            } else {
                // Key: Current node address. Value: Address node points to.
                dict[Unmanaged.passUnretained(node).toOpaque()] = Unmanaged.passUnretained(next).toOpaque()
            }
            tNode = next
        } else {
            break
        }
    }
    print("There is no loop.")
}


// MARK: -
// Detect loop in a linked list.
/* Floyd’s Cycle-Finding Algorithm: This is the fastest method and has been described below:
 - Traverse linked list using two pointers.
 - Move one pointer(slow_p) by one and another pointer(fast_p) by two.
 - If these pointers meet at the same node then there is a loop. If pointers do not meet then linked list doesn’t have a loop
 */
// Time: O(n) where n is the size of the list. Worst case is it loops through the entire thing until it finds the loop.
// Space: O(1) where the space does not increase linearly regardless of the size of the list.
func detectLoopInSingleLinkedListFloyd(_ list: SingleLinkedList<Int>) {
    var slowNode = list.first?.next
    var fastNode = list.first?.next?.next
    // If one ends up being nil, that means the next of a node did not point to anything, so there is no loop possible.
    while slowNode != nil || fastNode != nil {
        if slowNode === fastNode {
            print("There is a loop.")
            return
        }
        slowNode = slowNode?.next
        fastNode = fastNode?.next?.next
    }
    print("There is no loop.")
}


// MARK: -
// Return nth node from the end in a link list.
// Listen; Example: [1 -> 2 -> 3 -> 4]
// Brute: Get the total count of the list - 1, and then countdown from the beginning and stop when the index is reached.
// Optimize (Bottlenecks Unnecessary work Duplicate work)
// Time O(n): Worst case the value needed to be returned is the last element of the list, so it will loop through all of it.
// Space O(1)
func returnNodeFromEndWithIndex(_ index: Int, list: SingleLinkedList<Int>) -> SingleNode<Int>? {
    guard index < list.count else { return nil }
    var countdownIndex: Int = list.count - 1
    var tNode = list.first
    while countdownIndex != index {
        countdownIndex -= 1
        tNode = tNode?.next
    }
    return tNode
}


// MARK: -
// Remove duplicates from a linked list.
/* Listen: All duplicates or duplicates of a specific number? All of them.
 // Example: [1, 2, 1X, 3, 2X, 4, 2X]; Visited: [1, 2, 3, 4]
 // Brute:
 Set a node to be the starting node; store the starting node. Check if the node's next value is already in the list. If it is in the list, then connect the current
 node to the duplicate node's next node to remove that duplicate from the list. So now the next node has not been visited yet, so go through a loop and check if the
 next value is also a duplicate; this is necessary because the next ones can all be duplicates.
 When the traverse node next is nil, then it's complete and return list.
 If it's not in the list, then store that value in the array and go to the next node. */
// Optimize (BUD); Walkthrough; Implement; Test
// Time: O(n): n is the size of the list since every node is checked against.
// Space: O(n): Assuming there are no duplicates, so the space grows in relation to the list size.
func removeDuplicates(from list: SingleLinkedList<Int>) -> SingleLinkedList<Int> {
    var tNode = list.first
    var values: [Int] = []
    if let val = tNode?.value { values.append(val) }
    // Traverse the list to find duplicates by comparing if they already exist.
    while tNode?.next != nil {
        // Check the next node in order to keep a reference to the current node.
        if let val = tNode?.next?.value {
            if values.contains(val) {
                // Do not change the current reference but update the next reference.
                // Node is not changed to allow the next value to be checked.
                tNode?.next = tNode?.next?.next
            } else {
                values.append(val)
                tNode = tNode?.next
            }
        }
    }
    return list
}


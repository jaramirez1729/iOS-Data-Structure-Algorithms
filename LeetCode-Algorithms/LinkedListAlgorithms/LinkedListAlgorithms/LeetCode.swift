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
func deleteNode(_ node: SingleListNode?) {
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
func removeNthFromEnd(_ head: SingleListNode?, _ n: Int) -> SingleListNode? {
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

// MARK: - Reverse Linked List
/*
 Given the head of a singly linked list, reverse the list, and return the reversed list.
 */
// LEBOWITS
// Example: 1 -> 2 -> 3 -> 4 -> nil should become 4 -> 3 -> 2 -> 1 -> nil
// Brute: Traverse the list and store each value into a stack, and then pop each value and overwritting the existing value for that node as we traverse it.
// Optimized(BUD): Keep 3 pointers: previous, current, and next node. Previous will be nil, current will be the head, and next will be the head's next - initially. Set the current's next to the previous node. Then the previous is set to the current pointer. The current pointer is set to the next's pointer, and the next is set to the next next pointer and so forth. If the current pointer is nil, then return back the previous node as the new head.
// nil(p) 1(c) -> 2(n) -> 3 -> 4 -> nil
// nil <- 1 <- 2 <- 3 <- 4(p) nil(c)(n)
func reverseList(_ head: SingleListNode?) -> SingleListNode? {
    var prev: SingleListNode? = nil
    var current = head
    var next = current?.next
    
    while current != nil {
        current?.next = prev
        prev = current
        current = next
        next = next?.next
    }
    return prev
}

// MARK: - Merge Two Sorted Lists 
/*
 You are given the heads of two sorted linked lists list1 and list2.
 Merge the two lists in a one sorted list. The list should be made by splicing together the nodes of the first two lists.
 Return the head of the merged linked list.
 */
// Example: 1 -> 3 -> 5 -> 7 and 2 -> 4 -> 6 -> 7 -> 10
// Brute: Traverse both lists and store the values into arrays. Combine both arrays and sort it.
// Optimize(BUD): We can do a single loop and compare values continously.
func mergeTwoLists(_ list1: SingleListNode?, _ list2: SingleListNode?) -> SingleListNode? {
    let prehead = SingleListNode(-1)
    var tList1 = list1
    var tList2 = list2
    var prev: SingleListNode? = prehead
    
    while tList1 != nil && tList2 != nil {
        if tList1!.val <= tList2!.val {
            prev?.next = tList1
            tList1 = tList1?.next
        } else {
            prev?.next = tList2
            tList2 = tList2?.next
        }
        prev = prev?.next
    }
    
    // Add the remaining values since either list can still have values.
    prev?.next = tList1 == nil ? tList2 : tList1
    
    return prehead.next
}

func mergeTwoListsRecursion(_ list1: SingleListNode?, _ list2: SingleListNode?) -> SingleListNode? {
    if list1 == nil {
        return list2
    } else if list2 == nil {
        return list1
    } else if let val1 = list1?.val, let val2 = list2?.val, val1 < val2 {
        list1?.next = mergeTwoLists(list1?.next, list2)
        return list1
    } else {
        list2?.next = mergeTwoLists(list1, list2?.next)
        return list2
    }
}

// MARK: - Palindrome Linked List
/*
 Given the head of a singly linked list, return true if it is a palindrome.
 */
// Example: 1 -> 2 -> 2 -> 1
// Example: 1 -> 2 -> 3 -> 2 -> 1
// Brute: Traverse the list and store each value into an array and then loop the array from both ends.
// Brute: Traverse the list and store a count for how many times each value repeats. There can either be 0 or 1 instances of values that repeat an odd number of times.
// Time O(n), Space O(n)
func isPalindrome(_ head: SingleListNode?) -> Bool {
    var values: [Int] = []
    var tNode = head
    while tNode != nil {
        values.append(tNode!.val)
        tNode = tNode?.next
    }
    return values == values.reversed()
}

// Optimized(BUD): To get the middle of the linked list, we just need 2 pointers where the 2nd pointer is moving twice as fast. Then, we reverse the 2nd half of the linked list and use 2 pointers again to compare each value and see if they are equal to each other.
//func isPalindrome(_ head: ListNode?) -> Bool {
//    var slow = head
//    var fast = head?.next?.next
//    while fast?.next != nil {
//        slow = slow?.next
//        fast = fast?.next
//    }
//    
//    
//    
//    return false
//}

// MARK: - Linked List Cycle
/*
 Given head, the head of a linked list, determine if the linked list has a cycle in it.

 There is a cycle in a linked list if there is some node in the list that can be reached again by continuously following the next pointer. Internally, pos is used to denote the index of the node that tail's next pointer is connected to. Note that pos is not passed as a parameter.

 Return true if there is a cycle in the linked list. Otherwise, return false.
 */
func hasCycle(_ head: SingleListNode?) -> Bool {
    var slow = head
    var fast = head?.next
    while fast != nil {
        if fast === slow { 
            return true
        } else {
            slow = slow?.next
            fast = fast?.next?.next
        }
    }
    return false
}

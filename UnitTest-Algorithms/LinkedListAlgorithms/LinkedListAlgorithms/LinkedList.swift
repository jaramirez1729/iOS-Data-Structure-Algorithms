//
//  LinkedList.swift
//  LinkedListAlgorithms
//
//  Created by J.A. Ramirez on 11/21/21.
//

import Foundation

public struct SingleLinkedList {
    public var head: ListNode?
    init(_ val: Int) {
        if head == nil {
            head = ListNode(val)
        }
    }
}

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

extension ListNode: CustomStringConvertible {
    public var description: String {
        var values = [String]()
        var t: ListNode? = self
        while t != nil {
            values.append("\(t!.val)")
            t = t?.next
        }
        return values.joined(separator: " -> ")
    }
}

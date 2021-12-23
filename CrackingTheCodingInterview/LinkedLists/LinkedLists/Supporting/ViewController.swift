//
//  ViewController.swift
//  LinkedLists
//
//  Created by J.A. Ramirez on 12/4/21.
//

import Foundation

public struct SingleLinkedList {
    public var head: SingleListNode?
    init(_ val: Int) {
        if head == nil {
            head = SingleListNode(val)
        }
    }
}

public class SingleListNode {
    public var val: Int
    public var next: SingleListNode?
    
    public init() { 
        self.val = 0
        self.next = nil
    }
    
    public init(_ val: Int) { 
        self.val = val
        self.next = nil
    }
    
    public init(_ val: Int, _ next: SingleListNode?) { 
        self.val = val
        self.next = next
    }
}

extension SingleListNode: CustomStringConvertible {
    public var description: String {
        var values = [String]()
        var t: SingleListNode? = self
        while t != nil {
            values.append("\(t!.val)")
            t = t?.next
        }
        return values.joined(separator: " -> ")
    }
}

//
//  DoubleLinkedList.swift
//  LinkedListAlgorithms
//
//  Created by J.A. Ramirez on 12/13/21.
//

import Foundation

public class DoubleLinkedList<T> {
    public var head: DoubleListNode<T>?
    public var tail: DoubleListNode<T>?
    
    public init() {}
    
    public init(_ value: T) {
        if head == nil {
            addHead(value)
        }
    }
    
    public init(_ values: [T]) {
        for value in values {
            append(value)
        }
    }
    
    @discardableResult
    public func append(_ value: T) -> DoubleListNode<T>? {
        if head == nil {
            addHead(value)
            return head
        } else {
            var traverse = head
            while traverse?.next != nil {
                traverse = traverse?.next
            }
            let newNode = DoubleListNode(value)
            newNode.set(prev: traverse, next: nil)
            tail = newNode
            return newNode
        }
    }
    
    /// Allows it to point to a new list, with the tail reference updated.
    public func setNewHead(_ newHead: DoubleListNode<T>?) {
        head = newHead
        var traverse = head
        while traverse?.next != nil {
            traverse = traverse?.next
        }
        tail = traverse
    }
    
    private func addHead(_ value: T) {
        head = DoubleListNode(value)
        tail = head
    }
}

extension DoubleLinkedList: CustomStringConvertible {
    public var description: String {
        head?.description ?? "The list is empty."
    }
}


// MARK: -
public class DoubleListNode<T> {
    public var value: T
    public var next: DoubleListNode?
    public var prev: DoubleListNode?
    
    public init(_ val: T) {
        self.value = val
    }
    
    public func set(prev: DoubleListNode?, next: DoubleListNode? = nil) {
        self.next = next
        self.prev = prev
        prev?.next = self
    }
}

extension DoubleListNode: CustomStringConvertible {
    public var description: String {
        var values = [String]()
        var t: DoubleListNode? = self
        while t != nil {
            values.append("\(t!.value)")
            t = t?.next
        }
        return values.joined(separator: " <-> ")
    }
}

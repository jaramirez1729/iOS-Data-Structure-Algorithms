//
//  DoubleLinkedList.swift
//  LinkedListsAlgorithms
//
//  Created by Jozeee on 1/16/20.
//  Copyright © 2020 AdaloveSoftware. All rights reserved.
//

class DoubleLinkedList<T> {
    
    var head: DoubleNode<T>?
    var tail: DoubleNode<T>?
    
    /// Add a new node with a value at the end.
    public func append(value: T) {
        let newNode = DoubleNode(value: value)
        // Add the new node at the end.
        if let tailNode = tail {
            newNode.prev = tailNode
            tailNode.next = newNode
        } else {
            head = newNode
        }
        // The new tail node is the new node that was created. If there's only the head,
        // then the head is also the tail because there's only a single node.
        tail = newNode
    }
    
    public func removeAll() {
        head = nil
        tail = nil
    }
}

class DoubleNode<T> {
    var value: T
    var next: DoubleNode<T>?
    // Declared as weak to prevent retention cycles even if node is removed.
    weak var prev: DoubleNode<T>?
    
    init(value: T) {
        self.value = value
    }
}

// Allows the print function to print a custom string for the object.
extension DoubleLinkedList: CustomStringConvertible {
    public var description: String {
        var text = ""
        // Used for traversing
        var node = head
        while node != nil {
            text += "\(node!.value)"
            node = node!.next
            if node != nil { text += " <-> " }
        }
        return text
    }
}

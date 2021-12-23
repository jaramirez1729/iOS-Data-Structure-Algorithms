//
//  LinkedList.swift
//  LinkedListsAlgorithms
//
//  Created by Jozeee on 1/15/20.
//  Copyright © 2020 AdaloveSoftware. All rights reserved.
//

class SingleLinkedList<T> {
    
    var head: SingleNode<T>?
    var tail: SingleNode<T>?
    
    public var isEmpty: Bool {
        return head == nil
    }
    
    /// Adds a new node at the end of the list.
    public func append(value: T) {
        let newNode: SingleNode<T> = SingleNode(value: value)
        if let tailNode = tail {
            tailNode.next = newNode
        } else {
            head = newNode
        }
        tail = newNode
    }
    
    public func removeAll() {
        head = nil
    }
}

class SingleNode<T> {
    
    var value: T
    var next: SingleNode<T>?
    
    init(value: T, next: SingleNode<T>? = nil) {
        self.value = value
        self.next = next
    }
}

// Allows the print function to print a custom string for the object.
extension SingleLinkedList: CustomStringConvertible {
    public var description: String {
        var text = ""
        // Used for traversing
        var node = head
        while node != nil {
            text += "\(node!.value)"
            node = node!.next
            if node != nil { text += " -> " }
        }
        return text
    }
}

//
//  DoubleLinkedList.swift
//  LinkedListsAlgorithms
//
//  Created by Jozeee on 1/16/20.
//  Copyright © 2020 AdaloveSoftware. All rights reserved.
//

class DoubleNode<T> {
    var value: T
    var next: DoubleNode<T>?
    // Declared as weak to prevent retention cycles even if node is removed.
    weak var prev: DoubleNode<T>?
    
    init(value: T) {
        self.value = value
    }
}

class DoubleLinkedList<T> {
    private var head: DoubleNode<T>?
    private var tail: DoubleNode<T>?
    
    public var isEmpty: Bool {
        return head == nil
    }
    
    public var first: DoubleNode<T>? {
        return head
    }
    
    public var last: DoubleNode<T>? {
        return tail
    }
    
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
    
    /// Returns back the node at the specific index.
    public func nodeAt(index: Int) -> DoubleNode<T>? {
        if index >= 0 {
            // Used for traversing.
            var node = head
            var i = index
            while node != nil {
                if i == 0 { return node }
                i -= 1
                node = node!.next
            }
        }
        return nil
    }
    
    public func removeAll() {
        head = nil
        tail = nil
    }
    
    /// Removes the node at a specific index and returns its value. If none found at the index, then it will return nil.
    @discardableResult public func removeNodeAt(index: Int) -> T? {
        if let node = nodeAt(index: index) {
            return remove(node: node)
        }
        return nil
    }
    
    // Removes the specific node from the list, adjusting any connections necessary.
    private func remove(node: DoubleNode<T>) -> T {
        let prev = node.prev
        let next = node.next
        
        if let prev = prev {
            // Update the next pointer to the next node.
            prev.next = next
        } else {
            // Only the head has no previous.
            head = next
        }
        // Set the previous of the next node to the one before the node removed.
        next?.prev = prev
        
        // The last node.
        if next == nil {
            tail = prev
        }
        
        node.prev = nil
        node.next = nil
        
        return node.value
    }
}

// Allows the print function to print a custom string for the object.
extension DoubleLinkedList: CustomStringConvertible {
    public var description: String {
        var text = "["
        // Used for traversing
        var node = head
        while node != nil {
            text += "\(node!.value)"
            node = node!.next
            if node != nil { text += ", " }
        }
        return text + "]"
    }
}

//
//  LinkedList.swift
//  LinkedListsAlgorithms
//
//  Created by Jozeee on 1/15/20.
//  Copyright © 2020 AdaloveSoftware. All rights reserved.
//

class SingleNode<T> {
    var value: T
    var next: SingleNode<T>?
    init(value: T) {
        self.value = value
    }
}

class SingleLinkedList<T> {
    private var head: SingleNode<T>?
    private var tail: SingleNode<T>?
    private(set) var count: Int = 0
    
    public var isEmpty: Bool {
        return head == nil
    }
    
    public var first: SingleNode<T>? {
        return head
    }
    
    public var last: SingleNode<T>? {
        return tail
    }
    
    /// Convenient way to create a list from an existing list.
    public func setHead(_ node: SingleNode<T>?) {
        head = node
    }
    
    /// Adds a new node at the end of the list.
    public func append(value: T) {
        count += 1
        let newNode: SingleNode<T> = SingleNode(value: value)
        if let tailNode = tail {
            tailNode.next = newNode
        } else {
            head = newNode
        }
        tail = newNode
    }
    
    /// Returns back the node at a specific index.
    public func nodeAt(index: Int) -> SingleNode<T>? {
        if index >= 0 {
            count -= 1
            var mIndex: Int = index
            var tNode = head
            while tNode != nil {
                if mIndex == 0 { return tNode }
                mIndex -= 1
                tNode = tNode!.next
            }
        }
        return nil
    }
    
    public func removeAll() {
        count = 0
        head = nil
    }
    
    /// Removes the node at a specific index and returns its value. If none found at the index, then it will return nil.
    @discardableResult public func removeNodeAt(index: Int) -> T? {
        if let node = nodeAt(index: index) {
            return remove(node: node)
        }
        return nil
    }
    
    /// Removes the first instance of the node that matches.
    private func remove(node: SingleNode<T>) -> T {
        let next = node.next
        var prev = head
        
        if head === node {
            // In case there is only a single element.
            if head === tail { tail = nil }
            // What if we are removing the head?
            head = next
        } else if next == nil {
            // What if we are removing the tail? The node before it now becomes the tail.
            while prev?.next !== node {
                prev = prev?.next
            }
            tail = prev
            tail?.next = nil
        } else {
            // What if we are removing the node in the middle?
            // O -> O -> O
            while prev?.next !== node {
                prev = prev?.next
            }
            prev?.next = next
        }
        
        node.next = nil
        return node.value
    }
}

// Allows the print function to print a custom string for the object.
extension SingleLinkedList: CustomStringConvertible {
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

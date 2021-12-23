//
//  LRUCache.swift
//  LinkedListAlgorithms
//
//  Created by J.A. Ramirez on 12/13/21.
//

import Foundation

/// A data structure that contains fast access to recently accessed items.
public struct LRUCache<T: Hashable> {
    
    // MARK: - Properties
    public private(set) var size: Int
    public private(set) var count: Int = 0
    public private(set) var dict: [T: DoubleListNode<T>?] = [:]
    public private(set) var list = DoubleLinkedList<T>()
    
    // MARK: - Init
    public init(size: Int) {
        self.size = size
    }
    
    // MARK: - Methods
    /// Retrieves an item from the cache.
    public mutating func get(_ value: T) -> T? {
        if let node = dict[value] {
            moveNodeToTop(node)
            return node?.value
        }
        return nil
    }
    
    /// Creates a new item in the cache.
    public mutating func add(_ value: T) {
        if count == size {
            if let key = list.tail?.value {
                dict.removeValue(forKey: key)
            }
            list.tail?.prev?.next = nil
            list.tail = list.tail?.prev
            count -= 1
        }
        let newNode = list.append(value)
        dict[value] = newNode
        moveNodeToTop(newNode)
        count += 1
    }
    
    public mutating func removeAll() {
        dict.enumerated().forEach {
            $1.value?.prev = nil
            $1.value?.next = nil
        }
        list = DoubleLinkedList<T>()
        dict = [:]
        count = 0
    }
    
    // MARK: - Helpers
    private func moveNodeToTop(_ node: DoubleListNode<T>?) {
        // It's already on top of the list.
        if node === list.head { return }
        
        if node === list.tail {
            list.tail = node?.prev
            list.tail?.next = nil
        } else {
            // Rejoin it's previous and next nodes.
            node?.prev?.next = node?.next
            node?.next?.prev = node?.prev
        }
        
        // Move the new node to the front of the list.
        list.head?.prev = node
        node?.next = list.head
        node?.prev = nil
        list.head = node
    }
}

extension LRUCache: CustomStringConvertible {
    public var description: String {
        var values = [String]()
        var t: DoubleListNode? = list.head
        while t != nil {
            values.append("\(t!.value)")
            t = t?.next
        }
        return values.joined(separator: " <-> ")
    }
}

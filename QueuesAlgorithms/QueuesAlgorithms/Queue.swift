//
//  Queue.swift
//  QueuesAlgorithms
//
//  Created by Jozeee on 1/20/20.
//  Copyright © 2020 AdaloveSoftware. All rights reserved.
//

import Foundation

/// The Qeueue uses a linked link for optimization purposes.
class Queue<Element> {
    fileprivate var list: SingleLinkedList<Element> = SingleLinkedList<Element>()
    
    var isEmpty: Bool {
        return list.isEmpty
    }
    
    var count: Int {
        return list.count
    }
    
    /// Appends a new element at the end of the list.
    func enqueue(_ val: Element) {
        list.append(value: val)
    }
    
    /// Removes the first element from the list.
    func dequeue() -> Element? {
        guard !list.isEmpty, let val = list.first else { return nil }
        list.removeNodeAt(index: 0)
        return val.value
    }
    
    /// Looks at the first object in the list.
    func peek() -> Element? {
        return list.first?.value
    }
}

extension Queue: CustomStringConvertible {
    var description: String {
        return "Front -> " + list.description
    }
}

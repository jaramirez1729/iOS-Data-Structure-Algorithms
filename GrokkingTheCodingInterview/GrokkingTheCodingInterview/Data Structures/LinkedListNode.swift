//
//  LinkedListNode.swift
//  GrokkingTheCodingInterview
//
//  Created by J.A. Ramirez on 2/16/22.
//

import Foundation

class LinkedList<T: Comparable> {
    
    var value: T
    var next: LinkedList<T>?
    
    init(_ value: T, next: LinkedList<T>? = nil) {
        self.value = value
        self.next = next
    }
}

extension LinkedList: CustomStringConvertible {
    var description: String {
        var pointer: LinkedList<T>? = self
        var values = [T]()
        while pointer != nil {
            values.append(pointer!.value)
            pointer = pointer?.next
        }
        return values.map{"\($0)"}.joined(separator: " -> ")
    }
}

//
//  Stack.swift
//  StackAlgorithms
//
//  Created by Jozeee on 1/19/20.
//  Copyright © 2020 AdaloveSoftware. All rights reserved.
//

import Foundation

struct Stack<Element> {
    fileprivate var elements: [Element] = []
    
    var isEmpty: Bool {
        return elements.isEmpty
    }
    
    var count: Int {
        return elements.count
    }
    
    /// Adds a new element on top of the stack.
    mutating func push(_ element: Element) {
        elements.append(element)
    }
    
    /// Returns back and removes the top most element from the stack.
    mutating func pop() -> Element? {
        return elements.popLast()
    }
    
    /// Returns back the value of the top most element but does NOT remove it from the stack.
    func peek() -> Element? {
        return elements.last
    }
}

extension Stack: CustomStringConvertible {
    var description: String {
        let topDivider = "---Stack---\n"
        let bottomDivider = "\n-----------\n"
        let stackElements = elements.map({ "\($0)" }).reversed().joined(separator: "\n")
        return topDivider + stackElements + bottomDivider
    }
}

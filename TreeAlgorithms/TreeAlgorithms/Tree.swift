//
//  Tree.swift
//  TreeAlgorithms
//
//  Created by Jozeee on 1/23/20.
//  Copyright © 2020 AdaloveSoftware. All rights reserved.
//

import Foundation

class BinaryNode<T> {
    weak var parent: BinaryNode<T>?
    var val: T
    var left: BinaryNode<T>?
    var right: BinaryNode<T>?
    
    init(value: T) {
        self.val = value
    }
    
    func addLeftChild(_ child: BinaryNode<T>?) {
        left = child
        left?.parent = self
    }
    
    func addRightChild(_ child: BinaryNode<T>?) {
        right = child
        right?.parent = self
    }
}

extension BinaryNode: CustomStringConvertible {
    var description: String {
        var text = "\(val)"
        let leaves = [left, right]
        // The call to description causes the recursion of each node.
        text += " {" + leaves.compactMap({$0}).map { $0.description }.joined(separator: ", ") + "}"
          return text
    }
}

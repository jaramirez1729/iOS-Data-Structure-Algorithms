//
//  TreeNode.swift
//  TreesAlgorithms
//
//  Created by J.A. Ramirez on 12/9/21.
//

import Foundation
import UIKit

public class TreeNode {
    
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    
    public init() { self.val = 0; self.left = nil; self.right = nil; }
    public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
    public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
        self.val = val
        self.left = left
        self.right = right
    }
    
    public func print() -> [Int?] { 
        let strList = description.trimmingCharacters(in: .whitespaces)
        let list = strList.components(separatedBy: " ")
        let nums = list.map { Int($0) ?? nil }
        return nums
    }
}

extension TreeNode: CustomStringConvertible {
    public var description: String {
        let left = self.left?.description ?? ""
        let str = "\(self.val) "
        let right = self.right?.description ?? ""
        return left + str + right
    }
}

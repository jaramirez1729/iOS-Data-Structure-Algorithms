//
//  ListNode.swift
//  DesignPatterns
//
//  Created by J.A. Ramirez on 3/6/22.
//

import Foundation

public class ListNode {
    
    public var val: Int
    public var next: ListNode?
    
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

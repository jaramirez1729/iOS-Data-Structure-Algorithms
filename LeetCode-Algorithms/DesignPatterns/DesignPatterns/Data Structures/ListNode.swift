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

extension ListNode: CustomStringConvertible {
    public var description: String {
        var travNode: ListNode? = self
        var values = [String]()
        while travNode != nil {
            values.append(String(travNode!.val))                
            travNode = travNode!.next
        }
        values.append("nil")
        return values.joined(separator: " -> ")
    }
}

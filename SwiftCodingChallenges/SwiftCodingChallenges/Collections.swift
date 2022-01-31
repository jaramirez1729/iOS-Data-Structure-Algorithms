//
//  Collections.swift
//  SwiftCodingChallenges
//
//  Created by Jozeee on 2/20/20.
//  Copyright © 2020 AdaloveSoftware. All rights reserved.
//

import Foundation

// MARK: - Problem #37
// Write an extension on a list of integers where it counts the number of times a number appears.
extension Collection where Iterator.Element == Int {
    func count(_ num: Int) -> Int {
        // Create a long string of all of the numbers, and filter and count that match the number.
        return self.map({ String($0) }).joined().filter({ String($0) == String(num) }).count
    }
}


// MARK: - Problem #38
// Write an extension on a list that returns the N smallest elements as an array, sorted.
extension Collection where Iterator.Element: Comparable {
    func smallestElements(upTo count: Int) -> [Iterator.Element] {
        //return Array(ArraySlice(self.sorted()[0..<Swift.min(count, self.count)]))
        return Array(self.sorted().prefix(count))
    }
}


// MARK: Problem #39
// Create an extension that returns an array of strings sorted by their lengths, longest first.
extension Collection where Iterator.Element == String {
    func sortedByLength() -> [String] {
        return self.sorted(by: { $0.count > $1.count })
    }
}


// MARK: - Problem #40
// Create a method that accepts an unsorted list from 1 to 100 with some numbers missing.
// Return a list of the numbers that are missing.
func findMissingNumbers(in nums: [Int]) -> [Int] {
    let inputSet: Set<Int> = Set(nums)
    let testSet: Set<Int> = Set(1...100)
    return Array(testSet.subtracting(inputSet))
}


// MARK: - Problem #41
// Write an extension on collection that accepts an array of integers and returns the median average
// or nil if there are no values.
extension Collection where Iterator.Element == Int {
    func getMedianAverage() -> Double? {
        guard self.count > 0 else { return nil }
        
        let sorted: [Int] = self.sorted()
        let middle: Int = self.count / 2
        
        if self.count % 2 != 0 {
            return Double(sorted[middle])
        } else {
            let lhs: Double = Double(sorted[middle])
            let rhs: Double = Double(sorted[(middle) - 1])
            return (lhs + rhs) / 2.0
        }
    }
}


// MARK: - Problem #42
// Write an extension on a collection that implements the index(of:) method.
// index(of:) returns the index of the first instance that matches the element; otherwise return nil.
extension Collection where Iterator.Element: Equatable {
    func indexOfElement(_ element: Iterator.Element) -> Int? {
        for (index, item) in self.enumerated() {
            if item == element {
                return index
            }
        }
        return nil
    }
}


// MARK: - Problem #43
// Create a method that creates the alphabet using a linked list, and then traverse it.
class LinkedListNode<T> {
    var value: T
    var next: LinkedListNode<T>?
    
    init(value: T) {
        self.value = value
    }
}

class LinkedList<T>: CustomStringConvertible {
    var head: LinkedListNode<T>?
    
    var description: String {
        var str: String = ""
        var tNode: LinkedListNode<T>? = head
        while tNode != nil {
            if let val = tNode?.value {
                str += "\(val) "
                tNode = tNode?.next
            }
        }
        return str
    }
    
    static func createList(_ elements: T...) -> LinkedList<T> {
        var head: LinkedListNode<T>?
        var tNode: LinkedListNode<T>?
        
        for element in elements {
            if head == nil {
                head = LinkedListNode<T>(value: element)
                tNode = head
            } else {
                let node = LinkedListNode<T>(value: element)
                tNode?.next = node
                tNode = tNode?.next
            }
        }
        
        let newList = LinkedList<T>()
        newList.head = head
        return newList
    }
}

func createAlphabetLinkedList() -> LinkedListNode<Character>? {
    var head: LinkedListNode<Character>?
    var tNode = head
    
    for letter in "abcdefghijklmnopqrstuvwxyz" {
        let next = LinkedListNode<Character>(value: letter)
        if head == nil { head = next }
        tNode?.next = next
        tNode = next
    }
    return head
}

func traverseList(_ head: LinkedListNode<Character>?) {
    var tNode: LinkedListNode? = head
    while tNode != nil {
        if let val = tNode?.value {
            print(val, terminator: " ")
        }
        tNode = tNode?.next
    }
}


// MARK: - Problem #44
// Extend the linked list class with a new method that returns the node at the mid point of the
// linked list using no more than one loop.
// LISTEN; EXAMPLE: [1, 2, 3a, 4, 5, 6b]
// BRUTE FORCE: Loop through the list once, and keep a total count of how many nodes.
//              Divide it by 2, and loop again until that index is reached.
// OPTIMIZE (BUD): Bottlenecks? Looping once to then loop again halfway.
//                 Unnecessary work? Running 2 loops. Can it be done with one?
//                 Duplicate work? Running 2 loops.
//                 Loop once while keeping 2 reference pointers. The first pointer will move
//                 by one, and the 2nd one moves by 2. The 2nd pointer starts 1 ahead of the first.
//                 After the loop is done, the first pointer will point to the midpoint.
// WALKTHROUGH; IMPLEMENT; TEST
// Time O(n); Space O(1)
extension LinkedList {
    func midpoint() -> LinkedListNode<T>? {
        var first: LinkedListNode? = head
        var second: LinkedListNode? = first?.next
        
        while second?.next != nil {
            first = first?.next
            second = second?.next?.next
        }
        
        return first
    }
}


// MARK: - Problem #45 (Requires #54)


// MARK: - Problem #46
// Write an extension on collection that recreates the map() method.
extension Collection {
    // The closure marked as throws means that it can throw, but it doesn't have to.
    // The Rethrows means that it needs to be used with a try/catch only if the closure throws.
    func assign<T>(_ transform: (Iterator.Element) throws -> T) rethrows -> [T] {
        var returnValue: [T] = []
        for item in self {
            returnValue.append(try transform(item))
        }
        return returnValue
    }
}


// MARK: - Problem #47
// Add an extension that recreates the min() method.
extension Collection where Iterator.Element: Comparable {
    func smallestNaive() -> Iterator.Element? {
        // Using iterator prevents the first value from reading twice.
        var iterator = makeIterator()

        guard var lowest = iterator.next() else { return nil }

        while let item = iterator.next() {
            if item < lowest {
                lowest = item
            }
        }

        return lowest
    }
    
    func smallestReduce() -> Iterator.Element? {
        guard let lowest = self.first else { return nil }
        return reduce(lowest) { $1 < $0 ? $1 : $0 }
    }
    
    func smallestSequence() -> Iterator.Element? {
        var iterator = makeIterator()
        guard let lowest = iterator.next() else { return nil }
        return IteratorSequence(iterator).reduce(lowest) { $1 < $0 ? $1 : $0 }
    }
    
    func smallest() -> Iterator.Element? {
        return self.sorted().first
    }
}


// MARK: - Problem #48
// Implement a deque data structure.
// Create a data type that models a double-ended queue using generics.
struct Deque<T>: CustomStringConvertible {
    private var list: [T] = []
    
    var description: String {
        return "\(list)"
    }
    
    var count: Int {
        return list.count
    }
    
    mutating func pushFront(_ item: T) {
        list.insert(item, at: 0)
    }
    
    mutating func pushBack(_ item: T) {
        list.append(item)
    }
    
    mutating func popFront() -> T? {
        if list.isEmpty {
            return nil
        }
        return list.removeFirst()
    }
    
    mutating func popBack() -> T? {
        return list.popLast()
    }
}


// MARK: - Problem #49
// Write a function that accepts a variadic array of integers and returns the sum of all
// numbers that appear an even number of times.
func addEvenRepeats(_ numbers: Int...) -> Int {
    var total: Int = 0
    var dict: [Int: Int] = [:]
    // Can also use NSCountedSet which keeps a count like this.
    numbers.forEach({ dict[$0, default: 0] += 1 })
    for (_, item) in dict.enumerated() {
        if item.value % 2 == 0 {
            total += item.key
        }
    }
    return total
}


// MARK: - Problem #50
// Write a method that returns a range of the positions that sum to the highest value.
// It should accept an array of positive or negative numbers.
// LISTEN; EXAMPLE: [0, 1, 1, -1, 2, 3, 1]
// BRUTE FORCE: Loop through the list and store the indexes as keys; set the total for those
//              values as the value for the key. Ignore any value <= 0. Then return the indexes
//              (key) that has the smallest value.
// OPTIMIZE(Bottlenecks? Unnecessary work? Duplicate work?):
// WALKTHROUGH; IMPLEMENT; TEST
func largestRange(in list: [Int]) -> CountableClosedRange<Int>? {
    
    var bestRange: CountableClosedRange<Int>? = nil
    var bestSum: Int = 0
    var currentStart: Int? = nil
    var currentSum: Int = 0
    
    for (index, number) in list.enumerated() {
        if number > 0 {
            currentStart = currentStart ?? index
            currentSum += number
            
            if currentSum > bestSum {
                bestRange = currentStart!...index
                bestSum = currentSum
            }
        } else {
            currentSum = 0
            currentStart = nil
        }
    }
    
    return bestRange
}


// MARK: - Problem #51
// Add an extension to LinkedListNode and add a method that reverses the list.
// EXAMPLE: a -> b -> c -> d -> nil; d -> c -> b -> a -> nil
// BRUTE FORCE; OPTIMIZE (BUD): Keep a reference to the current node that we are traversing through.
// Also keep a reference to the next node.
// current = d, next = nil, newNode = c
// Set current.next to newNode; set newNode to current; set current to next; set next to next.next
extension LinkedList {
    func reversed() -> LinkedList {
        // Need to create a copy because directly reversing would change the current object.
        let copy = self.copy()
        copy.reverse()
        return copy
    }
    
    func copy() -> LinkedList<T> {
        let copy = LinkedList<T>()
        if let val = head?.value {
            copy.head = LinkedListNode<T>(value: val)
        }
        
        var copyTNode: LinkedListNode? = copy.head
        var tNode: LinkedListNode? = head?.next
        
        while tNode != nil {
            let newNode: LinkedListNode = LinkedListNode(value: tNode!.value)
            copyTNode?.next = newNode
            copyTNode = copyTNode?.next
            tNode = tNode!.next
        }
        
        return copy
    }
    
    private func reverse() {
        var current = head
        var next: LinkedListNode<T>? = head?.next
        var newNode: LinkedListNode<T>? = nil
        
        while let node = current {
            node.next = newNode
            newNode = current
            current = next
            next = next?.next
        }
        
        head = newNode
     }
}


// MARK: - Problem #52
// Write a method that sums all array of numbers.
func sumOfNumbers<T: Numeric>(numbers: [T]) -> T {
    return numbers.reduce(0, +)
}


// MARK: - Problem #53
// Create a method that returns back the node that is looped back into it from a linked list.
// LISTEN; EXAMPLE 1 -> 2 -> 3 -> 4 -> 5 -> 4
func startingLoopNode<T>(in list: LinkedList<T>) -> LinkedListNode<T>? {
    // Uses Clyde's Cycle Finding Algorithm
    var slow: LinkedListNode<T>? = list.head
    var fast: LinkedListNode<T>? = list.head
    
    while fast != nil && fast?.next != nil {
        slow = slow?.next
        fast = fast?.next?.next
        
        if slow === fast {
            break
        }
    }
    
    guard fast != nil || fast?.next != nil else { return nil }
    
    slow = list.head
    
    while slow! !== fast! {
        slow = slow?.next
        fast = fast?.next
    }
    
    return slow
}


// MARK: - Problem #54
// Create a binary search tree that can be initialized from an unordered array of comparable values.
class Node<T> {
    var key: T
    var left: Node<T>?
    var right: Node<T>?
    
    init(key: T) {
        self.key = key
    }
}

class BinarySearchTree<T: Comparable>: CustomStringConvertible {
    var root: Node<T>?
    
    init(array: [T]) {
        for item in array {
            // Flag to know if a node was created for this item.
            var placed = false
            
            if let rootNode = root {
                var tracker = rootNode
                
                while !placed {
                    if item <= tracker.key {
                        if tracker.left == nil {
                            tracker.left = Node(key: item)
                            placed = true
                        }
                        tracker = tracker.left!
                        
                    } else {
                        if tracker.right == nil {
                            tracker.right = Node(key: item)
                            placed = true
                        }
                        tracker = tracker.right!
                    }
                }
            } else {
                root = Node(key: item)
            }
        }
    }
    
    func isBalanced() -> Bool {
        func minDepth(from node: Node<T>?) -> Int {
            guard let node = node else { return 0 }
            let returnValue = 1 + min(minDepth(from: node.left), minDepth(from: node.right))
            return returnValue
        }
        
        func maxDepth(from node: Node<T>?) -> Int {
            guard let node = node else { return 0 }
            let returnValue = 1 + max(maxDepth(from: node.left), maxDepth(from: node.right))
            return returnValue
        }
        
        guard let root = root else { return true }
        
        let difference = maxDepth(from: root) - minDepth(from: root)
        return difference <= 1
    }

    var description: String {
        guard let first = root else { return "" }
        var queue = [Node<T>]()
        queue.append(first)
        var output = ""
        while queue.count > 0 {
            var nodesAtCurrentLevel = queue.count
            while nodesAtCurrentLevel > 0 {
                let node = queue.removeFirst()
                output += "\(node.key)"
                
                if node.left != nil { queue.append(node.left!) }
                if node.right != nil { queue.append(node.right!) }
                
                nodesAtCurrentLevel -= 1
            }
            output += "\n"
        }
        return output
    }
}

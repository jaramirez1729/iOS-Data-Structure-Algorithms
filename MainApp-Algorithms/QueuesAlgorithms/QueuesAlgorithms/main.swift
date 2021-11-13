//
//  main.swift
//  QueuesAlgorithms
//
//  Created by Jozeee on 1/20/20.
//  Copyright © 2020 AdaloveSoftware. All rights reserved.
//

import Foundation

// Used to measure the time it takes for an algorithm to run.
struct Time {
    func measure(_ block: () -> Void) {
        let date = Date()
        block()
        print("\(date.timeIntervalSinceNow * -1) seconds passed.")
    }
}


/*
 Queue Questions
 Implement a stack using a queue.
 Reverse first k elements of a queue.
 Generate binary numbers from 1 to n using a queue.
 */


// MARK: -
// Implement a stack using a queue.
// Listen: A queue is FIFO, and a stack is LIFO.
// Example using 2 queues: tempList -> []; list -> []
struct Stack<T> {
    private var tempList: Queue<T> = Queue<T>()
    private var list: Queue<T> = Queue<T>()
    
    private(set) var count: Int = 0
    
    var isEmpty: Bool {
        return list.isEmpty
    }
    
    mutating func push(_ val: T) {
        // Move all the elements from the list to the temporary one.
        while !list.isEmpty {
            if let element = list.dequeue() {
                tempList.enqueue(element)
            }
        }
        
        count += 1
        // Add the new value at the beginning of the stack.
        list.enqueue(val)
        
        // Add back all of the values from the temp list back to the list.
        while !tempList.isEmpty {
            if let element = tempList.dequeue() {
                list.enqueue(element)
            }
        }
    }
    
    mutating func pop() -> T? {
        count -= 1
        return list.dequeue()
    }
}

extension Stack: CustomStringConvertible {
    var description: String {
        return list.description
    }
}


// MARK: -
// Reverse first k elements of a queue.
// LISTEN; EXAMPLE: Front -> [1, 2, 3, 4, 5] k = 3, so new queue is [3, 2, 1, 4, 5]
// BRUTE: If the list is not empty, pop k number of elements into a stack.
// The pop the remaining into a queue to maintain their positions.
// Pop from the stack back into the queue, and then dequeue back the remaining to the queue.
// OPTIMIZE: Bottlenecks? Dequeueing k elements to a stack.
//           Unnecessary Work? Having to dequeue remaining into another queue.
// WALKTHROUGH: Q [1, 2, 3, 4, 5] k = 3; S [1, 2, 3]; Q2 [4, 5]; Q [3, 2, 1, 4, 5]
// IMPLEMENT; TEST
// Time O(k + n): where k is the number of elements to reverse and n is the size of the list.
// Space O(n): Size grows in relation to the size of the list.
func reverseElements(upTo k: Int, from queue: inout Queue<Int>) {
    var tempStack = Stack<Int>()
    
    // Move up to k into the stack; they are reversed automatically when popping.
    for _ in 1...k { // O(k) times.
        if let val = queue.dequeue() {
            tempStack.push(val)
        }
    }
    
    // Get back all of the values in reverse from the stack.
    while !tempStack.isEmpty { // O(k) times since k elements were moved to the stack.
        if let val = tempStack.pop() {
            queue.enqueue(val)
        }
    }
    
    // The remaining elements of the queue at the front need to go back to the end.
    let maxRange: Int = (queue.count <= k) ? k : (queue.count - k)
    for _ in 1...maxRange { // O(n - k) for n is the size of the list.
        if let val = queue.dequeue() {
            queue.enqueue(val)
        }
    }
}

//var queue: Queue = Queue<Int>()
//queue.enqueue([1, 2, 3, 4, 5])
//reverseElements(upTo: 3, from: &queue)
//print(queue)

// MARK: -
// Generate binary numbers from 1 to n using a queue.
// LISTEN
// EXAMPLE so if it was 1 to 11, generate 1, 10, 11, 100, 101, 110, 111, 1000, 1001, 1010, 1011
// Odd: Have a 1 at the end.
// Even: Have a 0 at the end.
// BRUTE: Enqueue 1 to the queue. Pop the last result and calculate the next 2 numbers and enqueu back.
// Use an array to store the already calculated values.
// BUD; WALKTHROUGH; IMPLEMENT; TEST
// Time O(n): Linear, loop n times.
// Space O(n): Grows in relation to the number of numbers to generate.
func generateBinaryNumbers(upTo n: Int) -> [Int] {
    let queue = Queue<Int>()
    var results: [Int] = []
    
    queue.enqueue(1)
    for _ in 1...n {
        if let val = queue.dequeue() {
            // Store the next number into the results.s
            results.append(val)
            
            // Calculate the next 2 numbers using that first prefix value.
            if let eNum = Int("\(val)0"), let oNum = Int("\(val)1") {
                queue.enqueue(eNum)
                queue.enqueue(oNum)
            }
        }
    }
    return results
}


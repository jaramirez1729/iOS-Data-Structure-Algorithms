//
//  Algorithms.swift
//  SwiftCodingChallenges
//
//  Created by Jozeee on 3/1/20.
//  Copyright © 2020 AdaloveSoftware. All rights reserved.
//

import Foundation

// MARK: - Problem #55
// Create an extension on arrays that implements the bubble sort algorithm.
// A bubble sort loops an array and compares items that are next to each other and swapping them if they
// are not sorted.
extension Array where Iterator.Element: Comparable {
    func bubbleSort() -> [Element] {
        guard self.count > 1 else { return self }
        var arr = self
        
        // We can remove the flag for swapping by recording the last highest index the swap
        // occurred at becuase that element will not be swapped anymore, so it saves time on the loop.
        var highestSortedI: Int = count
//        var didSwap: Bool = true
        
        repeat {
//            didSwap = false
            var lastSwapI = 0
            
            for i in 0..<highestSortedI - 1 {
                if arr[i] > arr[i + 1] {
//                    didSwap = true
                    arr.swapAt(i, i + 1)
                    lastSwapI = i + 1
                }
            }
            highestSortedI = lastSwapI
//            if !didSwap {
//                break
//            }
        } while highestSortedI != 0
        
        return arr
    }
}


// MARK: - Problem #56
// Create an extension that sorts using the insertion sort algorithm.
// LISTEN; EXAMPLE [2, 3, 1, 5, 7, 8, 4]
// BRUTE FORCE; OPTIMIZE (BUD): Loop the array. The current element is placed into a new array.
// The new element will be checked against every element in the new array and added where it belongs.
// WALKTHROUGH: [2, 3, 1, 5, 7, 8, 4]; IMPLEMENT; TEST
extension Array where Iterator.Element: Comparable {
    func insertionSort() -> [Element] {
        guard self.count > 1 else { return self }
        var sorted: [Element] = []
        
        for item in self {
            sorted.append(item)
            var i: Int = sorted.count - 1
            while i > 0 {
                if sorted[i] < sorted[i - 1] {
                    sorted.swapAt(i, i - 1)
                    i -= 1
                } else {
                    break
                }
            }
        }
        
        return sorted
    }
}


// MARK: Problem #57
// Write a method that checks if 2 values are isomorphic: that is, they map to each other precisely.
// LISTEN; EXAMPLE "TORT" "PUMP"
// BRUTE FORCE: Create a dictionary that makes a character mapping from one word to another.
// [T: P, O: U, R: M]; If the key exists, check that the character in value 2 matches what is already
// in the dictionary, if it doesn't, then it's not an isomorphism.
func isIsomorphic(val1: Any, val2: Any) -> Bool {
    let str1: [Character] = String(describing: val1).map({ Character(String($0)) })
    let str2: [Character] = String(describing: val2).map({ Character(String($0)) })
    
    guard str1.count == str2.count else { return false }
    
    var dict: [Character: Character] = [:]
    
    for i in 0..<str1.count {
        if dict[str1[i]] == nil {
            if dict.values.contains(str2[i]) {
                return false
            }
            dict[str1[i]] = str2[i]
        }
    }
    
    return true
}


// MARK: - Problem #58
// Write a method that checks if brackets are balanced and closed.
// LISTEN; EXAMPLE: "([])(<{}>)"
// BRUTE FORCE: Loop through the string. If it's an opening brace, push to the stack.
// If it's a closing brace, read top of stack and check if it can close the bracket.
func balancedBrackets(in str: String) -> Bool {
    let validSet = CharacterSet(charactersIn: "({[<>]})").inverted
    guard str.rangeOfCharacter(from: validSet) == nil else { return false }
    
    let brackets: [Character: Character] = ["(": ")", "{": "}", "<": ">", "[": "]"]
    var stack: [Character] = []
    
    for char: Character in Array(str) {
        if brackets.keys.contains(char) {
            stack.append(char)
        } else {
            if let openingChar = stack.popLast(), let closingChar = brackets[openingChar] {
                if closingChar != char {
                    return false
                }
            }
        }
    }
    
    return stack.isEmpty
}


// MARK: - Problem #59
// Create an extension that implements the quicksort algorithm.
// LISTEN; EXAMPLE: [1, 3, 5, 2, 6]
extension Array where Iterator.Element: Comparable {
    func quicksort() -> [Element] {
        let sorted = self
        return partition(sorted)
    }
    
    private func partition(_ list: [Element]) -> [Element] {
        guard list.count > 1 else{ return list }
        let pivot: Int = (count - 1) / 2
        var leftList = partition(Array(list[0...pivot]))
        let rightList = partition(Array(list[pivot + 1...count - 1]))
        return sort(&leftList, rightList)
    }
    
    private func sort(_ left: inout [Element], _ right: [Element]) -> [Element] {
        for element in right {
            left.append(element)
            var i: Int = left.count - 1
            while i > 0 {
                if left[i] < left[i - 1] {
                    left.swapAt(i, i - 1)
                    i -= 1
                } else {
                    break
                }
            }
        }
        
        return left
    }
    
    //
    func quicksortAnswer() -> [Element] {
        guard count > 1 else { return self }
        let pivot = self[count / 2]
        let before = filter({ $0 < pivot })
        let after = filter({ $0 > pivot })
        let equal = filter({ $0 == pivot })
        return before.quicksortAnswer() + equal + after.quicksortAnswer()
    }
}


// MARK: - Problem #60
// Create a method that checks if a tic-tac-toe game has been won.
// LISTEN; EXAMPLE: [["X", "", "O"], ["", "X", "O"], ["", "", "X"]]
// BRUTE FORCE: Check if any of the 3 inner arrays has the same element 3 times, then that's a win across.
//
func didWinTicTacToe(_ board: [[String]]) -> Bool {
    guard board.count == 3 else { return false }
    
    for i in 0..<board.count {
        // Check each row.
        if Array(repeating: "X", count: 3) == board[i] || Array(repeating: "O", count: 3) == board[i] {
            return true
        }
        
        // Check each column.
        if !board[0][i].isEmpty && board[0][i] == board[1][i] && board[1][i] == board[2][i] {
            return true
        }
        
    }
    
    // Check diagonal. [0][0] [1][1] [2][2] OR [0][] [1][] [2][]
    if (!board[0][0].isEmpty && board[0][0] == board[1][1] && board[1][1] == board[2][2])
        || (!board[0][2].isEmpty && board[0][2] == board[1][1] && board[1][1] == board[2][0]) {
        return true
    }
    
    return false
}


// MARK: - Problem #61
// Write a method that returns an array of prime numbers, effeciently.
func primeNumbers(upTo max: Int) -> [Int] {
    guard max > 1 else { return [] }
    
    var sieve = [Bool](repeating: true, count: max)
    sieve[0] = false
    sieve[1] = false
    
    for number in 2..<max {
        if sieve[number] {
            // stride helps in removing multiples of the number.
            for multiple in stride(from: number * number, to: sieve.count, by: number) {
                sieve[multiple] = false
            }
        }
    }

    // $0 represents the index, and $1 represents the item in that position.
    return sieve.enumerated().compactMap({ $1 == true ? $0 : nil })
}


// MARK: - Problem #62
func pointToAngles(points: [(first: CGPoint, second: CGPoint)]) -> [CGFloat] {
    return points.map {
        // atan2 calculates the angle between 2 points.
        let radians = atan2($0.first.y - $0.second.y, $0.first.x - $0.second.x)
        var degrees = (radians * 180 / CGFloat.pi) - 90
        if (degrees < 0) { degrees += 360.0 }
        if degrees == 360 { degrees = 0 }
        return degrees
    }
}


// MARK: - Problem #63


// MARK: - Problem #64

//
//  main.swift
//  SwiftCodingChallenges
//
//  Created by Jozeee on 2/7/20.
//  Copyright © 2020 AdaloveSoftware. All rights reserved.
//

import Foundation

// MARK: - Problem #16
// Write a method that counts from 1 to 100, and prints "Fizz" if the number is evenly
// divisible by 3, and "Buzz" if it's evenly divisible by 5, and "Fizz Buzz" if it's evenly
// divisble by 3 and 5. Print the number for all other cases.
func fizzBuzz() {
    for i in 1...100 {
        if i % 3 == 0 && i % 5 == 0 {
            print("Fizz Buzz")
        } else if i % 3 == 0 {
            print("Fizz")
        } else if i % 5 == 0 {
            print("Buzz")
        } else {
            print(i)
        }
    }
}


// MARK: - Problem #17
// Return a random number between a given bound.
// Time O(1); Space O(1)
func randomNumber(from min: Int, to max: Int) -> Int {
    // Because it generates random numbers from 0 to the upper bound, we need
    // to add the min at the end to increase its lower bound. It excludes the upperbound
    // so we need to increase it by 1 to include it.
    return Int(arc4random_uniform(UInt32(max - min + 1))) + min
}


// MARK: - Problem #18
// Create the pow() function.
// Time O(n); Space O(1)
func power(of num: Int, to exp: Int) -> Int {
    guard num >= 0 else { return 0 }
    if exp == 0 { return 1 }
    
    var total: Int = num
    for _ in 1..<exp {
        total *= num
    }
    return total
}


// MARK: - Problem #19
// Swap 2 integers without using a temporary integer.
// Time O(1); Space O(1)
func swapNums(a: inout Int, b: inout Int) {
    a = a + b
    b = a - b
    a = a - b
}


// MARK: - Problem #20
// Check if a number is prime.
// Time O(n); Space O(1)
func isPrime(_ num: Int) -> Bool {
    guard num >= 2 else { return false }
    guard num != 2 else { return true }
    let max = Int(ceil(sqrt(Double(num))))
    
    for i in 2...max {
        if num % i == 0 {
            return false
        }
    }
    
    return true
}


// MARK: - Problem #21
// Create a method that accepts a positive integer and returns back the next higheset and lowest
// nmber that has the same number of 1s as its binary representation.
// Time O(n), Space O(1)
func getMaxMinInBinary(from num: Int) -> (max: Int?, min: Int?) {
    var answer: (max: Int?, min: Int?)
    let numOfOnes: Int = String(num, radix: 2).filter({ $0 == "1" }).count

    for i in (0..<num).reversed() {
        let ones = String(i, radix: 2).filter({ $0 == "1" }).count
        if ones == numOfOnes {
            answer.min = i
            break
        }
    }
    
    for i in num + 1...Int.max {
        let ones = String(i, radix: 2).filter({ $0 == "1" }).count
        if ones == numOfOnes {
            answer.max = i
            break
        }
    }
    
    return answer
}


// MARK: - Problem #22
// Accept an unsigned 8-bit integer and return its binary reverse including padding to
// make it have 8 binary digits.
// Time O(n), Space(1)
func reverseBinary(_ num: UInt) -> Int {
    let numBinary: String = String(num, radix: 2)
    let numBinaryPadded: String = String(repeating: "0", count: 8 - numBinary.count) + numBinary
    let revBinaryStr: String = String(numBinaryPadded.reversed())
    
    if let revNum = Int(revBinaryStr, radix: 2) {
        return revNum
    }
    return 0
}


// MARK: - Problem #23
// Return true if the given string only contains digits from 0 to 9, otherwise return false.
func isNumbersOnly(_ str: String) -> Bool {
    return str.rangeOfCharacter(from: CharacterSet(charactersIn: "0123456789").inverted) == nil
}


// MARK: - Problem #24
// Given a string that contains both letters and numbers, return back the total sum
// of all the numbers found in the string.
func getTotalFromString(_ str: String) -> Int {
    var total: Int = 0
    var numStr: String = ""
    
    for char in str.map({ String($0) }) {
        if Int(char) != nil {
            numStr += char
        } else {
            total += Int(numStr) ?? 0
            numStr = ""
        }
    }
    
    if !numStr.isEmpty, let num = Int(numStr) {
        total += num
    }

    return total
}

func getTotalFromStringRegex(_ str: String) -> Int {
    do {
        // A capture group with 1 or more digits. We don't want to match the letter d,
        // so we escape it. And we have to escape that one as the string requires it.
        let regex = try? NSRegularExpression(pattern: "(\\d+)", options: [])
        
        // Returns back an array of every value that matched the regex.
        let matches = regex?.matches(in: str, options: [],
                                    range: NSRange(location: 0, length: str.utf16.count))
        
        // Get every number match from the string that matches those found in the regex.
        let allNumbers: [Int] = matches?.compactMap({ Int((str as NSString).substring(with: $0.range)) }) ?? []
        return allNumbers.reduce(0, +)
    }
}


// MARK: - Problem #25
// Write a method that calculates the square root of a positive integer, rounded down to the
// nearest integer without using sqrt().
func squareRoot(_ num: UInt) -> Int {
    return Int(floor(pow(Double(num), 0.5)))
}


// MARK: - Problem #26
// Create a function that subtracts without using the subtraction operator.
func subtract(_ num1: Int, from num2: Int) -> Int {
    // return num2 + (-num1)
    // Using bitwise NOT ~ will invert it, and turn it into (-X - 1)
    return num2 + (~num1 + 1)
}

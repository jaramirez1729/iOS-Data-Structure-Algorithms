//
//  Strings.swift
//  SwiftCodingChallenges
//
//  Created by Jozeee on 2/17/20.
//  Copyright © 2020 AdaloveSoftware. All rights reserved.
//

import Foundation

// MARK: - Problem #1
// Check if a string contains duplicates.
// Time O(n); Space O(1)
func isStringUnique(_ str: String) -> Bool {
    // Sets remove duplicate values since they can't have them. Just check that after duplicate removal, if they have the same count.
    return str.count == Set(str).count
}

// MARK: - Problem #2
// Check if a string is a palindrome.
// Time O(1); Space O(1)
func isPalindrome(_ str: String) -> Bool {
    let lowercase = str.lowercased()
    return lowercase == String(lowercase.reversed())
}

func isPalindromeNoReverse(_ str: String) -> Bool {
    guard str.count > 0 else { return false }
    let string = str.lowercased()
    let array = Array(string)
    
    var startIndex = 0
    var endIndex = string.count - 1
    
    while startIndex < endIndex {
        if array[startIndex] != array[endIndex] {
            return false
        }
        startIndex += 1
        endIndex -= 1
    }
    return true
}


// MARK: - Problem #3
// Check if 2 strings contain the same characters regardless of order.
// Time O(n); Space O(n)
func doContainSameCharacter(_ str1: String, str2: String) -> Bool {
    var dict1: [String: Int] = [:]
    var dict2: [String: Int] = [:]
    str1.forEach({ dict1[String($0), default: 0] += 1})
    str2.forEach({ dict2[String($0), default: 0] += 1})
    return dict1 == dict2
}


// Time O(n log n); Space O(1)
func doContainSameCharacterAnswer(_ str1: String, str2: String) -> Bool {
    return str1.sorted() == str2.sorted()
}

// MARK: - Problem #4
// Write your own version of the contains() method.
extension String {
    // Cases are ignored.
    func doesContain(_ str: String) -> Bool {
        return range(of: str, options: .caseInsensitive) != nil
    }
}


// MARK: - Problem #5
// Count the number of times a specific character appears.
func countInstancesOfCharacter(_ char: Character, in str: String) -> Int {
    var count: Int = 0
    str.forEach({ count += ($0 == char ? 1 : 0) })
    return count
}


// MARK: - Problem #6
// Print the input string with duplicates removed except the first instance of it.
// If the key is NOT in the dictionary, it will update it and then return nil. So for every first occurence of that character (key), it will assign it true and return nil. Since it's a filter, the next time it encounters a duplicate character, it will just ignore it because updateValue won't return nil.
func removeDuplicateLetters(from str: String) -> String {
    var dict: [Character: Bool] = [:]
    let result = str.filter { dict.updateValue(true, forKey: $0) == nil }
    return result
}


// MARK: - Problem #7
// Condense consecutive spaces into a single space.
// Time O(1); Space O(1)
func condenseSpaces(_ str: String) -> String {
    // + is 1 or more.
    return str.replacingOccurrences(of: " +", with: " ", options: .regularExpression, range: nil)
}


// MARK: - Problem #8
// Check if a string is a rotation of another one.
func isRotation(_ str: String, rotation: String) -> Bool {
    return str.count == rotation.count && "\(str)\(str)".contains(rotation)
}


// MARK: - Problem #9
// Check if a string is a pangram: has every letter of the alphabet at least once.
// Time O(n); Space O(1)
func isPangram(_ str: String) -> Bool {
    for char in "abcdefghijklmnopqrstuvwxyz" {
        if !str.lowercased().contains(String(char)) {
            return false
        }
    }
    return true
}

func isPangramAnswer(_ str: String) -> Bool {
    let set = Set(str.lowercased())
    let letters = set.filter({ $0 >= "a" && $0 <= "z" })
    return letters.count == 26
}


// MARK: - Problem #10
// Given a string, return a tuple containing the number of vowels and consonants.
// Time: O(n); Space O(1)
func vowelsAndConsonants(in str: String) -> (vowels: Int, consonants: Int) {
    var ans: (vowels: Int, consonants: Int) = (vowels: 0, consonants: 0)
    
    for char in str.lowercased() {
        if "aeiou".contains(char) {
            ans.vowels += 1
        } else if "bcdfghjklmnpqrstvwxyz".contains(char) {
            ans.consonants += 1
        }
    }
    
    return ans
}


// MARK: - Problem #11
// Check if 2 strings are identical in length and have no more than 3 different characters, taking
// case and order into account.
// Time O(n); Space: O(n)
func differByThree(_ str1: String, str2: String) -> Bool {
    guard str1.count == str2.count else { return false }
    let str1Arr: [String] = str1.map({ String($0) })
    let str2Arr: [String] = str2.map({ String($0) })
    
    var diffCount: Int = 0
    
    for i in 0..<str1Arr.count {
        if str1Arr[i] != str2Arr[i] {
            if (diffCount + 1) == 4 {
                return false
            }
            diffCount += 1
        }
    }
    return true
}


// MARK: - Problem #12
// Return the longest substring found in the list of words that they all contain.
// Time O(n^2); Space O(n)
func longestPrefixSubstring(in str: String) -> String {
    let words: [String] = str.components(separatedBy: " ")
    guard let firstWord = words.first else { return "" }
    
    var longestPrefix: String = ""
    var prefix: String = ""
    
    outerLoop: for char in firstWord {
        prefix += String(char)
        for i in 1..<words.count {
            if !words[i].hasPrefix(prefix) {
                return longestPrefix
            }
        }
        longestPrefix = prefix
    }
    
    return longestPrefix
}


// MARK: - Problem #13
// Write a function that accepts a string as input, then returns how often each letter is
// repeated in a single run, taking case into account.
// Time: O(n); Space O(1)
func runLengthEncoding(_ str: String) -> String {
    guard !str.isEmpty else { return "" }
    
    var ans: String = ""
    var charCounter: Int = 0
    let characters: [String] = str.map({ String($0) })
    
    for i in 0..<characters.count {
        charCounter += 1
        if i + 1 == characters.count || characters[i] != characters[i + 1] {
            ans += "\(characters[i])\(charCounter)"
            charCounter = 0
        }
    }
    
    return ans
}


// MARK: - Problem #14
// Write a function that prints all possible permutations of a given string.
// Time O(); Space O()
func printPermutations(of str: String) {
    permutations(of: str, maxSize: str.count)
}

func permutations(of str: String, current: String = "", maxSize: Int) {
    let length: Int = str.count
    let strArr: [String] = str.map({ String($0) })
    
    if length == 0 {
        // There's nothing left to re-arrange, so print the result.
        if current.count == maxSize { print(current) }
    } else {
        if current.count == maxSize { print(current) }
        for i in 0..<length {
            // Get the letters before current index
            let left: String = strArr[0..<i].joined()
            // Get the letters after the current index
            let right: String = strArr[i + 1..<length].joined()
            
            // Combine them and carry on.
            permutations(of: left + right, current: current + strArr[i], maxSize: maxSize)
        }
    }
}
 

// MARK: - Problem #15
// Without using a loop, return back a string of the words reversed from the input string.
// Time O(n); Space O(n)
func reverseWords(in str: String) -> String {
    let words = str.split(separator: " ").map({ String($0.reversed()) })
    return words.joined(separator: " ")
}

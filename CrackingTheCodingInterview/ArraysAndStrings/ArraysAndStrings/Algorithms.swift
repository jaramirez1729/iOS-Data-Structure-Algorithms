//
//  Algorithms.swift
//  ArraysAndStrings
//
//  Created by J.A. Ramirez on 11/27/21.
//

import Foundation

// MARK: - Is Unique
/*
 Implement an algorithm to determine if a string has all unique characters. What if you cannot use additional data structures?
 */
// Approach #1: Convert the string into a set, and then check the set's count if it matches the strings count. If it does not match, then the characters are not unique. Time O(n), Space O(n)
func isUnique(_ str: String) -> Bool {
    return Set(str).count == str.count
}

// Approach #2: Save every character into a dictionary as a key and the number of times it repeats as the value. Return false if any value is greater than 2. Time O(n), Space O(n)
//func isUnique(_ str: String) -> Bool {
//    var chars: [Character: Int] = [:]
//    for (_, char) in str.enumerated() {
//        chars[char, default: 0] += 1  
//        // There is no need to keep going if we find a duplicate.
//        if let val = chars[char], val > 1 { return false }
//    }
//    return true
//}

// MARK: - Check Permutation
/*
 Check Permutation: Given two strings, write a method to decide if one is a permutation of the other.
 */
// Approach #1 (Book Solution #2): Store the main string into a dictionary. Loop through the other string. Everytime we find a character, we substract 1 value from the dictionary. If the loop ends successfully, it's a valid permutation.
// Time O(n), Space O(n)
func checkPermutation(_ permutation: String, in string: String) -> Bool {
    guard permutation.count == string.count else { return false }
    
    var strDict: [Character: Int] = [:]
    string.enumerated().forEach { strDict[$1, default: 0] += 1 } // Time O(n), Space O(n)
    
    for (_, char) in permutation.enumerated() { // Time O(n)
        if let count = strDict[char] {
            // If removing 1 will be 0, no need to set it. Just remove the character and keep going.
            if count - 1 == 0 { 
                strDict[char] = nil
                continue
            }
            strDict[char] = count - 1
        } else {
            // If we don't find the character, then it's not a permutation already.
            return false           
        }
    }
    return true
}

// Book Solution #1: Sort both strings and check if they are equal to each other.
// Don't be afraid to use built-in functions since they are compiled and improve the speed.
// Although this is slower.
// Time O(n log n), Space O(n)
func checkPermutationSolution(_ permutation: String, in string: String) -> Bool {
    let sortedPermutation = permutation.sorted().map { String($0) } // O(n log n)
    let sortedString = string.sorted().map { String($0) } // O(n log n)
    return sortedPermutation == sortedString
}

// MARK: - URLify
/*
 URLify: Write a method to replace all spaces in a string with '%20'. You may assume that the string has sufficient space at the end to hold the additional characters,and that you are given the "true" length of the string. (Note: If implementing in Java, please use a character array so that you can perform this operation in place.)
 
 EXAMPLE
 Input: "Mr John Smith ", 13 Output: "Mr%20John%20Smith"
 */
// Aproach #1: Built-in functions.
func urlify1(_ str: String) -> String {
    return str.trimmingCharacters(in: .whitespaces).replacingOccurrences(of: " ", with: "%20")
}

// Approach #2: Without built-in functions.
func urlify(_ str: String) -> String {
    let trimmedStr = str.trimmingCharacters(in: .whitespaces)
    var urlStr = ""
    trimmedStr.enumerated().forEach { urlStr += ($1 == " ") ? "%20" : String($1) }
    return urlStr
}

// MARK: - Palindrome Permutation
/*
 Given a string, write a function to check if it is a permutation of a palin­drome. A palindrome is a word or phrase that is the same forwards and backwards. A permutation is a rearrangement of letters. The palindrome does not need to be limited to just dictionary words.
 
 EXAMPLE
 Input: Tact Coa
 Output: True (permutations: "taco cat", "atco cta" etc.)
 */
// Listen: The space does matter to determine if it's a permutation. The space doesn't actually matter to determine if a string is a palindrome.

// Approach #1: Create all permutations of the given string with the space intact, and then determine if any of the permutations are palindromes.

// Approach #2: Instead of creating all permutations, we can figure out if we can even form a palindrome with the given string first. We need to see if a string follows the conditions to be a palindrome: if the size is 0 or 1, then return true. If the size is 2 or greater: every character must appear an even number of times, and only a single character can appear an odd number of times. If these conditions are not met, then the string cannot form a palindrome (regardless of spacing). We don't need to do anything else because we validated if it's a palindrome regardless of the character order, which means it's a permutation of a palindrome string.
func isPalindromePermutation(_ str: String) -> Bool {
    guard str.count > 1 else { return true }
    
    var chars: [Character: Int] = [:]
    
    str.trimmingCharacters(in: .whitespaces)
        .replacingOccurrences(of: " ", with: "")
        .lowercased()
        .enumerated().forEach { chars[$1, default: 0] += 1 }
    
    // Only a single character can appear an odd number of times.
    guard chars.values.filter({ $0 % 2 == 1 }).count <= 1 else { return false }
    
    return true
}

// The book solution #3 used a bit mask and checked its bits at the end.

// MARK: - One Way
/*
 There are three types of edits that can be performed on strings: insert a character, remove a character, or replace a character. Given two strings, write a function to check if they are one edit (or zero edits) away.
 */
// Approach #1: We can store both strings into a dictionary. We know if there is an insertion, removal, or replacement if the intersection of those dictionaries is greater than 1. If there is only 1 difference, we need to check that the count has only changed by 1 in case a similar character was added/removed.
// Time O(n + m + a), Space O(n + m)
func isEditedStringAwayFromString1(_ str: String, editedStr: String) -> Bool {
    var strChars: [Character: Int] = [:]
    str.enumerated().forEach { strChars[$1, default: 0] += 1 } // O(n)
    
    var editedStrChars: [Character: Int] = [:]
    editedStr.enumerated().forEach { editedStrChars[$1, default: 0] += 1 } // O(m)
    
    var intersection: [Character: Int] = [:]
    // We will traverse the dictionary that's greater.
    let isStrGreater = max(strChars.count, editedStrChars.count) == strChars.count
    let (minChars, maxChars) = isStrGreater ? (editedStrChars, strChars) : (strChars, editedStrChars)
    
    for (_, char) in maxChars.enumerated() { // Either O(n) or O(m)
        if minChars[char.key] == nil {
            // Include it as a difference if it does not exist.
            intersection[char.key] = char.value
            
        } else if let count = minChars[char.key], count != char.value {
            // Include it as a difference if it does exist but the count doesn't match.
            intersection[char.key] = max(count, char.value)
        }
    }
    
    // We need to check for only a single difference.
    guard intersection.count <= 1 else { return false }
    
    if let element = intersection.first, 
        let minCount = minChars[element.key], 
        let maxCount = maxChars[element.key] {
        if element.value - minCount > 1 || element.value - maxCount > 1 {
            return false
        }
    }
    
    return true
}

// Approach #2: We can try to check if one of the edits occurred. We can check if there was an insertion or deletion by comparing the size of the strings. If they are off by 2, then there was more than 1 edit and we can return false. Next, we check if there was a replaced character by comparing the differences.
func isEditedStringAwayFromString(_ str: String, editedStr: String) -> Bool {
    let charsDiff = abs(str.count - editedStr.count)
    // First check for an insertion or removal by comparing the size of the strings.
    guard charsDiff < 2 else { return false } 

    // Starting the differences at negative allows us to offset the differences between the sizes so that it doesn't count it.
    var diffs = charsDiff * -1
    // Then, check if there was a replacement by looping the string that has the most characters 
    // and count their differences in characters.
    let highestStrCount = max(str.count, editedStr.count)
    let (maxStr, minStr) = (highestStrCount == str.count) ? (str, editedStr) : (editedStr, str)
    
    // Will loop through the large string and compare each character to find if there are any differences.
    for (index, char) in maxStr.enumerated() {
        // A string index can be used to access a string at a specific position.
        let charIndex = minStr.index(minStr.startIndex, offsetBy: index)
        if minStr.indices.contains(charIndex), minStr[charIndex] != char {
            diffs += 1
        }        
    }
    return diffs <= 1
}

// MARK: - String Compression
/*
 Implement a method to perform basic string compression using the counts of repeated characters. For example, the string aabcccccaaa would become a2b1c5a3. If the "compressed" string would not become smaller than the original string, your method should return the original string. You can assume the string has only uppercase and lowercase letters (a - z).
 */
// Brute: Loop through the string. If the current character does not exist in the dictionary, add it and set its count to 1 and also append the new string with the current character. If the current character does exist in the dictionary, increase its count by 1. Look ahead if the next character is different, and if it is, get the count for that character and append it into the new string.
// Time O(n), Space O(n)
func compressString(_ str: String) -> String {
    // If the compressed string would become greater than the input, then return the string.
    if Set(Array(str)).count * 2 > str.count {
        return str
    }
    
    var compressedStr = ""
    var chars: [Character: Int] = [:]
    
    for (index, char) in str.enumerated() {
        let nextIndex = str.index(str.startIndex, offsetBy: index + 1)
        
        if let count = chars[char] {
            chars[char] = count + 1
            if str.indices.contains(nextIndex), str[nextIndex] != char {
                compressedStr += "\(count + 1)"
                // Reset it for next time if the value appears again.
                chars[char] = nil
            } else if index == str.count - 1 {
                compressedStr += "\(count + 1)"
            }
            
        } else {
            compressedStr += String(char)
            if str.indices.contains(nextIndex), str[nextIndex] != char {
                compressedStr += "\(1)"
            }  else if index == str.count - 1 {
                compressedStr += "\(1)"
            } else {                
                chars[char] = 1
            }
        }
    }
    
    return compressedStr
}

// MARK: - Rotate Matrix
/*
 Given an image represented by an NxN matrix, where each pixel in the image is 4 bytes, write a method to rotate the image by 90 degrees. Can you do this in place?
 */
// Rotation by 90 degrees can be easily achieved by first rotating on the diagonal and then on its vertical.
// [1, 2, 3] -> [1, 4, 7] -> [7, 4, 1]
// [4, 5, 6] -> [2, 5, 8] -> [8, 5, 2]
// [7, 8, 9] -> [3, 6, 9] -> [9, 6, 3]
// Diagonal Rotation: (0, 0) -> (0, 0); (0, 1) -> (1, 0); (0, 2) -> (2, 0)
// Vertical Rotation: (0, 0) -> (0, 2); (1, 0) -> (1, 2); (2, 0) -> (2, 2)
func rotateMatrix(_ matrix: inout [[Int]]) {
    // First, we have to rotate it on its diagonal.
    for row in 0..<matrix.endIndex { // O(n)
        // Start at row because if we start at 0, we undue a previous swap eventually.
        for column in row..<matrix.endIndex {
            let temp = matrix[row][column]
            matrix[row][column] = matrix[column][row]
            matrix[column][row] = temp
        }
    }
    
    // Then, we rotate it vertically.
    for row in 0..<matrix.endIndex { // O(n)
        // We only need to go through half of the columns to prevent undoing a previous swap.
        for column in 0..<matrix.endIndex / 2 {
            let temp = matrix[row][column]
            let endIndex = (matrix.endIndex - 1) - column
            matrix[row][column] = matrix[row][endIndex]
            matrix[row][endIndex] = temp
        }
    }
}

// MARK: - Zero Matrix
/*
 Write an algorithm such that if an element in an MxN matrix is 0, its entire row and column are set to 0.
 */
// Approach #1: Loop through the matrix and if we find a 0, set its column and rows to 0. This is not efficient because a loop occurs inside the outer loop, and thus has worst runtime.
// Time O(MN(N+M)), Space O(MN)
func zeroMatrix1(_ matrix: [[Int]]) -> [[Int]] {
    var mMatrix = matrix
    
    for row in 0..<matrix.endIndex { // O(M)
        for column in 0..<matrix[row].endIndex { // O(N)
            if matrix[row][column] == 0 {
                // Set the entire row to zeros.
                mMatrix[row] = matrix[row].map { _ in 0 } // O(N)
                // Loop through each row and only set the column to 0.
                for subRow in 0..<matrix.endIndex { // O(M)
                    mMatrix[subRow][column] = 0
                }
            }
        }
    }
    return mMatrix
}

// Approach #2: We can keep a dictionary to store the positions that have a 0 so we can change them later instead of the inner-most loop.
// We can make the changes after the loops to improve the runtime. Time O(MN + Z(MN)) = Time O(n+zn)
func zeroMatrix(_ matrix: inout [[Int]]) -> [[Int]] {
    // Store the indexes with zeros to change after.
    var indexes: [(row: Int, column: Int)] = []
    for row in 0..<matrix.endIndex { // O(M)
        for column in 0..<matrix[row].endIndex { // O(N)
            if matrix[row][column] == 0 {
                indexes.append((row, column))
            }
        }
    }
    
    for index in indexes { // O(Z)
        // Set the entire row to zeros.
        matrix[index.row] = Array(repeating: 0, count: matrix.first?.count ?? 0) // O(N)
        // Loop through each row and only set the column to 0.
        for subRow in 0..<matrix.endIndex { // O(M)
            matrix[subRow][index.column] = 0
        }
    }
    
    return matrix
}

// MARK: - String Rotation
/*
 Assume you have a method isSubstring which checks if one word is a substring of another. Given two strings, s1 and s2, write code to check if s2 is a rotation of s1 using only one call to isSubstring (e.g.,"waterbottle" is a rotation of"erbottlewat").
 */
// Approach #1: Rotate the main string by a character to the right and then check if it equals the rotated string, if not rotate it again. Stop until it has rotated the same number of times as it has characters.

// Approach #2: Get the index in the rotated string of each character that matches the starting letter of the main string. Only rotate by those times where the indexes are found. After rotation, check if the string is equal to the rotation, and if it does, return true - else return false.
// Time O(M + NT); Space O(N)
func isStringRotation1(_ str: String, rotation: String) -> Bool {
    guard str.count == rotation.count else { return false }
    
    var firstCharIndexes = [Int]()
    if let firstChar = str.first {
        rotation.enumerated().forEach { // O(M)
            if $1 == firstChar {
                firstCharIndexes.append($0)
            }
        }
    }
    
    for index in firstCharIndexes { // O(N)
        var rotateStr = str
        rotateString(&rotateStr, times: index) // O(T)
        if rotateStr == rotation {
            return true
        }
    }
    
    return false
}

// Rotates a string to the right by the number of times given: hello -> ohell
func rotateString(_ str: inout String, times: Int) {
    guard times > 0 else { return }
    
    var strList: [String] = Array(str).map { String($0) }
    for _ in 1...times {
        if let char = strList.popLast() {
            strList.insert(char, at: 0)
        }
    }
    str = strList.joined()
}

// Book solution #1: Instead of rotating the string, we can just append the string at the end of itself.
// If the rotation is a substring of that, then it's a rotation.
// Time O(N)/O(1)? Space O(N)
func isStringRotation(_ str: String, rotation: String) -> Bool {
    guard str.count == rotation.count else { return false }
//    return (str + str).contains(rotation)
    return (str + str).range(of: rotation) != nil
}

// MARK: - Minimum Swaps for String A to String B
/*
 Given string A and string B, return back the minimum amount of swaps required to turn string A into string B.
 */
// LEBOWITS
// Listen: They will always have the same size.
//          Assume that it's always possible to make string A to string B.
//
// Example: A: acb; B: abc - a[c][b] => abc; 1 swap
// Example: A: holel, hello - h[o]l[e]l => hel[o][l] => hello; 2 swaps
// 
// Special Case Example: A: eohll ,hello - [e]o[h]ll => h[o][e]ll => he[o]ll ? Do you swap to first l or last l?
// Before swapping, we can check if both letters will end up in correct positions. If not, then continue checking the word for the
// next letter we're looking for, and then see if that swap will be optimal. If it is, swap it. If not, then swap with first one.
// 
// Brute: Create a single loop that checks the position of string A and string B. Compare a[i] with b[j] and if a[i] does not match, then
// we know we need to swap it. Have another loop that goes thorugh string A to find the character we are looking for (which matches b[j]) and record that position. We can check that if we swap if both will end up in their final positions. If not, keep going down A and check again the swap if we find another b[j] character. If none, then just swap with the first b[j] found. 
// 
// Optimize (BUD): We don't need to loop through every character. If we determine ahead of time what positions do not match, we can optimize the loop so ahead of time it will only check the positions that are incorrect. 
// 
// Consider: This does not necessarily guarantee the minimum swaps, but it's a heuristic approach for fastest way to make A to B. If we want accuracy, we can check every possibility and return back the smallest swap amount after recording each one.
// 
// Walkthrough: A = holel; B= hello; 
// 
//func minimumSwaps(for startStr: String, to endStr: String) -> Int {
//    // Special Case: What if startStr is just endStr backwards? O(1)
//    
//    // Determine which positions of the startStr don't match with the endStr.
//    var targetIndexes: [Int] = []
//    for (index, char) in startStr.enumerated() { // O(A)
//        // Check if the current character in startStr matches the one in the same position as endStr.
//        if char != endStr[endStr.index(endStr.startIndex, offsetBy: index)] {
//            targetIndexes.append(index)   
//        }
//    }
//    
//    var swaps: Int = 0
//    var mStartStr = Array(startStr)
//    print(String(mStartStr))
//    // Check only the positions that have mismatching characters.
//    for targetIndex in targetIndexes { // O(a), worst case O(A)
//        
//        // Get the character we want to look for to know what to swap with.
//        let targetEndChar = endStr[endStr.index(endStr.startIndex, offsetBy: targetIndex)]
//        if mStartStr[targetIndex] == targetEndChar { continue }
//        
//        var possibleSwapIndex: Int = 0
//        // Loop through the rest of startStr to find the target character, starting from the current invalid position.
//        for currentIndex in (targetIndex + 1)..<startStr.count {
//            if mStartStr[currentIndex] == targetEndChar {
//                possibleSwapIndex = currentIndex
//                break
//            }
//            // Check if it's optimal which means a swap puts both characters in their final position. Look into later.
//            
//        }
//        print("Swapping \(mStartStr[targetIndex]) with \(mStartStr[possibleSwapIndex]).")
//        mStartStr.swapAt(targetIndex, possibleSwapIndex)
//        print(String(mStartStr))
//        swaps += 1
//        // If it's equal after the swap, no need to keep looping.
//        if String(mStartStr) == endStr { break }
//    }
//    
//    return swaps
//}

// Count the number of characters that are in the wrong position and divide by 2. This is because the best swap possible will result in 2 characters put in their final position. We don't actually care to know how the swaps happen, just that how many there are.
//func minimumSwaps(for startStr: String, to endStr: String) -> Int {
//    var swaps: Int = 0
//    for (index, char) in startStr.enumerated() {
//        if char != endStr[endStr.index(endStr.startIndex, offsetBy: index)] {
//            swaps += 1
//        }
//    }
//    return swaps / 2
//}

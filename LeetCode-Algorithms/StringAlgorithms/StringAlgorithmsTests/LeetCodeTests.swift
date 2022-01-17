//
//  StringAlgorithmsTests.swift
//  StringAlgorithmsTests
//
//  Created by J.A. Ramirez on 11/20/21.
//

import XCTest
@testable import StringAlgorithms

// MARK: - Reverse String
class LeetCodeReverseStringTests: XCTestCase {
    func test1() {
        var  s: [Character] = ["h","e","l","l","o"]
        reverseString(&s)
        XCTAssertEqual(s, ["o","l","l","e","h"])
    }
    
    func test2() {
        var  s: [Character] = ["H","a","n","n","a","h"]
        reverseString(&s)
        XCTAssertEqual(s, ["h","a","n","n","a","H"])
    }
    
    func test3() {
        var s: [Character] = ["a"]
        reverseString(&s)
        XCTAssertEqual(s, ["a"])
    }
    
    func test4() {
        var s: [Character] = []
        reverseString(&s)
        XCTAssertEqual(s, [])
    }
    
    func test5() {
        var s: [Character] = ["a", "b"]
        reverseString(&s)
        XCTAssertEqual(s, ["b", "a"])
    }
}

// MARK: - Reverse Integer
class LeetCodeReverseTests: XCTestCase {
    func test1() {
        let x = 123
        let result = reverse(x)
        XCTAssertEqual(result, 321)
    }
    
    func test2() {
        let x = -123
        let result = reverse(x)
        XCTAssertEqual(result, -321)
    }
    
    func test3() {
        let x = 120
        let result = reverse(x)
        XCTAssertEqual(result, 21)
    }
    
    func test4() {
        let x = 0
        let result = reverse(x)
        XCTAssertEqual(result, 0)
    }
    
    func test5() {
        let x = Int(Int32.max)
        let result = reverse(x)
        XCTAssertEqual(result, 0)
    }
}

// MARK: - First Unique Character in a String
class LeetCodeFirstUniqCharTests: XCTestCase {
    func test1() {
        let s = "leetcode"
        let result = firstUniqChar(s)
        XCTAssertEqual(result, 0)
    }
    
    func test2() {
        let s = "loveleetcode"
        let result = firstUniqChar(s)
        XCTAssertEqual(result, 2)
    }
    
    func test3() {
        let s = "aabb"
        let result = firstUniqChar(s)
        XCTAssertEqual(result, -1)
    }
    
    func test4() {
        let s = "aabb"
        let result = firstUniqChar(s)
        XCTAssertEqual(result, -1)
    }
}

// MARK: - Valid Anagram
class LeetCodeIsAnagramTests: XCTestCase {
    func test1() {
        let s = "anagram"
        let t = "nagaram"
        let result = isAnagram(s, t)
        XCTAssertTrue(result)
    }
    
    func test2() {
        let s = "rat"
        let t = "car"
        let result = isAnagram(s, t)
        XCTAssertFalse(result)
    }
    
    func test3() {
        let s = "ab"
        let t = "a"
        let result = isAnagram(s, t)
        XCTAssertFalse(result)
    }
}

// MARK: Valid Palindrome
class LeetCodeIsPalindromeTests: XCTestCase {
    func test1() {
        let s = "A man, a plan, a canal: Panama"
        let result = isPalindrome(s)
        XCTAssertTrue(result)
    }
    
    func test2() {
        let s = "race a car"
        let result = isPalindrome(s)
        XCTAssertFalse(result)
    }
    
    func test3() {
        let s = " "
        let result = isPalindrome(s)
        XCTAssertTrue(result)
    }
    
    func test4() {
        let s = "aa"
        let result = isPalindrome(s)
        XCTAssertTrue(result)
    }
}

// MARK: - String to Integer (atoi)
class LeetCodeMyAtoiTests: XCTestCase {
    func test1() {
        let s = "    -42"
        let result = myAtoi(s)
        XCTAssertEqual(result, -42)
    }
    
    func test2() {
        let s = "   +42"
        let result = myAtoi(s)
        XCTAssertEqual(result, 42)
    }
    
    func test3() {
        let s = "42 with words"
        let result = myAtoi(s)
        XCTAssertEqual(result, 42)
    }
    
    func test4() {
        let s = "-91283472332"
        let result = myAtoi(s)
        XCTAssertEqual(result, -2147483648)
    }
    
    func test5() {
        let s = "91283472332"
        let result = myAtoi(s)
        XCTAssertEqual(result, 2147483647)
    }
    
    func test6() {
        let s = "21474836460"
        let result = myAtoi(s)
        XCTAssertEqual(result, 2147483647)
    }
    
    func test7() {
        let s = "20000000000000000000"
        let result = myAtoi(s)
        XCTAssertEqual(result, 2147483647)
    }
    
    func test8() {
        let s = "  0000000000012345678"
        let result = myAtoi(s)
        XCTAssertEqual(result, 12345678)
    }
    
    func test9() {
        let s = "words and 4345678"
        let result = myAtoi(s)
        XCTAssertEqual(result, 0)
    }
    
    func test10() {
        let s = "3.14"
        let result = myAtoi(s)
        XCTAssertEqual(result, 3)
    }
}

// MARK: - Implement strStr()
class LeetCodeStrStrTests: XCTestCase {
    func test1() {
        let haystack = "hello", needle = "ll"
        let result = strStr(haystack, needle)
        XCTAssertEqual(result, 2)
    }
    
    func test2() {
        let haystack = "aaaaa", needle = "bba"
        let result = strStr(haystack, needle)
        XCTAssertEqual(result, -1)
    }
    
    func test3() {
        let haystack = "", needle = ""
        let result = strStr(haystack, needle)
        XCTAssertEqual(result, 0)
    }
    
    func test4() {
        let haystack = "aaa", needle = "aaaa"
        let result = strStr(haystack, needle)
        XCTAssertEqual(result, -1)
    }
    
    func test5() {
        let haystack = "mississippi", needle = "issipi"
        let result = strStr(haystack, needle)
        XCTAssertEqual(result, -1)
    }
    
    func test6() {
        let haystack = "hellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohelhellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohelhellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohelhellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohelhellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohelhellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohelhellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohelheltailtailtailtailtailtailtailtaillohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohelhellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohelhellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohelhellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohelhellohellohellohellohellohellohellohellohellohellohtailtailtailtailtailtailtailtailellohellohellohellohellohellohelhellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohetailllohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohetailllohello" 
            let needle = "tailtailtailtailtailtailtailtail"
        let result = strStr(haystack, needle)
        XCTAssertEqual(result, 584)
    }
}

// MARK: - Longest Common Prefix
class LeetCodeLongestCommonPrefix: XCTestCase {
    func test1() {
        let list = ["flower", "flow", "flight"]
        let result = longestCommonPrefix(list)
        XCTAssertEqual(result, "fl")
    }
    
    func test2() {
        let list = ["dog", "racecar", "car"]
        let result = longestCommonPrefix(list)
        XCTAssertEqual(result, "")
    }
    
    func test3() {
        let list = ["flowerflowerasdfasdf", "flowerflower", "flowerflower"]
        let result = longestCommonPrefix(list)
        XCTAssertEqual(result, "flowerflower")
    }
    
    func test4() {
        let list: [String] = []
        let result = longestCommonPrefix(list)
        XCTAssertEqual(result, "")
    }
    
    func test5() {
        let list: [String] = [""]
        let result = longestCommonPrefix(list)
        XCTAssertEqual(result, "")
    }
    
    func test6() {
        let list: [String] = ["a", "a", "aabc", "aa", "acc"]
        let result = Solution().longestCommonPrefix(list)
        XCTAssertEqual(result, "a")
    }
}

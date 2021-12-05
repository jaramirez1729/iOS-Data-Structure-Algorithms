//
//  AlgorithmsTests.swift
//  ArraysAndStringsTests
//
//  Created by J.A. Ramirez on 11/27/21.
//

import XCTest
@testable import ArraysAndStrings

// MARK: - Is Unique
class IsUniqueTests: XCTestCase {
    func test1() {
        let str = "HelloWorld"
        let result = isUnique(str)
        XCTAssertFalse(result)
    }
    
    func test2() {
        let str = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let result = isUnique(str)
        XCTAssertTrue(result)
    }
    
    func test3() {
        let str = "helowrd"
        let result = isUnique(str)
        XCTAssertTrue(result)
    }
    
    func test4() {
        let str = "ab"
        let result = isUnique(str)
        XCTAssertTrue(result)
    }
    
    func test5() {
        let str = "b"
        let result = isUnique(str)
        XCTAssertTrue(result)
    }
    
    func test6() {
        let str = ""
        let result = isUnique(str)
        XCTAssertTrue(result)
    }
    
    func test7() {
        let str = "aaaaaaaaaaaaaa"
        let result = isUnique(str)
        XCTAssertFalse(result)
    }
}

// MARK: - Check Permutation
class CheckPermutationTests: XCTestCase {
    func test1() {
        let str = "abcdefg"
        let substring = "abcdgfe"
        let result = checkPermutation(substring, in: str)
        XCTAssertTrue(result)
    }
    
    func test2() {
        let str = "hello"
        let substring = "lloeh"
        let result = checkPermutation(substring, in: str)
        XCTAssertTrue(result)
    }
    
    func test3() {
        let str = "always"
        let substring = "yalaws"
        let result = checkPermutation(substring, in: str)
        XCTAssertTrue(result)
    }
    
    func test4() {
        let str = "always"
        let substring = "yalawss"
        let result = checkPermutation(substring, in: str)
        XCTAssertFalse(result)
    }
    
    func test5() {
        let str = "always"
        let substring = "yalaas"
        let result = checkPermutation(substring, in: str)
        XCTAssertFalse(result)
    }
    
    func test6() {
        let str = "Hello World!"
        let substring = "dlorW !llHoe"
        let result = checkPermutation(substring, in: str)
        XCTAssertTrue(result)
    }
    
    func test7() {
        let str = "Okay"
        let substring = "Okaa"
        let result = checkPermutation(substring, in: str)
        XCTAssertFalse(result)
    }
    
    func test8() {
        let str = "cakecake"
        let substring = "ccaakkee"
        let result = checkPermutation(substring, in: str)
        XCTAssertTrue(result)
    }
    
    func test9() {
        let str = "cakecakee"
        let substring = "ccaaakkee"
        let result = checkPermutation(substring, in: str)
        XCTAssertFalse(result)
    }
    
    // Should this be false?
    func test10() {
        let str = "atco cta"
        let substring = "tacocat "
        let result = checkPermutation(substring, in: str)
        XCTAssertTrue(result)
    }
}

// MARK: - URLify
class URLifyTests: XCTestCase {
    func test1() {
        let str = "Mr. John Smith"
        let result = urlify(str)
        XCTAssertEqual(result, "Mr.%20John%20Smith")
    }
    
    func test2() {
        let str = "Hello World !    "
        let result = urlify(str)
        XCTAssertEqual(result, "Hello%20World%20!")
    }
    
    func test3() {
        let str = "     Hello World !    "
        let result = urlify(str)
        XCTAssertEqual(result, "Hello%20World%20!")
    }
}

// MARK: - Palindrome Permutation
class PalindromePermutationTests: XCTestCase {
    func test1() {
        let str = "Tact Coa"
        let result = isPalindromePermutation(str)
        XCTAssertTrue(result)
    }
    
    func test2() {
        let str = "abcdabc" // abcdcba
        let result = isPalindromePermutation(str)
        XCTAssertTrue(result)
    }
    
    func test3() {
        let str = "looooXl" // looXool
        let result = isPalindromePermutation(str)
        XCTAssertTrue(result)
    }
}

// MARK: - One Way
class OneWayTests: XCTestCase {
    func test1() {
        let result = isEditedStringAwayFromString("pale", editedStr: "paale")
        XCTAssertTrue(result)
    }
    
    func test2() {
        let result = isEditedStringAwayFromString("pales", editedStr: "pale")
        XCTAssertTrue(result)
    }
    
    func test3() {
        let result = isEditedStringAwayFromString("pale", editedStr: "bake")
        XCTAssertFalse(result)
    }
    
    func test4() {
        let result = isEditedStringAwayFromString("pale", editedStr: "bale")
        XCTAssertTrue(result)
    }
    
    func test5() {
        let result = isEditedStringAwayFromString("pale", editedStr: "paleee")
        XCTAssertFalse(result)
    }
    
    func test6() {
        let result = isEditedStringAwayFromString("pale", editedStr: "palee")
        XCTAssertTrue(result)
    }
    
    func test7() {
        let result = isEditedStringAwayFromString("paleee", editedStr: "pale")
        XCTAssertFalse(result)
    }
    
    func test8() {
        let result = isEditedStringAwayFromString("bake", editedStr: "bke")
        XCTAssertTrue(result)
    }
    
    func test9() {
        let result = isEditedStringAwayFromString("bake", editedStr: "k")
        XCTAssertFalse(result)
    }
    
    func test10() {
        let result = isEditedStringAwayFromString("bake", editedStr: "bke")
        XCTAssertTrue(result)
    }
    
    func test12() {
        let result = isEditedStringAwayFromString("pale", editedStr: "bake")
        XCTAssertFalse(result)
    }
    
    func test13() {
        let result = isEditedStringAwayFromString("hello", editedStr: "halle")
        XCTAssertFalse(result)
    }
}

// MARK: - String Compression
class StringCompressionTests: XCTestCase {
    func test1() {
        let str = "aabcccccaaa"
        let result = compressString(str)
        XCTAssertEqual(result, "a2b1c5a3")
    }
    
    func test2() {
        let str = "abc"
        let result = compressString(str)
        XCTAssertEqual(result, "abc")
    }
    
    func test3() {
        let str = "aaaaabbbbcccdde"
        let result = compressString(str)
        XCTAssertEqual(result, "a5b4c3d2e1")
    }
    
    func test4() {
        let str = "aaaaaaaaaabbbbbcd"
        let result = compressString(str)
        XCTAssertEqual(result, "a10b5c1d1")
    }
}

// MARK: - Rotate Matrix
class RotateMatrixTests: XCTestCase {
    func test1() {
        // [1, 2, 3] -> [7, 4, 1]
        // [4, 5, 6] -> [8, 5, 2]
        // [7, 8, 9] -> [9, 6, 3]
        var matrix = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
        rotateMatrix(&matrix)
        XCTAssertEqual(matrix, [[7, 4, 1], [8, 5, 2], [9, 6, 3]])
    }
    
    func test2() {
        var matrix = [[1, 2, 3, 0], [4, 5, 6, 0], [7, 8, 9, 0], [10, 11, 12, 0]]
        rotateMatrix(&matrix)
        XCTAssertEqual(matrix, [[10, 7, 4, 1], [11, 8, 5, 2], [12, 9, 6, 3], [0, 0, 0, 0]])
    }
    
    func test3() {
        // [1, 2] -> [3, 1]
        // [3, 4] -> [4, 2]
        var matrix = [[1, 2], [3, 4]]
        rotateMatrix(&matrix)
        XCTAssertEqual(matrix, [[3, 1], [4, 2]])
    }
    
    func test4() {
        var matrix = [[1]]
        rotateMatrix(&matrix)
        XCTAssertEqual(matrix, [[1]])
    }
    
    func test5() {
        var matrix = [[Int]]()
        rotateMatrix(&matrix)
        XCTAssertEqual(matrix, [])
    }
}

// MARK: - Zero Matrix
class ZeroMatrixTests: XCTestCase {
    func test1() {
        var matrix = [[1, 0, 3], [4, 5, 6]]
        let result = zeroMatrix(&matrix)
        XCTAssertEqual(result, [[0, 0, 0], [4, 0, 6]])
    }
    
    func test2() {
        var matrix = [[1, 2, 3], [4, 5, 0]]
        let result = zeroMatrix(&matrix)
        XCTAssertEqual(result, [[1, 2, 0], [0, 0, 0]])
    }
    
    func test3() {
        var matrix = [[0, 2, 3]]
        let result = zeroMatrix(&matrix)
        XCTAssertEqual(result, [[0, 0, 0]])
    }
    
    func test4() {
        var matrix = [[2, 3]]
        let result = zeroMatrix(&matrix)
        XCTAssertEqual(result, [[2, 3]])
    }
    
    func test5() {
        var matrix = [[1, 2, 3], [4, 0, 6], [7, 8, 9]]
        let result = zeroMatrix(&matrix)
        XCTAssertEqual(result, [[1, 0, 3], [0, 0, 0], [7, 0, 9]])
    }
    
    func test6() {
        var matrix = [[1, 2, 3], [4, 0, 6], [7, 8, 0]]
        let result = zeroMatrix(&matrix)
        XCTAssertEqual(result, [[1, 0, 0], [0, 0, 0], [0, 0, 0]])
    }
}

// MARK: - String Rotation
class StringRotationTests: XCTestCase {
    func test1() {
        let result = isStringRotation("waterbottle", rotation: "erbottlewat")
        XCTAssertTrue(result)
    }
    
    func test2() {
        let result = isStringRotation("waterwater", rotation: "aterwaterw")
        XCTAssertTrue(result)
    }
    
    func test3() {
        let result = isStringRotation("waterwater", rotation: "aterwawerw")
        XCTAssertFalse(result)
    }
    
    func test4() {
        let result = isStringRotation("we", rotation: "ew")
        XCTAssertTrue(result)
    }
    
    func test5() {
        let result = isStringRotation("helloworldisthefirst", rotation: "orldisthefirsthellow")
        XCTAssertTrue(result)
    }
}

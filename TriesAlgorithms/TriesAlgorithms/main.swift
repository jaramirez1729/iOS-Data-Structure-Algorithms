//
//  main.swift
//  TriesAlgorithms
//
//  Created by Jozeee on 2/1/20.
//  Copyright © 2020 AdaloveSoftware. All rights reserved.
//

import Foundation

/*
 Trie Questions
 Count total number of words.
 Print all words stored.
 Build a T9 dictionary. Return all words that have a given prefix.
 */


// MARK: -
// Count total number of words in a trie.
// LISTEN; EXAMPLE: cool, am, so, cute, hello, world, hell, cut, hella
// BRUTE FORCE?: Start at the root. Loop through the children of that node. Then continue
// to traverse into those children's children. If the current node is terminating, increase
// the counter. Then continue until there is no more children. Then repeat for the next key.
// OPTIMIZE (Bottlenecks? Unnecessary Code? Duplicate Work?)
// WALKTHROUGH:                      Root             Words: 9
//                        [ c    a  s     h     w ]
//                         o u   m. o.    e     o
//                         o t.           l     r
//                         l. e.          l.    l
//                                       o.a.   d.
//
func countWords(in trie: Trie) -> Int { // Driver function
    var numOfWords: Int = 0
    traverseNode(trie.root, count: &numOfWords)
    return numOfWords
}

private func traverseNode<T>(_ node: TrieNode<T>, count: inout Int) {
    if node.isTerminating {
        count += 1
    }
    for (_, item) in node.children.enumerated() {
        traverseNode(item.value, count: &count)
    }
}


// MARK: -
// Print all words stored.
// LISTEN; EXAMPLE: cool, am, so, cute, hello, world, hell, cut, hella
// WALKTHROUGH:                      Root
//                        [ c    a  s     h     w ]
//                         o u   m. o.    e     o
//                         o t.           l     r
//                         l. e.          l.    l
//                                       o.a.   d.
// BRUTE?: Use recursion in order to loop each dictionarie's children. Append each
// node's value into a string. When the terminating flag is found, print the value.
// At the end of the recursion, pop the last letter since it will go back up the call stack.
func printWords(in trie: Trie) {
    var word: String = ""
    traverseNode(trie.root, word: &word)
}

private func traverseNode<T>(_ node: TrieNode<T>, word: inout String) {
    if let char = node.value {
        word += "\(char)"
    }
    if node.isTerminating {
        print(word)
    }
    for (_, item) in node.children.enumerated() {
        traverseNode(item.value, word: &word)
    }
    // Pop the last letter because it's going back up where the recursion came from.
    _ = word.popLast()
}


// MARK: -
// Build a T9 dictionary. Return all words that have a given prefix.
// LISTEN; EXAMPLE; BRUTE: Traverse into the prefix first. After the prefix has been passed,
// print every word that is found after.
func printWordsWithPrefix(_ prefix: String, in trie: Trie) {
    guard !prefix.isEmpty else { return }
    let characters: [Character] = Trie().getCharacters(for: prefix)
    var index: Int = 0
    var tNode: TrieNode = trie.root
    
    // Traverse inside until the prefix is reached. We don't want to print any words found before it.
    while index < characters.count, let node = tNode.children[characters[index]] {
        tNode = node
        index += 1
    }
    
    // tNode should now be the last letter of the prefix. Check if the prefix makes a word.
    if tNode.isTerminating {
        print(prefix)
    }
    
    // Check if the children of the last letter of the prefix make words.
    for (_, item) in tNode.children.enumerated() {
        var word = prefix
        wordsWithPrefixInNode(item.value, word: &word)
    }
}

private func wordsWithPrefixInNode<Character>(_ node: TrieNode<Character>, word: inout String) {
    if let value = node.value {
        word += "\(value)"
    }
    if node.isTerminating {
        print(word)
    }
    for (_, item) in node.children.enumerated() {
        wordsWithPrefixInNode(item.value, word: &word)
    }
    
    // At this point, it is going back up to enumerate the next element of the branch.
    _ = word.popLast()
}

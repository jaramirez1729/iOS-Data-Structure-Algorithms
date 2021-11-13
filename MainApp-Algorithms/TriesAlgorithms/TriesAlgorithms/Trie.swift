//
//  Trie.swift
//  TriesAlgorithms
//
//  Created by Jozeee on 2/1/20.
//  Copyright © 2020 AdaloveSoftware. All rights reserved.
//

import Foundation

// Must conform to Hashable so the generic element can be used as a dictionary key.
class TrieNode<T: Hashable> {
    var value: T?
    weak var parent: TrieNode?
    var children: [T: TrieNode] = [:]
    /// A flag that ensures if this node's value is the end of a word.
    var isTerminating: Bool = false
    
    init(value: T? = nil, parent: TrieNode? = nil) {
        self.value = value
        self.parent = parent
    }
    
    func add(child: T) {
        guard children[child] == nil else { return }
        children[child] = TrieNode(value: child, parent: self)
    }
}

extension TrieNode: CustomStringConvertible {
    var description: String {
        var str: String = ""
        for (_, item) in children.enumerated() {
            str += "\(item.key) \(getKeys(for: item.value))\n"
        }
        return str
    }
    
    private func getKeys(for item: TrieNode) -> String {
        var str: String = ""
        for (_, item) in item.children.enumerated() {
            str += "\(item.key) \(getKeys(for: item.value))"
        }
        return str
    }
}

struct Trie {
    typealias Node = TrieNode<Character>
    private(set) var root: TrieNode<Character>
    
    init() {
        root = Node()
    }
    
    func insert(word: String) {
        guard !word.isEmpty else { return }
        
        var currentNode: Node = root
        let characters = getCharacters(for: word)
        var currentIndex: Int = 0
        
        while currentIndex < characters.count {
            // Get the next character from the string
            let character = characters[currentIndex]
            if let child = currentNode.children[character] {
                // If the letter already exists, then traverse into it.
                currentNode = child
            } else {
                // If it does not exist, add the letter.
                currentNode.add(child: character)
                // move the current node to the new reference
                if let newNode = currentNode.children[character] {
                    currentNode = newNode
                }
            }
            
            currentIndex += 1
        }
        
        if currentIndex == characters.count {
            currentNode.isTerminating = true
        }
    }
    
    func contains(word: String) -> Bool {
        guard !word.isEmpty else { return false }
        var currentNode = root
        
        let characters: [Character] = getCharacters(for: word)
        var currentIndex: Int = 0
        
        // Get the character from the children that matches the next letter in the string.
        while currentIndex < characters.count, let child = currentNode.children[characters[currentIndex]] {
            currentIndex += 1
            currentNode = child
        }
        
        // Check the size matches and if the node is marked as a terminater of a word.
        return currentIndex == characters.count && currentNode.isTerminating
    }
    
    func getCharacters(for word: String) -> [Character] {
        return word.lowercased().map({ Character(String($0)) })
    }
    
    // WALKTHROUGH:                      Root
    //                        [ c    a  s     h     w ]
    //                         o u   m. o.    e     o
    //                         o t.           l     r
    //                         l. e.          l.    l
    //                                       o.a.   d.
    // Possible scenarios: The word to remove has no other words in it, so the whole branch is removed.
    //                     The word to remove is a prefix to another word, so do not remove actual nodes. Only remove the flag on the final letter.
    //                     The word to remove has previous letters used for other words. Only remove the nodes where it branches out.
    func remove(word: String) {
        guard !word.isEmpty && contains(word: word) else { return }
        let characters: [Character] = getCharacters(for: word)
        removeNodesUsing(root.children, characters: characters, position: 0)
        
        // Removes the first letter node if has no more children.
        if let node = root.children[characters[0]], node.children.isEmpty {
            root.children.removeValue(forKey: characters[0])
        }
    }
    
    private func removeNodesUsing<Character>(_ dict: [Character: TrieNode<Character>], characters: [Character], position: Int) {
        if position == characters.count - 1 {
            if let node = dict[characters[position]], node.value == characters[position] && node.isTerminating {
                // Remove the flag from the node that it terminates a word.
                node.isTerminating = false
                if let parent = node.parent, node.children.isEmpty {
                    parent.children.removeValue(forKey: characters[position])
                }
            }
            return
        }
        
        if let node = dict[characters[position]] {
            removeNodesUsing(node.children, characters: characters, position: position + 1)
            // Remove the actual nodes but only if they don't contain subtrees of words.
            var removeNode: Bool = false
            if position + 1 < characters.count, let child = node.children[characters[position + 1]] {
                // Check the child node if it has any words.
                doesContainWords(child, flag: &removeNode)
                if !removeNode {
                    node.children.removeValue(forKey: characters[position + 1])
                }
            }
        }
    }
    
    // Check if the current node contains any words to determine whether it should remove the current node.
    private func doesContainWords<T>(_ node: TrieNode<T>, flag: inout Bool) {
        if node.isTerminating {
            flag = true
        }
        for (_, item) in node.children.enumerated() {
            doesContainWords(item.value, flag: &flag)
        }
    }
}

extension Trie: CustomStringConvertible {
    var description: String {
        return "\(root)"
    }
}

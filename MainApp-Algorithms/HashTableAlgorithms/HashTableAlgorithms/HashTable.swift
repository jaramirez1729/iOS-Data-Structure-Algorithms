//
//  HashTable.swift
//  HashTableAlgorithms
//
//  Created by Jozeee on 2/2/20.
//  Copyright © 2020 AdaloveSoftware. All rights reserved.
//

class HashTable<Key: Hashable, Value> {
    
    private typealias Element = (key: Key, value: Value)
    private typealias Bucket = [Element]
    
    private var buckets: [Bucket]
    private(set) var count = 0
    
    var isEmpty: Bool {
        return count == 0
    }
    
    init(capacity: Int) {
        assert(capacity > 0)
        buckets = Array<Bucket>(repeating: [], count: capacity)
    }
    
    private func index(for key: Key) -> Int {
        return abs(key.hashValue) % buckets.count
    }
    
    subscript(key: Key) -> Value? {
        get {
            return value(for: key)
        }
        set {
            if let value = newValue {
                update(value: value, for: key)
            } else {
                removeValue(for: key)
            }
        }
    }
    
    func value(for key: Key) -> Value? {
        let index = self.index(for: key)
        // Loops through the array of arrays found for the index and finds the first value
        // that matches the key.
        return buckets[index].first { $0.key == key }?.value
    }
    
    @discardableResult func update(value: Value, for key: Key) -> Value? {
        let index = self.index(for: key)
        
        if let (i, element) = buckets[index].enumerated().first(where: { $0.1.key == key }) {
            let oldValue = element.value
            buckets[index][i].value = value
            return oldValue
        }
        
        buckets[index].append((key: key, value: value))
        count += 1
        return nil
    }
    
    @discardableResult func removeValue(for key: Key) -> Value? {
        let index = self.index(for: key)
        
        if let (i, element) = buckets[index].enumerated().first(where: { $0.1.key == key }) {
            buckets[index].remove(at: i)
            count -= 1
            return element.value
        }
        
        return nil
    }
}

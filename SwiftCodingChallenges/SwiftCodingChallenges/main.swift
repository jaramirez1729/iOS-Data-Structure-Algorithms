//
//  main.swift
//  SwiftCodingChallenges
//
//  Created by Jozeee on 2/7/20.
//  Copyright © 2020 AdaloveSoftware. All rights reserved.
//

import Foundation

struct Time {
    func measure(_ block: () -> Void) {
        let startingTime = Date()
        block()
        print("\(startingTime.timeIntervalSinceNow * -1) seconds.")
    }
}

let arr: [Int?] = [1, 2, 3, 4, 5, nil, 6, 7, nil]
//print(arr.map { $0 })
//print(arr.compactMap { $0 })
print(arr.compactMap { $0 }.filter { $0 > 4 })
print(arr.compactMap{ $0 }.reduce(0, +))

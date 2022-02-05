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

printPermutations(of: "OK")

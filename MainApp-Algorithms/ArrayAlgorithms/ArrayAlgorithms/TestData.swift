//
//  TestData.swift
//  ArrayAlgorithms
//
//  Created by Jozeee on 1/11/20.
//  Copyright © 2020 AdaloveSoftware. All rights reserved.
//

import Foundation

class MeasureTime {
    /// Measures the execution time of the block by using a Date object and getting back the difference since the block began.
    func measure(block: () -> Void) {
        let startTime: Date = Date()
        block()
        print("\(startTime.timeIntervalSinceNow * -1) seconds elapsed.")
    }
}

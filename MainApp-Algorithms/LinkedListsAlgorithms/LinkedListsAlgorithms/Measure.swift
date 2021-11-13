//
//  Measure.swift
//  LinkedListsAlgorithms
//
//  Created by Jozeee on 1/16/20.
//  Copyright © 2020 AdaloveSoftware. All rights reserved.
//

import Foundation

struct MeasureTime {
    func measure(_ block: () -> Void) {
        let date: Date = Date()
        block()
        print("\(date.timeIntervalSinceNow * -1) seconds.")
    }
}

//
//  XIlist.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-13.
//

import Foundation

extension Plot {

    /// Calculate a list of x values, either a range or a data column
    /// - Returns: list of x and i values

    func xiList() -> [XIvalue] {
        if index < 0 {
            return (-settings.intValue(.headerColumns)..<csv.colCt).map { XIvalue(x: Double($0), i: $0) }
        } else {
            let val = csv.rowValues(index)
            return (0 ..< csv.colCt).map { XIvalue(x: val[$0], i: $0) }
        }
    }
}

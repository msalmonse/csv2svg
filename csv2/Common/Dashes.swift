//
//  Dashes.swift
//  csv2
//
//  Created by Michael Salmon on 2021-03-17.
//

import Foundation

class Dashes {
    static private var next = -1
    static private let dashList = [
        [ 1.0, 1.0, 2.0, 1.0 ],
        [ 2.5 ],
        [ 3.0, 1.0, 2.0, 1.0 ],
        [ 3.5, 1.5 ],
        [ 1.25 ],
        [ 1.0, 1.0, 2.0, 1.0, 3.0, 1.0 ]
    ]

    static private func convert(_ dashes: [Double], _ w: Double) -> String {
        let mult = w * 0.01
        return dashes.map { ($0 * mult).f(0) }.joined(separator:  ",")
    }

    /// Collect all dash patterns
    /// - Parameter w: width of plottable plane
    /// - Returns: All dashes as an array of strings

    static func all(_ w: Double) -> [String] {
        return dashList.map { convert($0, w) }
    }

    // Number of dashes
    static var count: Int { dashList.count }

    /// Get the dash in the sequence
    /// - Parameter w: width of plottable plane
    /// - Returns: next dash

    static func nextDash(_ w: Double) -> String {
        next += 1
        if next >= dashList.count { next = 0 }
        return convert(dashList[next], w)
    }

    /// Reset the dash sequence

    static func reset() {
        next = -1
    }
}

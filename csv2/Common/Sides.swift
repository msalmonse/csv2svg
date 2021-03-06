//
//  SVG/Sides.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-02-24.
//

import Foundation

struct Sides {

    /// Set min and max after comparing with val
    /// - Parameters:
    ///   - val: value to compare
    ///   - max: max so far
    ///   - min: min so far

    private static func setMinMax(_ val: Double?, max: inout Double, min: inout Double) {
        if let val = val {
            if val > max { max = val }
            if val < min { min = val }
        }
    }

    /// Calculate the left and right sides of the data
    /// - Parameters:
    ///   - csv: csv values
    ///   - settings: settings
    /// - Returns: the left and right sides

    private static func lrFromData(_ csv: CSV, _ settings: Settings) -> (l: Double, r: Double) {
        let count = csv.colCt
        let index = settings.index
        let xMaxSet = settings.doubleValue(.xMax) > Defaults.maxDefault
        let xMinSet = settings.doubleValue(.xMin) < Defaults.minDefault
        let left: Double
        let right: Double

        if  xMaxSet && xMinSet {
            left = settings.doubleValue(.xMin)
            right = settings.doubleValue(.xMax)
        } else if count == 0 {
            left = 0.0
            right = 0.0
        } else {
            var min: Double
            var max: Double

            if index < 0 {
                min = 0.0
                max = Double(count - 1)
            } else {
                min = Defaults.minDefault
                max = Defaults.maxDefault
                let start = settings.intValue(.headerColumns)
                if csv.values.hasIndex(index) {
                    let indexRow = csv.values[index]
                    let end = indexRow.count
                    if end > start {
                        _ = indexRow[start..<end].map { setMinMax($0, max: &max, min: &min) }
                    }
                }
                // if min and max don't include 0 then include 0 if one is close
                if min > 0 && max > 0 && !settings.boolValue(.logx) {
                    if min < max / 20.0 { min = 0.0 }
                } else if min < 0 && max < 0 && !settings.boolValue(.logx) {
                    if max < min / 20.0 { max = 0.0 }
                }
            }

            left = xMinSet ? settings.doubleValue(.xMin) : min
            right = xMaxSet ? settings.doubleValue(.xMax) : max
        }

        return (l: left, r: right)
    }

    /// Calculate to top and bottom from the csv values
    /// - Parameters:
    ///   - csv: csv data
    ///   - settings: chart data
    ///   - count: number of rows
    ///   - min: minimum found
    ///   - max: maximum found

    static func tbCalc(_ csv: CSV, _ settings: Settings, count: Int, min: inout Double, max: inout Double) {
        let index = settings.index
        let included = settings.bitmapValue(.include)
        let stacked = settings.bitmapValue(.stackedPlots)
        if stacked != BitMap.none { min = 0.0 }
        var stackedMax = Array(repeating: 0.0, count: csv.colCt)

        let first = settings.intValue(.headerRows)
        let start = settings.intValue(.headerColumns)

        for i in first..<count where i != index && included[i] {
            if csv.values.hasIndex(i) {
                let valuesRow = csv.values[i]
                let end = valuesRow.count
                if end > start {
                    if !stacked[i] {
                        _ = valuesRow[start..<end].map { setMinMax($0, max: &max, min: &min) }
                    } else {
                        for j in start..<end {
                            if let val = valuesRow[j] {
                                stackedMax[j] += val
                                if stackedMax[j] > max { max = stackedMax[j] }
                            }
                        }
                    }
                }
            }
        }
    }

    /// Calculate the top and bottom values of the data
    /// - Parameters:
    ///   - csv: csv values
    ///   - settings: settings
    /// - Returns: the top and bottom sides

    static func tbFromData(_ csv: CSV, _ settings: Settings) -> (t: Double, b: Double) {
        let yMaxSet = settings.doubleValue(.yMax) > Defaults.maxDefault
        let yMinSet = settings.doubleValue(.yMin) < Defaults.minDefault
        let count = csv.rowCt
        let top: Double
        let bottom: Double

        if yMaxSet && yMinSet {
            bottom = settings.doubleValue(.yMin)
            top = settings.doubleValue(.yMax)
        } else if count == 0 {
            top = 0.0
            bottom = 0.0
        } else {
            var min: Double = Double.greatestFiniteMagnitude
            var max: Double = -Double.greatestFiniteMagnitude

            tbCalc(csv, settings, count: count, min: &min, max: &max)

            // if min and max don't include 0 then include 0 if one is close
            if min > 0 && max > 0 && !settings.boolValue(.logy) {
                if min < max / 20.0 { min = 0.0 }
            } else if min < 0 && max < 0 && !settings.boolValue(.logy) {
                if max < min / 20.0 { max = 0.0 }
            }

            bottom = yMinSet ? settings.doubleValue(.yMin) : min
            top = yMaxSet ? settings.doubleValue(.yMax) : max
        }

        return (t: top, b: bottom)
    }

    /// Calculate the plane that fits the data to be displayed with the abscissa horizontal
    /// - Parameters:
    ///   - csv: csv data
    ///   - settings: chart settings
    /// - Returns: the plane of the data

    static func fromDataHorizontal(_ csv: CSV, _ settings: Settings) -> Plane {
        let (left, right) = lrFromData(csv, settings)
        let (top, bottom) = tbFromData(csv, settings)

        return Plane(top: top, bottom: bottom, left: left, right: right)
    }

    /// Calculate the plane that fits the data to be displayed with the abscissa vertical
    /// - Parameters:
    ///   - csv: csv data
    ///   - settings: chart settings
    /// - Returns: the plane of the data

    static func fromDataVertical(_ csv: CSV, _ settings: Settings) -> Plane {
        let (right, left) = tbFromData(csv, settings)
        let top = -1.0
        // Calculate which columns have data and are included
        let included = settings.bitmapValue(.include)
        let headerCols = BitMap(lsb: settings.intValue(.headerColumns))
        let dataCols = BitMap(lsb: csv.colCt) - headerCols
        let dataColsCt = (dataCols.intersection(included)).bitCount()
        let dataRowCt = csv.rowCt - settings.intValue(.headerRows)
        let bottom = Double((dataColsCt + 3) * dataRowCt) + 2.0

        return Plane(top: top, bottom: bottom, left: left, right: right)
    }
}

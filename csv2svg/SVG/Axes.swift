//
//  SVG/Axes.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-01.
//

import Foundation

extension SVG {

    /// Draw axes
    /// - Parameter ts: scaling and tranlating object
    /// - Returns: paths with axes

    func svgAxes(_ ts: TransScale) -> String {
        var path: [PathCommand] = []

        if dataPlane.inVert(0.0) {
            path.append(.moveTo(x: plotPlane.left, y: ts.ypos(0.0)))
            path.append(.horizTo(x: plotPlane.right))
        }
        if dataPlane.inHoriz(0.0) {
            path.append(.moveTo(x: ts.xpos(0), y: plotPlane.bottom))
            path.append(.vertTo(y: plotPlane.top))
        }

        return Self.svgPath(path, pathProperty(withColour: "Black"), width: strokeWidth)
    }

    /// Normalize tick value
    /// - Parameters:
    ///   - tick: tick specified
    ///   - dpp: data per pixel - how much data does each pixel show
    ///   - minSize: minimum number of pixels between ticks allowed
    ///   - maxSize: maximum number of pixels between ticks allowed
    /// - Returns: new tick value

    private func tickNorm(_ tick: Double, dpp: Double, minSize: Double, maxSize: Double) -> Double {
        let ppt = tick/dpp      // pixels per tick
        if ppt >= minSize && ppt <= maxSize { return tick }
        let raw = minSize * dpp
        // calculate the power of 10 less than the raw tick
        let pow10 = pow(10.0, floor(log10(raw)))
        var norm = ceil(raw/pow10) * pow10
        if norm > 0.1 && norm < 1.0 { norm = 1.0 }  // < .01 is where labels use e format
        // return the tick as an an integer times the power of 10
        return norm
    }

    /// Draw vertical ticks
    /// - Parameter ts: scaling and translating object
    /// - Returns: path for the ticks

    func svgXtick(_ ts: TransScale) -> String {
        var path: [PathCommand] = []
        var labels = [""]
        let tick = tickNorm(
            settings.xTick,
            dpp: dataPlane.width/plotPlane.width,
            minSize: settings.labelSize * 3.5,
            maxSize: plotPlane.width/5.0
        )
        let intTick = (tick.rounded() == tick)
        var x = tick    // the zero line is plotted by svgAxes
        let xMax = max(dataPlane.right, -dataPlane.left) + tick * 0.5 // fudge a little for strange tick values

        while x <= xMax {
            if dataPlane.inHoriz(x) {
                path.append(.moveTo(x: ts.xpos(x), y: plotPlane.bottom))
                path.append(.vertTo(y: plotPlane.top))
                labels.append(xLabelText(label(x, intTick), x: ts.xpos(x), y: positions.xTicksY))
            }
            if dataPlane.inHoriz(-x) {
                path.append(.moveTo(x: ts.xpos(-x), y: plotPlane.bottom))
                path.append(.vertTo(y: plotPlane.top))
                labels.append(xLabelText(label(-x, intTick), x: ts.xpos(-x), y: positions.xTicksY))
            }
            x += tick
        }

        return Self.svgPath(path, pathProperty(withColour: "Silver")) + labels.joined(separator: "\n")
    }

    /// Draw horizontal ticks
    /// - Parameter ts: scaling and translating object
    /// - Returns: path for the ticks

    func svgYtick(_ ts: TransScale) -> String {
        var path: [PathCommand] = []
        var labels = [""]
        let tick = tickNorm(
            settings.yTick,
            dpp: dataPlane.height/plotPlane.height,
            minSize: settings.labelSize * 1.25,
            maxSize: plotPlane.height/5.0
        )
        let intTick = (tick.rounded() == tick)
        var y = tick    // the zero line is plotted by svgAxes
        let yMax = max(dataPlane.top, -dataPlane.bottom)

        while y <= yMax {
            if dataPlane.inVert(y) {
                path.append(.moveTo(x: plotPlane.left, y: ts.ypos(y)))
                path.append(.horizTo(x: plotPlane.right))
                labels.append(yLabelText(label(y, intTick), x: positions.yTickX, y: ts.ypos(y)))
            }
            if dataPlane.inVert(-y) {
                path.append(.moveTo(x: plotPlane.left, y: ts.ypos(-y)))
                path.append(.horizTo(x: plotPlane.right))
                labels.append(yLabelText(label(-y, intTick), x: positions.yTickX, y: ts.ypos(-y)))
            }
            y += tick
        }

        return Self.svgPath(path, pathProperty(withColour: "Silver")) + labels.joined(separator: "\n")
    }
}

//
//  SVG/Path.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-02-22.
//

import Foundation

extension SVG {

    /// path commands

    /// Enum describing the ways a path can be drawn

    enum PathCommand {
        case
            arc(rx: Double, ry: Double, rot: Double, large: Bool, sweep: Bool, dx: Double, dy: Double),
                                                        // Draw an arc
            blade(w: Double),                           // Draw a blade of width 2 * w
            circle(r: Double),                          // Draw a circle of radius r
            diamond(w: Double),                         // a diamond of width 2 * w
            moveBy(dx: Double, dy: Double),             // Move by dx and dy
            moveTo(x: Double, y: Double),               // Move absolute to x,y
            horizBy(dx: Double),                        // Draw line horizontally by dx
            horizTo(x: Double),                         // Draw line horizontally to x
            lineBy(dx: Double, dy: Double),             // Draw line by dx,dy
            lineTo(x: Double, y: Double),               // Draw line to x,y
            shuriken(w: Double),                        // Draw shuriken
            square(w: Double),                          // Draw a square with sides 2 * w
            star(w: Double),                            // Draw a star of width 2 * w
            triangle(w: Double),                        // Draw a triangle of width 2 * w
            vertBy(dy: Double),                         // Draw line vertically by dy
            vertTo(y: Double)                           // Draw line vertically to y

        /// Convert a command into a path string
        /// - Returns: path string

        func command() -> String {
            switch self {
            case .arc(let rx, let ry, let rot, let large, let sweep, let dx, let dy):
                return String(
                    format: "a %.1f,%.1f,%.1f,%d,%d,%.1f,%.1f",
                    rx, ry, rot, large ? 1 : 0, sweep ? 1 : 0, dx, dy
                )
            case .blade(let w): return drawBlade(w: w)
            case .circle(let r): return drawCircle(r: r)
            case .diamond(let w): return drawDiamond(w: w)
            case .moveBy(let dx, let dy): return String(format: "m %.1f,%.1f", dx, dy)
            case .moveTo(let x, let y): return String(format: "M %.1f,%.1f", x, y)
            case .horizBy(let dx): return String(format: "h %0.1f", dx)
            case .horizTo(let x): return String(format: "H %0.1f", x)
            case .lineBy(let dx, let dy): return String(format: "l %.1f,%.1f", dx, dy)
            case .lineTo(let x, let y): return String(format: "L %.1f,%.1f", x, y)
            case .shuriken(let w): return drawShuriken(w: w)
            case .square(let w): return drawSquare(w: w)
            case .star(let w): return drawStar(w: w)
            case .triangle(let w): return drawTriangle(w: w)
            case .vertBy(let dy): return String(format: "v %0.1f", dy)
            case .vertTo(let y): return String(format: "V %0.1f", y)
            }
        }
    }

    /// plot a path from a list of points
    /// - Parameters:
    ///   - points: a list of the points or shapes on path
    ///   - stroke: contents of the stroke paramater of the path
    ///   - width: setting for stroke-width, (default 1)
    ///   - linecap: setting for stroke-linecap (default "round")
    /// - Returns: a path element

    static func svgPath(
        _ points: [PathCommand],
        stroke: String? = nil,
        width: Double = 1.0,
        linecap: String = "round"
    ) -> String {
        let strokeColour = stroke ?? Colours.nextColour()
        let style = [
            "stroke: \(strokeColour)",
            "fill: none",
            "stroke-width: \(width.f(1))",
            "stroke-linecap: \(linecap)"
        ].joined(separator: "; ")

        // a path needs 2 points
        guard points.count >= 2 else { return "" }

        var result = [ "<path d=\"" ]

        result.append(contentsOf: points.map { $0.command() })
        result.append("\" style=\"\(style)\" />")

        return result.joined(separator: " ")
    }

}
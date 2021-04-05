//
//  DashesList.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-23.
//

import Foundation

extension SVG {
    func dashesListGen(_ step: Double, _ defaults: Defaults) -> [String] {
        let colour = defaults.colours.first ?? "black"
        let dashCSS =
            "\(hashID) path.dashes { stroke: \(colour); stroke-width: \((step/5.0).f(1)); stroke-linecap: butt }"

        let xLeft = width * 0.1
        let xRight = width * 0.6
        let xText = width * 0.65

        var y = step
        var yPath: Double { y - step/10.0 }

        var result: [String] = [ xmlTag, svgTag, cssStyle(extra: dashCSS)]

        for dash in defaults.dashes + SVG.Dashes.all(width * 3.0) {
            y += step
            let points = [ PathCommand.moveTo(x: xLeft, y: yPath), .horizTo(x: xRight) ]
            let extra = "style=\"stroke-dasharray: \(dash)\""
            result.append(path(points, cssClass: "dashes", extra: extra))
            result.append(textTag(x: xText, y: y, text: dash, cssClass: "dashes"))
        }

        result.append(svgTagEnd)
        return result
    }
}

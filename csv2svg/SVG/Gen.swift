//
//  SVG/Gen.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-10.
//

import Foundation

extension SVG {

    /// Generate the defs element
    /// - Returns: the defs elements as a list

    func defs() -> [String] {
        // Make plottable a bit bigger so that shapes aren't clipped
        let h = (plotPlane.bottom - plotPlane.top + shapeWidth * 4.0)
        let w = (plotPlane.right - plotPlane.left + shapeWidth * 4.0)
        let x = (plotPlane.left - shapeWidth * 2.0)
        let y = (plotPlane.top - shapeWidth * 2.0)
        var result = ["<defs>"]
        result.append("<clipPath id=\"plotable\">")
        result.append(rectTag(x: x, y: y, width: w, height: h))
        result.append("</clipPath>")
        result.append("</defs>")

        return result
    }

    func background(_ bg: String) -> String {
        return """
            <style> svg { background-color: \(bg) } </style>
            """
    }

    /// Generate an SVG group with the plot lines
    /// - Parameter ts: TransScale object
    /// - Returns: Array of SVG elements

    func lineGroup(_ ts: TransScale) -> [String] {
        var result: [String] = []
        result.append("<g clip-path=\"url(#plotable)\" opacity=\"\(settings.opacity.f(2))\">")
        result.append(contentsOf: settings.inColumns ? columnPlot(ts) : rowPlot(ts))
        result.append("</g>")

        return result
    }

    /// Generate an svg document
    /// - Returns: array of svg elements

    func gen() -> [String] {
        let ts = TransScale(from: dataPlane, to: plotPlane, logx: logx, logy: logy)

        var result: [String] = [ xmlTag, svgTag, comment ]
        result.append(cssStyle())
        result.append(contentsOf: defs())
        if settings.backgroundColour != "" { result.append(background(settings.backgroundColour)) }
        if settings.xTick >= 0 { result.append(xTick(ts)) }
        if settings.yTick >= 0 { result.append(yTick(ts)) }
        result.append(axes(ts))
        result.append(contentsOf: lineGroup(ts))
        if settings.xTitle != "" {
            result.append(xTitleText(settings.xTitle, x: plotPlane.hMid, y: positions.xTitleY))
        }
        if settings.yTitle != "" {
            result.append(yTitleText(settings.yTitle, x: positions.yTitleX, y: plotPlane.vMid))
        }
        if settings.legends { result.append(legend()) }
        if subTitle != "" { result.append(subTitleText()) }
        if settings.title != "" { result.append(titleText()) }
        result.append(svgTagEnd)

        return result
    }

    /// Generate an SVG to display a shape
    /// - Parameters:
    ///   - name: shape name
    ///   - stroke: stroke colour
    /// - Returns: SVG as an array of strings

    func shapeGen(name: String, stroke: String) -> [String] {
        let shape = Shape.lookup(name)
        var result: [String] = [ xmlTag, svgTag ]
        let shapeCss = "path.shape { stroke: \(stroke) }"
        result.append(cssStyle(extra: shapeCss))
        let path = [
            PathCommand.moveTo(x: width/2.0, y: height/2.0),
            shape!.pathCommand(w: shapeWidth)
        ]
        result.append(SVG.path(path, pathProperty(withColour: stroke, andClass: "shape"), width: settings.strokeWidth))
        result.append(svgTagEnd)

        return result
    }
}

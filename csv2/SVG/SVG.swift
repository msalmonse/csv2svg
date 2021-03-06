//
//  SVG/SVG.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-02-18.
//

import Foundation

class SVG: Plotter, ReflectedStringConvertible {
    // Storage for data
    var data = Data()

    // plot widths
    let strokeWidth: Double
    var shapeWidth: Double

    let settings: Settings

    // Plot area height and width
    let height: Double
    let width: Double

    // id for this svg
    let svgID: String
    var hashID: String { svgID == "none" ? "" : "#\(svgID)" }

    // Tags
    let xmlTag = "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?>\n"
    var svgTag: String {
        String(
            format: "<svg %@ width=\"%d\" height=\"%d\" xmlns=\"http://www.w3.org/2000/svg\">\n",
            svgID != "none" ? "id=\"\(svgID)\"" : "" ,
            settings.intValue(.width), settings.intValue(.height)
        )
    }
    let svgTagEnd = "\n</svg>\n"
    var comment: String { """
        <!--
            \(settings.comment)
          -->

        """
    }

    init(_ settings: Settings) {
        self.settings = settings
        let cssID = settings.stringValue(.cssID, in: .svg)
        svgID = cssID.hasContent ? cssID
            : "ID-\(Int.random(in: 1...(1 << 24)).x0(6))"
        height = settings.height
        shapeWidth = settings.shapeWidth
        strokeWidth = settings.strokeWidth
        width = settings.width
    }

    /// Generate the defs element
    /// - Returns: the defs elements as a list

    func defs(clipPlane: Plane) {
        // Make plottable a bit bigger so that shapes aren't clipped
        let h = clipPlane.height
        let w = clipPlane.width
        let x = clipPlane.left
        let y = clipPlane.top
        data.append("""
                <defs>
                <clipPath id="plotable">

                """
            )
        rectTag(x: x, y: y, width: w, height: h)
        data.append("""

            </clipPath>
            </defs>

            """
            .data(using: .utf8)!
        )
    }

    func logoImage(positions: Positions) {
        let x = positions.logoX
        let y = positions.logoY
        let h = settings.doubleValue(.logoHeight)
        let w = settings.doubleValue(.logoWidth)
        let url = settings.stringValue(.logoURL)
        data.append("""
            <image \(xy(x,y)) \(wh(w,h)) href="\(url)" class="logo" preserveAspectRatio="xMaxYMin" />
            """
        )
    }

    /// Include SVG elements in SVG
    /// - Parameter name: file name to include
    /// - Returns: Text to include

    func svgInclude(_ name: String) {
        if let url = SearchPath.search(name), let include = try? String(contentsOf: url) {
            data.append(include)
        }
    }
}

//
//  SVGsettings.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-30.
//

import Foundation

extension Settings {

    /// SVG related settings

    struct SVG {
        // Include plot info in svg
        let legends: Bool

        // Lag axes?
        let logx: Bool
        let logy: Bool

        let logoHeight: Double
        let logoURL: String
        let logoWidth: Double

        let include: String

        // svg sub-title title, x axis title and y axis title
        let subTitle: String
        let title: String
        let xTitle: String
        let yTitle: String
    }

    /// Create SVG object from JSON
    /// - Parameter container: JSON container
    /// - Returns: SVG object

    static func jsonSVG(from container: KeyedDecodingContainer<CodingKeys>?, defaults: Defaults) -> SVG {
        return SVG(
            legends: keyedBoolValue(from: container, forKey: .legends, defaults: defaults),
            logx: keyedBoolValue(from: container, forKey: .logx, defaults: defaults),
            logy: keyedBoolValue(from: container, forKey: .logy, defaults: defaults),
            logoHeight: keyedDoubleValue(from: container, forKey: .logoHeight, defaults: defaults),
            logoURL: keyedStringValue(from: container, forKey: .logoURL, defaults: defaults),
            logoWidth: keyedDoubleValue(from: container, forKey: .logoHeight, defaults: defaults),
            include: keyedStringValue(from: container, forKey: .svgInclude, defaults: defaults),
            subTitle: keyedStringValue(from: container, forKey: .subTitle, defaults: defaults),
            title: keyedStringValue(from: container, forKey: .title, defaults: defaults),
            xTitle: keyedStringValue(from: container, forKey: .xTitle, defaults: defaults),
            yTitle: keyedStringValue(from: container, forKey: .yTitle, defaults: defaults)
        )
    }
}
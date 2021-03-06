//
//  Nested.swift
//  csv2
//
//  Created by Michael Salmon on 2021-05-28.
//

import Foundation

extension Settings {

    private static func loadOne(
        from container: KeyedDecodingContainer<CodingKeys>?,
        for key: CodingKeys,
        in domain: DomainKey,
        or notFound: RGBAu8?,
        into values: inout SettingsValues
    ) {
        let val = (try? getColour(from: container, for: key, defaults: nil)) ?? notFound
        values.setValue(key, .colourValue(val: val!), in: domain)
    }

    /// Load the values from the foregroundColours nested container
    /// - Parameters:
    ///   - container: JSON container
    ///   - defaults: default values
    ///   - values: storage for values

    static func loadForeground(
        from container: KeyedDecodingContainer<CodingKeys>?,
        defaults: Defaults,
        into values: inout SettingsValues
    ) {
        let fg = defaults.colourValue(.foregroundColour)!
        let text = defaults.colourValue(.textcolour)!
        let pieText = (try? getColour(from: container, for: .pieLegend, defaults: nil)) ?? text
        let pieLabel = pieText.clamped(opacity: 0.75)
        let nested = try? container?.nestedContainer(keyedBy: CodingKeys.self, forKey: .foregroundColours)
        loadOne(from: nested, for: .axes, in: .foreground, or: fg, into: &values)
        loadOne(from: nested, for: .draft, in: .foreground, or: fg, into: &values)
        loadOne(from: nested, for: .legends, in: .foreground, or: text, into: &values)
        loadOne(from: nested, for: .legendsBox, in: .foreground, or: fg, into: &values)
        loadOne(from: nested, for: .pieLabel, in: .foreground, or: pieLabel, into: &values)
        values.setValue(.pieLegend, .colourValue(val: pieText), in: .foreground)
        loadOne(from: nested, for: .subTitle, in: .foreground, or: text, into: &values)
        loadOne(from: nested, for: .title, in: .foreground, or: text, into: &values)
        loadOne(from: nested, for: .xLabel, in: .foreground, or: text, into: &values)
        loadOne(from: nested, for: .xTags, in: .foreground, or: text, into: &values)
        loadOne(from: nested, for: .xTitle, in: .foreground, or: text, into: &values)
        loadOne(from: nested, for: .yLabel, in: .foreground, or: text, into: &values)
        loadOne(from: nested, for: .yTitle, in: .foreground, or: text, into: &values)
    }

    /// Load the values from the pdf nested container
    /// - Parameters:
    ///   - container: JSON container
    ///   - defaults: default values
    ///   - values: storage for values

    static func loadPDF(
        from container: KeyedDecodingContainer<CodingKeys>?,
        defaults: Defaults,
        into values: inout SettingsValues
    ) {
        if let nested = try? container?.nestedContainer(keyedBy: CodingKeys.self, forKey: .pdf) {
            for key in [Self.CodingKeys.author, .keywords, .subject, .title] {
                let val = keyedStringSettingsValue(from: nested, forKey: key, defaults: defaults)
                values.setValue(key, val, in: .pdf)
            }
        }
    }
}

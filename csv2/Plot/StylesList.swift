//
//  PropertiesList.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-10.
//

import Foundation

struct StylesList {
    var plots: [Styles]
    var axes: Styles
    var draft: Styles
    var legend: Styles
    var legendHeadline: Styles
    var legendBox: Styles
    var pieLabel: Styles
    var pieLegend: Styles
    var pieSubLegend: Styles
    var subTitle: Styles
    var title: Styles
    var xLabel: Styles
    var xTags: Styles
    var xTitle: Styles
    var yLabel: Styles
    var yTitle: Styles

    init(count ct: Int, settings: Settings) {
        let sizes = FontSizes(size: settings.doubleValue(.baseFontSize))
        plots = Array(repeating: Styles.from(settings: settings), count: ct)

        axes = Self.axesStyle(settings: settings, sizes: sizes)
        draft = Self.draftStyle(settings: settings)
        legend = Self.legendStyle(settings: settings, sizes: sizes)
        legendBox = Self.legendBoxStyle(settings: settings, sizes: sizes)
        legendHeadline = Self.legendHeadlineStyle(settings: settings, sizes: sizes)
        pieLabel = Self.pieLabelStyle(settings: settings, sizes: sizes)
        pieLegend = Self.pieLegendStyle(settings: settings, sizes: sizes)
        pieSubLegend = Self.pieSubLegendStyle(settings: settings, sizes: sizes)
        subTitle = Self.subTitleStyle(settings: settings, sizes: sizes)
        title = Self.titleStyle(settings: settings, sizes: sizes)
        xLabel = Self.xLabelStyle(settings: settings, sizes: sizes)
        xTags = Self.xTagsStyle(settings: settings, sizes: sizes)
        xTitle = Self.xTitleStyle(settings: settings, sizes: sizes)
        yLabel = Self.yLabelStyle(settings: settings, sizes: sizes)
        yTitle = Self.yTitleStyle(settings: settings, sizes: sizes)
    }

    /// Set axes style
    /// - Parameters:
    ///   - settings: chart settings
    ///   - sizes: font sizes
    /// - Returns: axes style

    static private func axesStyle(settings: Settings, sizes: FontSizes) -> Styles {
        var axes = Styles.from(settings: settings)
        axes.colour = settings.colourValue(.axes, in: .foreground) ?? .black
        axes.cssClass = "axes"
        return axes
    }

    /// Set legend style
    /// - Parameters:
    ///   - settings: chart settings
    ///   - sizes: font sizes
    /// - Returns: legend style

    static private func draftStyle(settings: Settings) -> Styles {
        var draft = Styles.from(settings: settings)
        draft.cssClass = "draft"
        draft.fontColour = settings.colourValue(.draft, in: .foreground) ?? .black
        draft.fontFamily = "sans-serif"
        draft.options[.bold] = false
        draft.options[.italic] = false
        draft.options[.stroked] = true
        draft.textAlign = "middle"
        draft.textBaseline = "middle"

        // calculate font size
        let text = settings.stringValue(.draftText)
        let charSize = min(settings.width / Double(text.count), settings.height / 2.0)
        draft.fontSize = floor(charSize * 1.25)

        // now the transform
        let x = settings.width / 2.0
        let y = settings.height / 2.0
        let hyp = sqrt(x * x + y * y)
        draft.transform = Transform.rotateAround(x: x, y: y, sin: y / hyp, cos: x / hyp)

        return draft
    }

    /// Set legend style
    /// - Parameters:
    ///   - settings: chart settings
    ///   - sizes: font sizes
    /// - Returns: legend style

    static private func legendStyle(settings: Settings, sizes: FontSizes) -> Styles {
        var legend = Styles.from(settings: settings)
        legend.cssClass = "legend"
        legend.fontColour = settings.colourValue(.legends, in: .foreground) ?? .black
        legend.fontSize = sizes.legend.size
        legend.textAlign = "start"
        return legend
    }

    /// Set legendBox style
    /// - Parameters:
    ///   - settings: chart settings
    ///   - sizes: font sizes
    /// - Returns: legendBox style

    static private func legendBoxStyle(settings: Settings, sizes: FontSizes) -> Styles {
        var legendBox = Styles.from(settings: settings)
        legendBox.colour =
            (settings.colourValue(.legendsBox, in: .foreground) ?? .black).clamped(opacity: 0.4)
        legendBox.fill = legendBox.colour
        legendBox.cssClass = "legend"
        return legendBox
    }

    /// Set legendHeadline style
    /// - Parameters:
    ///   - settings: chart settings
    ///   - sizes: font sizes
    /// - Returns: legendHeadline style

    static private func legendHeadlineStyle(settings: Settings, sizes: FontSizes) -> Styles {
        var legendHeadline = Styles.from(settings: settings)
        legendHeadline.options[.bold] = true
        legendHeadline.cssClass = "legendheadline"
        legendHeadline.fontColour = settings.colourValue(.legends, in: .foreground) ?? .black
        legendHeadline.fontSize = sizes.legend.size * 1.25
        legendHeadline.textAlign = "start"
        return legendHeadline
    }

    /// Set pieLabel style
    /// - Parameters:
    ///   - settings: chart settings
    ///   - sizes: font sizes
    /// - Returns: pieLabel style

    static private func pieLabelStyle(settings: Settings, sizes: FontSizes) -> Styles {
        var pieLabel = Styles.from(settings: settings)
        pieLabel.cssClass = "pielabel"
        pieLabel.fontColour = settings.colourValue(.pieLabel, in: .foreground) ?? .black
        pieLabel.fontSize = sizes.pieLabel.size
        pieLabel.textAlign = ""
        return pieLabel
    }

    /// Set pieLegend style
    /// - Parameters:
    ///   - settings: chart settings
    ///   - sizes: font sizes
    /// - Returns: pieLegend style

    static private func pieLegendStyle(settings: Settings, sizes: FontSizes) -> Styles {
        var pieLegend = Styles.from(settings: settings)
        pieLegend.cssClass = "pielegend"
        pieLegend.fontColour = settings.colourValue(.pieLegend, in: .foreground) ?? .black
        pieLegend.fontSize = sizes.pieLegend.size
        return pieLegend
    }

    /// Set pieSubLegend style
    /// - Parameters:
    ///   - settings: chart settings
    ///   - sizes: font sizes
    /// - Returns: pieSubLegend style

    static private func pieSubLegendStyle(settings: Settings, sizes: FontSizes) -> Styles {
        var pieSubLegend = Styles.from(settings: settings)
        pieSubLegend.cssClass = "piesublegend"
        pieSubLegend.fontColour = settings.colourValue(.pieLegend, in: .foreground) ?? .black
        pieSubLegend.fontSize = sizes.pieSubLegend.size
        return pieSubLegend
    }

    /// Set subTitle style
    /// - Parameters:
    ///   - settings: chart settings
    ///   - sizes: font sizes
    /// - Returns: subTitle style

    static private func subTitleStyle(settings: Settings, sizes: FontSizes) -> Styles {
        var subTitle = Styles.from(settings: settings)
        subTitle.cssClass = "subtitle"
        subTitle.fontColour = settings.colourValue(.subTitle, in: .foreground) ?? .black
        subTitle.fontSize = sizes.subTitle.size
        return subTitle
    }

    /// Set title style
    /// - Parameters:
    ///   - settings: chart settings
    ///   - sizes: font sizes
    /// - Returns: title style

    static private func titleStyle(settings: Settings, sizes: FontSizes) -> Styles {
        var title = Styles.from(settings: settings)
        title.cssClass = "title"
        title.fontColour = settings.colourValue(.title, in: .foreground) ?? .black
        title.fontSize = sizes.title.size
        return title
    }

    /// Set xLabel style
    /// - Parameters:
    ///   - settings: chart settings
    ///   - sizes: font sizes
    /// - Returns: xLabel style

    static private func xLabelStyle(settings: Settings, sizes: FontSizes) -> Styles {
        var xLabel = Styles.from(settings: settings)
        xLabel.colour =
            (settings.colourValue(.axes, in: .foreground) ?? .black).clamped(opacity: 0.4)
        xLabel.cssClass = "xlabel"
        xLabel.fontColour = settings.colourValue(.xLabel, in: .foreground) ?? .black
        xLabel.fontSize = sizes.label.size
        xLabel.strokeWidth = 1.0
        return xLabel
    }

    /// Set xTags style
    /// - Parameters:
    ///   - settings: chart settings
    ///   - sizes: font sizes
    /// - Returns: xTags style

    static private func xTagsStyle(settings: Settings, sizes: FontSizes) -> Styles {
        var xTags = Styles.from(settings: settings)
        xTags.colour =
            (settings.colourValue(.axes, in: .foreground) ?? .black).clamped(opacity: 0.4)
        xTags.cssClass = "xtags"
        xTags.fontColour = settings.colourValue(.xTags, in: .foreground) ?? .black
        xTags.fontSize = sizes.axes.size
        xTags.strokeWidth = 1.0
        return xTags
    }

    /// Set xTitle style
    /// - Parameters:
    ///   - settings: chart settings
    ///   - sizes: font sizes
    /// - Returns: xTitle style

    static private func xTitleStyle(settings: Settings, sizes: FontSizes) -> Styles {
        var xTitle = Styles.from(settings: settings)
        xTitle.cssClass = "xtitle"
        xTitle.fontColour = settings.colourValue(.xTitle, in: .foreground) ?? .black
        xTitle.fontSize = sizes.axes.size
        return xTitle
    }

    /// Set yLabel style
    /// - Parameters:
    ///   - settings: chart settings
    ///   - sizes: font sizes
    /// - Returns: yLabel style

    static private func yLabelStyle(settings: Settings, sizes: FontSizes) -> Styles {
        var yLabel = Styles.from(settings: settings)
        yLabel.colour =
            (settings.colourValue(.axes, in: .foreground) ?? .black).clamped(opacity: 0.4)
        yLabel.cssClass = "ylabel"
        yLabel.fontColour = settings.colourValue(.yLabel, in: .foreground) ?? .black
        yLabel.fontSize = sizes.label.size
        yLabel.strokeWidth = 1.0
        yLabel.textAlign = "end"
        yLabel.textBaseline = "middle"
        return yLabel
    }

    /// Set yTitle style
    /// - Parameters:
    ///   - settings: chart settings
    ///   - sizes: font sizes
    /// - Returns: yTitle style

    static private func yTitleStyle(settings: Settings, sizes: FontSizes) -> Styles {
        var yTitle = Styles.from(settings: settings)
        yTitle.cssClass = "ytitle"
        yTitle.fontColour = settings.colourValue(.yTitle, in: .foreground) ?? .black
        yTitle.fontSize = sizes.axes.size
        yTitle.textAlign = "start"
        return yTitle
    }
}

//
//  Options.swift
//  csv2
//
//  Created by Michael Salmon on 2021-03-08.
//

import Foundation
import OptGetter

private let canvasOpts: OptsToGet = [
    OptToGet(.canvas, 1...1, usage: "Canvas name", argTag: "<name>"),
    OptToGet(.canvastag, usage: "Print the canvas tag")
]

private let svgOpts: OptsToGet = [
    OptToGet(.css, 1...1, usage: "Include file for css styling", argTag: "<file>"),
    OptToGet(.cssid, 1...1, usage: "CSS id for SVG", argTag: "<name>"),
    OptToGet(.hover, usage: "Don't add CSS code to emphasize hovered plots"),
    OptToGet(.svg, 1...1, usage: "Include file for svg elements", argTag: "<file>")
]

private let commonOpts: OptsToGet = [
    OptToGet(.bared, 1...1, options: [.minusOK], usage: "Plots to show as bars", argTag: "<bitmap¹>"),
    OptToGet(.baroffset, 1...1, usage: "Bar offset (-1 to calculate)", argTag: "<offset>"),
    OptToGet(.barwidth, 1...1, usage: "Bar width (-1 to calculate)"),
    OptToGet(.bg, 1...1, usage: "Background colour", argTag: "<colour>"),
    OptToGet(.bitmap, 1...32, usage: "Convert a list of rows or columns to a bitmap", argTag: "<n>..."),
    OptToGet(.bezier, 1...1, usage: "Bézier curve smoothing, 0 means none", argTag: "<n>"),
    OptToGet(.black, usage: "Set undefined colours to black"),
    OptToGet(.bold, usage: "Set font-weight to bold"),
    OptToGet(.colourslist, usage: "Generate an image with all the colours on it"),
    OptToGet(.colournames, usage: "Print a list of all the colour names on it"),
    OptToGet(.colournameslist, usage: "Generate an image with all the colour names on it"),
    OptToGet(.colours, 1...255, options: [.multi], usage: "Colours to use for plots", argTag: "<colour>..."),
    OptToGet(.dashed, 1...1, options: [.minusOK], usage: "Plots with dashed lines", argTag: "<bitmap¹>"),
    OptToGet(.dashes, 1...255, usage: "List of plot dash patterns to use", argTag: "<n,n...>..."),
    OptToGet(.dasheslist, usage: "Generate an image with all the dashes on it"),
    OptToGet(.debug, short: "d", 1...1, usage: "Add debug info", argTag: "<bitmap¹>"),
    OptToGet(.distance, 1...1, usage: "Minimum distance between data points", argTag: "<n>"),
    OptToGet(.filled, 1...1, options: [.minusOK], usage: "Plots to show filled", argTag: "<bitmap¹>"),
    OptToGet(.font, 1...1, usage: "Font family", argTag: "<font name>"),
    OptToGet(.fg, 1...1, usage: "Foreground colour for non-text items", argTag: "<colour>"),
    OptToGet(.headers, 1...1, usage: "Header rows or columns", argTag: "<n>"),
    OptToGet(.height, 1...1, usage: "Chart height", argTag: "<n>"),
    OptToGet(.index, 1...1, usage: "Index row or column", argTag: "<n>"),
    OptToGet(.italic, usage: "Use an italic font"),
    OptToGet(.include, 1...1, options: [.minusOK], usage: "Plots to include, default all", argTag: "<bitmap¹>"),
    OptToGet(.logo, 1...1, usage: "Image URL for top right corner", argTag: "<url>"),
    OptToGet(.logx, usage: "Set abcissa to log"),
    OptToGet(.logy, usage: "Set ordinate to log"),
    OptToGet(.nameheader, 1...1, usage: "Plot name row or column", argTag: "<n>"),
    OptToGet(.names, 1...255, usage: "List of plot names", argTag: "<name>..."),
    OptToGet(.bounds, usage: "Don't check options for bounds"),
    OptToGet(.comment, usage: "Don't add csv2 comment to plot"),
    OptToGet(.legends, usage: "Don't include plot names, colours, dashes and shapes"),
    OptToGet(.opacity, 1...1, usage: "Opacity for plots"),
    OptToGet(.pie, usage: "Generate a pie chart"),
    OptToGet(
        .random, 1...3, options: [.minusOK],
        usage: "Generate a random SVG with: #plots [max value [min value]]", argTag: "<n [n [n]]>"
    ),
    OptToGet(
        .reserve, 1...4,
        usage: "Reserved space on the left [top [right [bottom]]]", argTag: "<n [n [n [n]]]>"
    ),
    OptToGet(.rows, usage: "Group data by rows"),
    OptToGet(
        .scattered, 1...1, options: [.minusOK],
        usage: "Plots to show as scatter plots", argTag: "<bitmap¹>"
    ),
    OptToGet(.semi, usage: "Use semicolons to seperate columns"),
    OptToGet(.shapes, 1...255, usage: "List of shapes to use", argTag: "<shape>..."),
    OptToGet(.shapenames, usage: "Print a list of shape names"),
    OptToGet(.show, 1...1, usage: "Generate a plot with the shape @ 6X strokewidth", argTag: "<shape>"),
    OptToGet(.showpoints, 1...1, options: [.minusOK], usage: "Data plots with points", argTag: "<bitmap¹>"),
    OptToGet(.size, 1...1, usage: "Base font size", argTag: "<n>"),
    OptToGet(.smooth, 1...1, usage: "EMA smoothing, 0 means none", argTag: "<n>"),
    OptToGet(.sortx, usage: "Sort points by the x values before plotting"),
    OptToGet(.stroke, 1...1, usage: "Stroke width", argTag: "<n>"),
    OptToGet(.subheader, 1...1, usage: "Sub-title row or column source", argTag: "<n>"),
    OptToGet(.subtitle, 1...1, usage: "Sub-title", argTag: "<text>"),
    OptToGet(.textcolour, 1...1, usage: "Foreground text colour", argTag: "<colour>"),
    OptToGet(.title, 1...1, usage: "Chart title", argTag: "<text>"),
    OptToGet(.tsv, usage: "Use tabs to seperate columns"),
    OptToGet(.verbose, short: "v", usage: "Add extra information"),
    OptToGet(.version, short: "V", usage: "Display version and exit"),
    OptToGet(.width, 1...1, usage: "Chart width", argTag: "<n>"),
    OptToGet(.xmax, 1...1, usage: "Abscissa maximum", argTag: "<n>"),
    OptToGet(.xmin, 1...1, usage: "Abscissa minimum", argTag: "<n>"),
    OptToGet(.xtags, 1...1, usage: "Row or column with abscissa tags", argTag: "<n>"),
    OptToGet(.xtick, 1...1, usage: "Distance between abcissa ticks", argTag: "<n>"),
    OptToGet(.ymax, 1...1, usage: "Ordinate maximum", argTag: "<n>"),
    OptToGet(.ymin, 1...1, usage: "Ordinate minimum", argTag: "<n>"),
    OptToGet(.ytick, 1...1, usage: "Distance between ordinate ticks", argTag: "<n>"),
]

struct Options {
    var bared = Defaults.global.bared
    var baroffset = Defaults.global.barOffset
    var barwidth = Defaults.global.barWidth
    var bg = Defaults.global.backgroundColour
    var bitmap: [Int] = []
    var bezier = Defaults.global.bezier
    var black = Defaults.global.black
    var bold = Defaults.global.bold
    var bounds = true
    var canvas = Defaults.global.canvasID
    var canvastag = false
    var colourslist = false
    var colournames = false
    var colournameslist = false
    var colours: [String] = []
    var comment = Defaults.global.comment
    var css = Defaults.global.cssInclude
    var cssid = Defaults.global.cssID
    var dashed = Defaults.global.dashedLines
    var dashes: [String] = []
    var dasheslist = false
    var debug = 0
    var distance = Defaults.global.dataPointDistance
    var filled = Defaults.global.filled
    var font = Defaults.global.fontFamily
    var fg = Defaults.global.foregroundColour
    var headers = Defaults.global.headers
    var height = Defaults.global.height
    var hover = Defaults.global.hover
    var index = Defaults.global.index
    var italic = Defaults.global.italic
    var include = Defaults.global.include
    var legends = Defaults.global.legends
    var logo = Defaults.global.logoURL
    var logx = Defaults.global.logx
    var logy = Defaults.global.logy
    var nameheader = Defaults.global.nameHeader
    var names: [String] = []
    var opacity = Defaults.global.opacity
    var pie = false
    var random: [Int] = []
    var reserve = [
        Defaults.global.reserveLeft,
        Defaults.global.reserveTop,
        Defaults.global.reserveRight,
        Defaults.global.reserveBottom
    ]
    var rows = Defaults.global.rowGrouping
    var scattered = Defaults.global.scattered
    var semi = false
    var shapes: [String] = []
    var shapenames = false
    var show: String = ""
    var showpoints = Defaults.global.showDataPoints
    var size = Defaults.global.baseFontSize
    var smooth = Defaults.global.smooth
    var sortx = Defaults.global.sortx
    var stroke = Defaults.global.strokeWidth
    var subheader = Defaults.global.index
    var subtitle: String = ""
    var svg = Defaults.global.svgInclude
    var textcolour = Defaults.global.textColour
    var title: String = ""
    var tsv = false
    var verbose = false
    var version = false
    var width = Defaults.global.width
    var xmax = Defaults.global.xMax
    var xmin = Defaults.global.xMin
    var xtags = Defaults.global.xTagsHeader
    var xtick = Defaults.global.xTick
    var ymax = Defaults.global.yMax
    var ymin = Defaults.global.yMin
    var ytick = Defaults.global.yTick

    // Positional parameters

    var csvName: String?
    var jsonName: String?
    var outName: String?

    // Indicator for options on the command line
    var onCommandLine: Set<Settings.CodingKeys> = []

    var separator: String {
        if tsv { return "\t" }
        if semi { return ";" }
        return ","
    }

    /// Fetch options from the command line
    /// - Parameter plotter: the type of chart to fet options for
    /// - Throws:
    ///   - OptGetterError.duplicateArgument
    ///   - OptGetterError.duplicateName
    ///   - OptGetterError.illegalValue
    ///   - OptGetterError.insufficientArguments
    ///   - OptGetterError.tooManyOptions
    ///   - OptGetterError.unknownName

    mutating func getOpts(for command: CommandType, _ args: [String] = CommandLine.arguments) throws {
        var opts = commonOpts
        switch command {
        case .canvas: opts += canvasOpts
        case .svg: opts += svgOpts
        default: break
        }

        do {
            let optGetter = try OptGetter(opts)
            let optsGot = try optGetter.parseArgs(args: args, command.optStart)
            for opt in optsGot {
                try getOpt(opt: opt)
            }
            switch optGetter.remainingValuesAt.count {
            case 3...:
                outName = getString(optGetter.remainingValuesAt[2], key: nil)
                fallthrough
            case 2:
                jsonName = getString(optGetter.remainingValuesAt[1], key: nil)
                fallthrough
            case 1:
                csvName = getString(optGetter.remainingValuesAt[0], key: nil)
            default:
                break
            }
        } catch {
            throw error
        }
    }
}

/// Get usage string for common options
/// - Returns: usage string

func commonUsage() -> String? {
    return OptGetter.usage(commonOpts, longFirst: true)
}

/// Get usage string for canvas
/// - Returns: usage string

func canvasUsage() -> String? {
    return OptGetter.usage(canvasOpts, longFirst: true)
}

/// Get usage string for PDF
/// - Returns: usage string

func pdfUsage() -> String? {
    return nil
}

/// Get usage for PNG charts
/// - Returns: usage string

func pngUsage() -> String? {
    return nil
}

/// Get usage for SVG charts
/// - Returns: usage string

func svgUsage() -> String? {
    return OptGetter.usage(svgOpts, longFirst: true)
}

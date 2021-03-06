//
//  OptsToGet.swift
//  csv2
//
//  Created by Michael Salmon on 2021-05-19.
//

import Foundation
import CLIparser

extension Options {
    static internal let canvasOpts: OptsToGet = [
        OptToGet(
            .stringValue(key: .canvasID, name: "canvas"), .single,
            usage: "Canvas name", argTag: "<name>"
        ),
        OptToGet(
            .stringValue(key: .tagFile, name: "tag"), .single, option: .hidden,
            usage: "File to write canvas tag to", argTag: "<file>"
        )
    ]

    static internal let helpOpts: OptsToGet = [
        OptToGet(
            .intSpecial(key: .indent, name: "indent"), .single,
            usage: "Indent for option usage", argTag: "<n>"
        ),
        OptToGet(
            .intSpecial(key: .left, name: "left"), .single,
            usage: "Left margin for help text", argTag: "<n>"
        ),
        OptToGet(.boolSpecial(key: .md, name: "md"), option: .hidden),
        OptToGet(
            .intSpecial(key: .right, name: "right"), .single,
            usage: "Right margin for text", argTag: "<n>"
        ),
        OptToGet(
            .intSpecial(key: .usage, name: "usage"), .single,
            usage: "Left margin for option usage", argTag: "<n>"
        )
    ]

    static internal let pdfOpts: OptsToGet = [
        OptToGet(
            .stringValue(key: .tagFile, name: "tag"), .single, option: .hidden,
            usage: "File to write pdf object tag to", argTag: "<file>"
        )
    ]

    static internal let svgOpts: OptsToGet = [
        OptToGet(
            .stringValue(key: .cssInclude, name: "css"), .single,
            usage: "Include file for css styling", argTag: "<file>"
        ),
        OptToGet(
            .stringValue(key: .cssID, name: "cssid"), .single,
            usage: "CSS id for <SVG> tag", argTag: "<id>"
        ),
        OptToGet(
            .boolValue(key: .hover, name: "hover"), option: .flag,
            usage: "Add CSS code to emphasize hovered plots, nohover to not add", env: "CVS2_HOVER"
        ),
        OptToGet(
            .stringValue(key: .svgInclude, name: "svg"), .single,
            usage: "Include file for svg elements", argTag: "<file>"
        )
    ]

    static internal let commonOpts: OptsToGet = [
        OptToGet(
            .bitmapValue(key: .bared, name: "bared"), .onePlus, option: .includeMinus,
            usage: "Plots to show as bars", argTag: "<bitmap¹>"
        ),
        OptToGet(
            .doubleValue(key: .barOffset, name: "baroffset"), .single,
            usage: "Bar offset (-1 to calculate)", argTag: "<offset>"
        ),
        OptToGet(
            .doubleValue(key: .barWidth, name: "barwidth"), .single,
            usage: "Bar width (-1 to calculate)"
        ),
        OptToGet(
            .colourValue(key: .backgroundColour, name: "bg"), .single,
            usage: "Background colour", argTag: "<colour>", env: "CSV2_BACKGROUND_COLOUR"
        ),
        OptToGet(
            .doubleValue(key: .bezier, name: "bezier"), .single,
            usage: "Bézier curve smoothing, 0 means none", argTag: "<n>", env: "CVS2_BEZIER"
        ),
        OptToGet(
            .boolValue(key: .black, name: "black"),
            usage: "Set undefined colours to black"
        ),
        OptToGet(
            .boolValue(key: .bold, name: "bold"),
            usage: "Set font-weight to bold"
        ),
        OptToGet(
            .boolValue(key: .bounded, name: "bounds"), option: .flag,
            usage: "Check options for bounds, nobounds to not check", env: "CVS2_BOUNDS"
        ),
        OptToGet(
            .stringValue(key: .chartType, name: "chart"), .single,
            usage: """
                The type of chart:
                horizontal - index values horizontal and plot values vertical,
                pie - a grid of pie chart plots or,
                vertical - a list of values, like a bar chart only vertical.
                A unique prefix is sufficient.
                """,
                argTag: "<type>"
        ),
        OptToGet(
            .colourArray(key: .colours, name: "colours"), aka: ["colors"], .onePlus, option: .multi,
            usage: "Colours to use for plots", argTag: "<colour>..."
        ),
        OptToGet(
            .boolValue(key: .comment, name: "comment"), option: .flag,
            usage: "Add csv2 comment to plot, nocomment to not add"
        ),
        OptToGet(
            .bitmapValue(key: .dashedLines, name: "dashed"), .onePlus, option: .includeMinus,
            usage: "Plots with dashed lines", argTag: "<bitmap¹>"
        ),
        OptToGet(
            .stringArray(key: .dashes, name: "dashes"), .onePlus,
            usage: "List of plot dash patterns to use", argTag: "<n,n...>..."
        ),
        OptToGet(
            .intSpecial(key: .debug, name: "debug"), .single,
            usage: "Add debug info", argTag: "<bitmap¹>"
        ),
        OptToGet(
            .doubleValue(key: .dataPointDistance, name: "distance"), .single,
            usage: "Minimum distance between data points", argTag: "<n>"
        ),
        OptToGet(
            .stringSpecial(key: .draft, name: "draft"), 0...1,
            usage: "Mark the chart as a draft,\nthe optional argument sets the text", argTag: "[text]"
        ),
        OptToGet(
            .bitmapValue(key: .filled, name: "filled"), .onePlus, option: .includeMinus,
            usage: "Plots to show filled", argTag: "<bitmap¹>"
        ),
        OptToGet(
            .stringValue(key: .fontFamily, name: "font"), .single,
            usage: "Font family", argTag: "<font name>", env: "CVS2_FONT_FAMILY"
        ),
        OptToGet(
            .colourValue(key: .foregroundColour, name: "fg"), .single,
            usage: "Foreground colour for non-text items", argTag: "<colour>", env: "CSV2_FOREGROUND_COLOUR"
        ),
        OptToGet(
            .intSpecial(key: .headers, name: "headers"), .single,
            usage: "Header rows or columns", argTag: "<n>"
        ),
        OptToGet(
            .intValue(key: .height, name: "height"), .single,
            usage: "Chart height", argTag: "<n>", env: "CSV2_HEIGHT"
        ),
        OptToGet(
            .bitmapValue(key: .include, name: "include"), .onePlus, option: .includeMinus,
            usage: "Plots to include, default all", argTag: "<bitmap¹>"
        ),
        OptToGet(
            .intValue(key: .index, name: "index"), .single,
            usage: "Index row or column", argTag: "<n>"
        ),
        OptToGet(
            .boolValue(key: .italic, name: "italic"),
            usage: "Use an italic font"
        ),
        OptToGet(
            .boolValue(key: .legends, name: "legends"), option: .flag,
            usage: "Show plot names, colours, dashes and shapes, nolegends to not"
        ),
        OptToGet(
            .stringValue(key: .logoURL, name: "logo"), .single,
            usage: "Image URL for top right corner", argTag: "<url>", env: "CSV2_LOGO_URL"
        ),
        OptToGet(
            .boolValue(key: .logx, name: "logx"),
            usage: "Set abcissa to log"
        ),
        OptToGet(
            .boolValue(key: .logy, name: "logy"),
            usage: "Set ordinate to log"
        ),
        OptToGet(
            .intValue(key: .nameHeader, name: "nameheader"), .single,
            usage: "Plot name row or column", argTag: "<n>"
        ),
        OptToGet(
            .stringArray(key: .names, name: "names"), .onePlus,
            usage: "List of plot names", argTag: "<name>..."
        ),
        OptToGet(
            .doubleValue(key: .opacity, name: "opacity"), .single,
            usage: "Opacity for plots"
        ),
        OptToGet(
            .bitmapValue(key: .showDataPoints, name: "pointed"), aka: ["datapoints", "showpoints"],
            .onePlus, option: .includeMinus, usage: "Data plots with points", argTag: "<bitmap¹>"
        ),
        OptToGet(
            .intSpecialArray(key: .random, name: "random"), 1...3, option: .includeMinus,
            usage: "Generate a random SVG with:\n#plots [max value [min value]]", argTag: "<n [n [n]]>"
        ),
        OptToGet(
            .doubleSpecialArray(key: .reserve, name: "reserve"), 1...4,
            usage: "Reserved space on the left [top [right [bottom]]]", argTag: "<n [n [n [n]]]>"
        ),
        OptToGet(
            .boolValue(key: .rowGrouping, name: "rows"),
            usage: "Group data by rows"
        ),
        OptToGet(
            .bitmapValue(key: .scatterPlots, name: "scattered"), .onePlus, option: .includeMinus,
            usage: "Plots to show as scatter plots", argTag: "<bitmap¹>"
        ),
        OptToGet(
            .boolSpecial(key: .semi, name: "semi"),
            usage: "Use semicolons to separate columns"
        ),
        OptToGet(
            .stringArray(key: .shapes, name: "shapes"), .onePlus,
            usage: "List of shapes to use", argTag: "<shape>..."
        ),
        OptToGet(
            .doubleValue(key: .baseFontSize, name: "size"), .single,
            usage: "Base font size", argTag: "<n>", env: "CSV2_BASE_FONT_SIZE"
        ),
        OptToGet(
            .doubleValue(key: .smooth, name: "smooth"), .single,
            usage: "EMA smoothing, 0 means none", argTag: "<n>"
        ),
        OptToGet(
            .boolValue(key: .sortx, name: "sortx"),
            usage: "Sort points by the x values before plotting"
        ),
        OptToGet(
            .bitmapValue(key: .stackedPlots, name: "stacked"), .onePlus, option: .includeMinus,
            usage: "Plots stacked", argTag: "<bitmap¹>"
        ),
        OptToGet(
            .doubleValue(key: .strokeWidth, name: "stroke"), .single,
            usage: "Stroke width", argTag: "<n>", env: "CSV2_STROKE_WIDTH"
        ),
        OptToGet(
            .intValue(key: .subTitleHeader, name: "subheader"), .single,
            usage: "Sub-title row or column source", argTag: "<n>"
        ),
        OptToGet(
            .stringValue(key: .subTitle, name: "subtitle"), .single,
            usage: "Sub-title", argTag: "<text>"
        ),
        OptToGet(
            .colourValue(key: .textcolour, name: "textcolour"), aka: ["textcolor"], .single,
            usage: "Foreground text colour", argTag: "<colour>", env: "CSV2_TEXT_COLOUR"
        ),
        OptToGet(
            .stringValue(key: .title, name: "title"), .single,
            usage: "Chart title", argTag: "<text>"
        ),
        OptToGet(
            .boolSpecial(key: .tsv, name: "tsv"),
            usage: "Use tabs to seperate columns"
        ),
        OptToGet(
            .boolSpecial(key: .verbose, name: "verbose"),
            usage: "Add extra information"
        ),
        OptToGet(
            .intValue(key: .width, name: "width"), .single,
            usage: "Chart width", argTag: "<n>", env: "CSV2_WIDTH"
        ),
        OptToGet(
            .doubleValue(key: .xMax, name: "xmax"), .single, option: .includeMinus,
            usage: "Abscissa maximum", argTag: "<n>"
        ),
        OptToGet(
            .doubleValue(key: .xMin, name: "xmin"), .single, option: .includeMinus,
            usage: "Abscissa minimum", argTag: "<n>"
        ),
        OptToGet(
            .intValue(key: .xTagsHeader, name: "xtags"), .single,
            usage: "Row or column with abscissa tags", argTag: "<n>"
        ),
        OptToGet(
            .doubleValue(key: .xTick, name: "xtick"), .single, option: .includeMinus,
            usage: "Distance between abcissa ticks", argTag: "<n>"
        ),
        OptToGet(
            .doubleValue(key: .yMax, name: "ymax"), .single, option: .includeMinus,
            usage: "Ordinate maximum", argTag: "<n>"
        ),
        OptToGet(
            .doubleValue(key: .yMin, name: "ymin"), .single, option: .includeMinus,
            usage: "Ordinate minimum", argTag: "<n>"
        ),
        OptToGet(
            .doubleValue(key: .yTick, name: "ytick"), .single, option: .includeMinus,
            usage: "Distance between ordinate ticks", argTag: "<n>"
        ),
        OptToGet(.boolSpecial(key: .help, name: "help"), option: .hidden),
        OptToGet(.boolSpecial(key: .help, name: "?"), option: .hidden)
    ]

    static internal let positionalOpts: OptsToGet = [
        OptToGet(usage: "CSV data file name or - for stdin", argTag: "<csv file>"),
        OptToGet(usage: "JSON settings file name", argTag: "<json file>"),
        OptToGet(usage: "Output file name,\nor stdout if omitted for canvas and svg", argTag: "<output file>")
    ]
}

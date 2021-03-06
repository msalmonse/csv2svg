//
//  Plot.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-04-06.
//

import Foundation

class Plot: ReflectedStringConvertible {
    // plot widths
    let strokeWidth: Double
    let shapeWidth: Double

    let csv: CSV
    let settings: Settings
    let plotter: Plotter

    // Row or column to use for x values
    let index: Int

    // The four sides of the data plane
    let dataPlane: Plane
    // the plot plane
    let plotPlane: Plane
    // the clipping plane
    let clipPlane: Plane
    // and the allowed drawing plain
    let allowedPlane: Plane

    /// Convert between the data plane and the plot plane
    let ts: TransScale

    /// The position of 0,0 or 1,1 if log scales
    let point00: Point

    // Plot area height and width
    let height: Double
    let width: Double

    // Positions for various elements
    let positions: Positions

    // Path Styles
    let stylesList: StylesList

    // StackedPlots related data
    let stackBar: Int?
    var stackPlotTop: [Double: Double] = [:]        // Top of stack in plotPlane
    var stackDataTop: [Double: Double] = [:]        // Top of stack in dataPlane

    // limit of distance between data points
    let limit: Double

    // log x and y axes
    var logx: Bool
    var logy: Bool

    // font sizes
    let sizes: FontSizes
    var axesSize: Double { return sizes.axes.size }
    var labelSize: Double { return sizes.label.size }
    var legendSize: Double { return sizes.legend.size }
    var pieLegendSize: Double { return sizes.pieLegend.size }
    var subTitleSize: Double { return sizes.subTitle.size }
    var titleSize: Double { return sizes.title.size }

    init(_ csv: CSV, _ settings: Settings, _ plotter: Plotter) {
        csv.valuesFill()
        self.csv = csv
        self.settings = settings
        self.plotter = plotter

        sizes = FontSizes(size: settings.doubleValue(.baseFontSize))

        self.index = settings.index
        height = settings.height
        shapeWidth = settings.shapeWidth
        strokeWidth = settings.strokeWidth
        width = settings.width
        allowedPlane = Plane(
            top: -0.5 * height, bottom: 1.5 * height,
            left: -0.5 * width, right: 1.5 * width
        )
        let dataPlane = settings.chartType.dataPlane(csv, settings)
        self.dataPlane = dataPlane

        positions = settings.chartType.positionsSelect(settings)

        limit = settings.doubleValue(.dataPointDistance)

        let margin = 2.0 * shapeWidth
        clipPlane = Plane(
            top: positions.topY - margin, bottom: positions.bottomY + margin,
            left: positions.leftX - margin, right: positions.rightX + margin
        )

        let plotPlane = Plane(
            top: positions.topY, bottom: positions.bottomY,
            left: positions.leftX, right: positions.rightX
        )
        self.plotPlane = plotPlane

        let logx = settings.boolValue(.logx) && dataPlane.left > 0.0
        self.logx = logx
        let logy = settings.boolValue(.logy) && dataPlane.bottom > 0.0
        self.logy = logy

        ts = TransScale(from: dataPlane, to: plotPlane, logx: logx, logy: logy)
        point00 = ts.pos(x: logx ? 1.0 : 0.0, y: logy ? 1.0 : 0.0)

        let plotCount = settings.chartType.plotCount(csv)
        let plotFirst = settings.chartType.plotFirst(settings)

        // Initialize path info
        var stylesList = StylesList(count: plotCount, settings: settings)

        // setup first so that the other functions can use them
        var stackBar = -1
        plotFlags(settings, plotFirst, plotCount, &stylesList.plots, &stackBar)
        self.stackBar = stackBar

        plotClasses(settings, plotFirst, plotCount, &stylesList.plots)
        plotColours(settings, plotFirst, plotCount, &stylesList.plots)
        plotDashes(settings, plotFirst, plotCount, plotPlane.width, &stylesList.plots)
        plotNames(settings, csv, plotFirst, plotCount, &stylesList.plots)
        plotShapes(settings, plotFirst, plotCount, index: settings.index, &stylesList.plots)
        self.stylesList = stylesList
    }
}

//
//  SVG/PlotInfo.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-10.
//

import Foundation

extension SVG {

    /// Generate a list of colours for the plots
    /// - Parameters:
    ///   - settings: settings for plot
    ///   - ct: number of plots
    /// - Returns: list of colours

    static func plotColours(
        _ settings: Settings,
        _ ct: Int,
        _ props: inout [PathProperties]
        ) {
        for i in 0..<ct {
            if i < settings.colours.count && settings.colours[i] != "" {
                props[i].colour = settings.colours[i]
            } else if settings.black {
                props[i].colour = "black"
            } else {
                props[i].colour = Colours.nextColour()
            }
        }
    }

    /// Generate a list of names for the plots
    /// - Parameters:
    ///   - settings: settings for plot
    ///   - ct: number of plots

    static func plotNames(
        _ settings: Settings,
        _ csv: CSV, _ ct: Int,
        _ props: inout [PathProperties]
    ) {
        for i in 0..<ct {
            if i < settings.names.count && settings.names[i] != "" {
                props[i].name = settings.names[i]
            } else if settings.headers > 0 {
                props[i].name = SVG.headerText(i, csv: csv, inColumns: settings.inColumns)
            } else {
                props[i].name = SVG.headerText(i, csv: nil, inColumns: settings.inColumns)
            }
        }
    }

    /// Generate a list of names for the plots
    /// - Parameters:
    ///   - settings: settings for plot
    ///   - ct: number of plots
    ///   - index: the row or column with the index
    /// - Returns: list of names

    static func plotShapes(
        _ settings: Settings,
        _ ct: Int, index: Int,
        _ props: inout [PathProperties]
        ) {
        for i in 0..<ct {
            // Don't attach a shape if we aren't a scatter plot or a plot with data points or are index
            if (settings.scattered(i) || settings.pointed(i)) && i != settings.index - 1 {
                if i < settings.shapes.count && settings.shapes[i] != "" {
                    props[i].shape = Shape.lookup(settings.shapes[i]) ?? Shape.nextShape()
                } else {
                    props[i].shape = Shape.nextShape()
                }
            }
        }
    }

    static func plotFlags(
        _ settings: Settings,
        _ ct: Int,
        _ props: inout [PathProperties]
    ) {
        for i in 0..<ct {
            let mask = 1 << i
            props[i].pointed = (settings.showDataPoints & mask) == mask
            props[i].scattered = (settings.scatterPlots & mask) == mask
        }
    }
}

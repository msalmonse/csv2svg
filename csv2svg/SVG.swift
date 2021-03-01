//
//  SVG.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-02-18.
//

import Foundation

class SVG {

    

    let csv: CSV
    let settings: Settings
    
    // Row or column to use for x values
    let index: Int
    
    // The four sides of the data plane
    let dataEdges: Plane
    // and the plot plane
    let plotEdges: Plane
    
    // path colours
    let colours: [String]
    
    // path tags
    let names: [String]

    // Tags
    let xmlTag = "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?>"
    var svgTag: String {
        get {
            return String(
                format: "<svg width=\"%d\" height=\"%d\" xmlns=\"http://www.w3.org/2000/svg\">",
                settings.width, settings.height
            )
        }
    }
    let svgTagEnd = "</svg>"

    init(_ csv: CSV, _ settings: Settings) {
        self.csv = csv
        self.settings = settings
        
        self.index = settings.index - 1
        
        dataEdges = SVG.sidesFromColumns(csv, settings)
        plotEdges = Plane(
            top: 10, bottom: Double(settings.height - (settings.title == "" ? 100 : 130)),
            left: 100, right: Double(settings.width)
        )
        
        // Initialize path columns
        let ct = settings.inColumns ? csv.colCt : csv.rowCt
        var colours: [String] = []
        var names: [String] = []
        for i in 0..<ct {
            if i < settings.colours.count && settings.colours[i] != "" {
                colours.append(settings.colours[i])
            } else {
                colours.append(SVG.Colours.nextColour())
            }
            if i < settings.names.count && settings.names[i] != "" {
                names.append(settings.names[i])
            } else if (settings.inColumns ? settings.headerRows : settings.headerColumns) > 0 {
                names.append(SVG.headerText(i, csv: csv, inColumn: settings.inColumns))
            } else {
                names.append("")
            }
        }
        self.colours = colours
        self.names = names
    }

    

    func svgLineGroup(_ ts: TransScale) -> [String] {
        var result = [ "<g clip-path=\"url(#plotable)\" >"]
        result.append(contentsOf: columnPlot(ts))
        result.append("</g>")
        result.append(svgAxes(ts))
        if settings.xTick > 0 { result.append(svgXtick(ts)) }
        if settings.yTick > 0 { result.append(svgYtick(ts)) }

        return result
    }
    
    func gen() -> [String] {
        let ts = TransScale(from: dataEdges, to: plotEdges)

        var result: [String] = [ xmlTag, svgTag ]
        result.append(contentsOf: svgDefs())
        result.append(contentsOf: svgLineGroup(ts))
        result.append(svgLegends(Double(settings.width)/2.0, plotEdges.bottom + 50.0, size: 15))
        if settings.title != "" { result.append(svgTitle()) }
        result.append(svgTagEnd)
        
        return result
    }
}

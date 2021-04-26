//
//  Pie.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-26.
//

import Foundation

extension Plot {

    func plotPie(_ row: Int, _ col1: Int, x: Double = 1.0) {
        let pi2e6 = Double.pi * 2.0e6
        var arcLeft = pi2e6
        var start = 0.0
        let centre = ts.pos(x: x, y: plotPlane.vMid)
        let radius = plotPlane.height/2.5

        let pieValues = csv.rowValues(row, from: col1)
        var sum = pieValues.reduce(0.0) { $0 + ($1 ?? 0) }
        for col in pieValues.indices {
            if let val = pieValues[col] {
                let angle6 = min(round(arcLeft * val/sum), arcLeft)
                sum -= val
                arcLeft -= angle6
                let end = start + angle6/2.0e6
                let path = Path(
                    [
                        .arcAround(centre: centre, radius: radius, start: start, end: end),
                        .lineTo(xy: centre),
                        .z
                    ]
                )
                start = end
                plotter.plotPath(path, props: propsList.plots[col], fill: true)
            }
        }
    }
}

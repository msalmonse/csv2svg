//
//  JSplotter.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-09.
//

import Foundation

extension JS {
    func plotGroup(lines: String) -> String {
        return lines
    }

    func plotHead(positions: Positions, plotPlane: Plane, propsList: PropertiesList) -> String {
        let id = settings.plotter.canvasID
        return """
            const canvas = document.getElementById('\(id)');
            if (canvas.getContext) {
                const ctx = canvas.getContext('2d');
            """
    }

    func plotRect(_ plane: Plane, rx: Double, props: Properties) -> String {
        return ""
    }

    func plotTail() -> String {
        return "}"
    }

    func plotText(x: Double, y: Double, text: String, props: Properties) -> String {
        return ""
    }
}

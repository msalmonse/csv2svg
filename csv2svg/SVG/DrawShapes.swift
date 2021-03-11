//
//  DrawShapes.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-11.
//

import Foundation

extension SVG.PathCommand {

    func drawCircle(r: Double) -> String {
        return [
            Self.moveBy(dx: 0, dy: -r),
            .arc(rx: r, ry: r, rot: 0, large: true, sweep: true, dx: 0.0, dy: 2 * r),
            .arc(rx: r, ry: r, rot: 0, large: true, sweep: true, dx: 0.0, dy: -2 * r),
            .moveBy(dx: 0, dy: r)
        ].map { $0.command()}.joined(separator: " ")
    }

    func drawCross(w: Double) -> String {
        let half = w/2.0
        return [
            Self.moveBy(dx: -half, dy: -half),
            .vertBy(dy: -half), .horizBy(dx: w), .vertBy(dy: half),     // top
            .horizBy(dx: half), .vertBy(dy: w), .horizBy(dx: -half),    // right
            .vertBy(dy: half), .horizBy(dx: -w), .vertBy(dy: -half),    // bottom
            .horizBy(dx: -half), .vertBy(dy: -w), .horizBy(dx: half),   // left
            .moveBy(dx: half, dy: half)
        ].map { $0.command()}.joined(separator: " ")
    }

    func drawDiamond(w: Double) -> String {
        return [
            Self.moveBy(dx: -w, dy: 0.0),
            .lineBy(dx: w, dy: -w),
            .lineBy(dx: w, dy: w),
            .lineBy(dx: -w, dy: w),
            .lineBy(dx: -w, dy: -w),
            .moveBy(dx: w, dy: 0.0)
        ].map { $0.command()}.joined(separator: " ")
    }

    func drawSquare(w: Double) -> String {
        let w2 = w * 2.0
        return [
            Self.moveBy(dx: -w, dy: -w),
            .horizBy(dx: w2),
            .vertBy(dy: w2),
            .horizBy(dx: -w2),
            .vertBy(dy: -w2),
            .moveBy(dx: w, dy: w)
        ].map { $0.command()}.joined(separator: " ")

    }

}

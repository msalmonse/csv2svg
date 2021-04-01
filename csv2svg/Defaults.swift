//
//  Defaults.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-08.
//

import Foundation

// App defaults

struct Defaults {
    static let maxDefault = -Double.infinity
    static let minDefault = Double.infinity

    let backgroundColour: String
    let baseFontSize: Double
    let black: Bool
    let bold: Bool
    let colours: [String]
    let comment: Bool
    let cssClasses: [String]
    let cssExtras: [String]
    let cssID: String
    let cssInclude: String
    let dashedLines: Int
    let dashes: [String]
    let dataPointDistance: Double
    let fontFamily: String
    let headers: Int
    let height: Int
    let hover: Bool
    let include: Int
    let index: Int
    let italic: Bool
    let legends: Bool
    let logoHeight: Double
    let logoURL: String
    let logoWidth: Double
    let logx: Bool
    let logy: Bool
    let nameHeader: Int
    let names: [String]
    let opacity: Double
    let reserveBottom: Double
    let reserveLeft: Double
    let reserveRight: Double
    let reserveTop: Double
    let rowGrouping: Bool
    let scattered: Int
    let shapes: [String]
    let showDataPoints: Int
    let sortx: Bool
    let smooth: Double
    let strokeWidth: Double
    let subTitle: String
    let subTitleHeader: Int
    let svgInclude: String
    let title: String
    let width: Int
    let xMax: Double
    let xMin: Double
    let xTick: Double
    let yMax: Double
    let yMin: Double
    let yTick: Double

    static let global = Defaults(
        backgroundColour: "",
        baseFontSize: 10.0,
        black: false,
        bold: false,
        colours: [],
        comment: true,
        cssClasses: [],
        cssExtras: [],
        cssID: "",
        cssInclude: "",
        dashedLines: 0,
        dashes: [],
        dataPointDistance: 10.0,
        fontFamily: "",
        headers: 0,
        height: 600,
        hover: true,
        include: -1,
        index: 0,
        italic: false,
        legends: true,
        logoHeight: 64.0,
        logoURL: "",
        logoWidth: 64.0,
        logx: false,
        logy: false,
        nameHeader: 1,
        names: [],
        opacity: 1.0,
        reserveBottom: 0.0,
        reserveLeft: 0.0,
        reserveRight: 0.0,
        reserveTop: 0.0,
        rowGrouping: false,
        scattered: 0,
        shapes: [],
        showDataPoints: 0,
        sortx: false,
        smooth: 0.0,
        strokeWidth: 2.0,
        subTitle: "",
        subTitleHeader: 0,
        svgInclude: "",
        title: "",
        width: 800,
        xMax: Self.maxDefault,
        xMin: Self.minDefault,
        xTick: 0.0,
        yMax: Self.maxDefault,
        yMin: Self.minDefault,
        yTick: 0.0
    )
}

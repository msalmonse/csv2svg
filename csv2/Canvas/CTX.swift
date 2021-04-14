//
//  CTX.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-09.
//

import Foundation

/// Cache of changes in canvas context

struct CTX {
    var dash = ""
    var fillStyle = ""
    var font = ""
    var lineCap = ""
    var lineWidth = 0.0
    var strokeStyle = ""
    var textAlign = ""
    var textBaseline = ""
    var transform = ""

    mutating func syncOneDouble(
        key: WritableKeyPath<CTX, Double>, _ val: Double, _ jsKey: String, result: inout [String]
    ) {
        if self[keyPath: key] != val {
            self[keyPath: key] = val
            result.append("ctx.\(jsKey) = \(val.f(1))")
        }
    }

    mutating func syncOneString(
        key: WritableKeyPath<CTX, String>, _ val: String, _ jsKey: String, result: inout [String]
    ) {
        if self[keyPath: key] != val {
            self[keyPath: key] = val
            result.append("ctx.\(jsKey) = '\(val)'")
        }
    }
}

/// Convert the alignment from Plot into canvas values
/// - Parameter textAlign: textAlign from Plot
/// - Returns: JS textAlign

fileprivate func jsAlign(_ textAlign: String) -> String {
    switch textAlign {
    case "middle": return "center"
    default: return textAlign
    }
}

/// Create a font specification from the props
/// - Parameter props: Properties
/// - Returns: Font specification

fileprivate func propsFontSpec(from props: Properties) -> String {
    var spec: [String] = []
    if props.italic { spec.append("italic") }
    if props.bold { spec.append("bold") }
    spec.append("\(props.cascade(.fontSize).f(1))px")
    spec.append(props.cascade(.fontFamily) ?? "serif")

    return spec.joined(separator: " ")
}

extension CTX {

    /// Sync context with properties
    /// - Parameters:
    ///   - props: properties to sync
    ///   - result: javascript statemants
    ///   - isText: Use the text related properties

    mutating func sync(_ props: Properties, _ result: inout [String], isText: Bool = false) {
        if isText {
            let colour = props.cascade(.fontColour) ?? "black"
            self.syncOneString(key: \.fillStyle, colour, "fillStyle", result: &result)

            let fontSpec = propsFontSpec(from: props)
            self.syncOneString(key: \.font, fontSpec, "font", result: &result)

            let textAlign = jsAlign(props.cascade(.textAlign) ?? "start")
            self.syncOneString(key: \.textAlign, textAlign, "textAlign", result: &result)

            let textBaseline = props.cascade(.textBaseline) ?? "alphabetic"
            self.syncOneString(key: \.textBaseline, textBaseline, "textBaseline", result: &result)
        } else {
            let colour = props.cascade(.colour) ?? "transparent"
            self.syncOneString(key: \.strokeStyle, colour, "strokeStyle", result: &result)

            let dashPattern = props.cascade(.dash) ?? ""
            if dashPattern != dash {
                dash = dashPattern
                result.append("ctx.setLineDash([\(dash)])")
            }

            let fill = props.cascade(.fill) ?? "transparent"
            self.syncOneString(key: \.fillStyle, fill, "fillStyle", result: &result)

            let strokeWidth = props.cascade(.strokeWidth)
            self.syncOneDouble(key: \.lineWidth, strokeWidth, "lineWidth", result: &result)

            let strokeLineCap = props.cascade(.strokeLineCap) ?? "round"
            self.syncOneString(key: \.lineCap, strokeLineCap, "lineCap", result: &result)
        }
        let transformMatrix = props.transform?.csv ?? ""
        if transformMatrix != transform {
            transform = transformMatrix
            result.append("ctx.setTransform(\(transform))")
        }
    }

    /// Reset any transorm that is active
    /// - Parameter result: JS to reset the transform

    mutating func resetTransform( _ result: inout [String]) {
        if transform.hasContent {
            transform = ""
            result.append("ctx.resetTransform()")
        }
    }
}
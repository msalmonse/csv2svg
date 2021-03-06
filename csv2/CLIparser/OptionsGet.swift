//
//  OptionsGet.swift
//  csv2
//
//  Created by Michael Salmon on 2021-05-16.
//

import Foundation
import CLIparser

extension Options {

    private static let boolValues = [
        "yes":  true,
        "true": true,
        "1": true,
        "no": false,
        "false": false,
        "0": false
    ]

    func boolValue(_ opt: OptGot, fromEnvironment: Bool, val0: OptValueAt) throws -> Bool {
        if !fromEnvironment { return opt.count > 0 }
        if let val = Options.boolValues[(opt.stringValue ?? "").lowercased()] { return val }
        throw val0.error("Boolean")
    }

    /// Assign an option from the command line
    /// - Parameter opt: the opt to assign
    /// - Throws: CLIparserError.illegalValue

    mutating func getOpt(opt: OptGot, fromEnvironment: Bool = false) throws {
        // swiftlint:disable:next force_cast
        let optTag = opt.tag as! OptionsKey
        let val0 = opt.optValuesAt.hasIndex(0) ? opt.optValuesAt[0] : OptValueAt.empty

        switch optTag {
        case let .bitmapValue(key, _): try setBitmap(opt.optValuesAt, key: key)
        case let .boolSpecial(key, _):
            switch key {
            case .help: helpAndExit()
            case .md:
                markdown = true
                UsageLeftRight.setMarkDown()
            case .semi: semi = true
            case .tsv: tsv = true
            case .verbose: verbose = true
            }
        case let .boolValue(key, _):
            setBool(try boolValue(opt, fromEnvironment: fromEnvironment, val0: val0), key: key)
        case let .colourArray(key, _): try setColourArray(opt.optValuesAt, key: key)
        case let .colourValue(key, _): try setColour(val0, key: key)
        case .doubleArray: break
        case let .doubleSpecialArray(key, _):
            switch key {
            case .reserve:
                switch opt.optValuesAt.count {
                case 4:
                    try setDouble(opt.optValuesAt[3], key: .reserveBottom)
                    fallthrough
                case 3:
                    try setDouble(opt.optValuesAt[2], key: .reserveRight)
                    fallthrough
                case 2:
                    try setDouble(opt.optValuesAt[1], key: .reserveTop)
                    fallthrough
                case 1:
                    try setDouble(opt.optValuesAt[0], key: .reserveLeft)
                default: throw val0.error("Double Array")
                }
            }
        case let .doubleValue(key, _): try setDouble(val0, key: key)
        case let .intSpecial(key, _):
            switch key {
            case .debug: debug = try val0.intValue()
            case .headers:
                try setInt(val0, key: .headerColumns)
                try setInt(val0, key: .headerRows)
            case .indent: UsageLeftRight.setIndent(try val0.intValue())
            case .left: UsageLeftRight.setLeft(try val0.intValue())
            case .right: UsageLeftRight.setRight(try val0.intValue())
            case .usage: UsageLeftRight.setUsage(try val0.intValue())
            }
        case let .intSpecialArray(key, _):
            switch key {
            case .random: random = try OptValueAt.intArray(opt.optValuesAt)
            }
        case let .intValue(key, _): try setInt(val0, key: key)
        case .positionalValues: setPositional(OptValueAt.stringArray(opt.optValuesAt))
        case let .stringArray(key, _): setStringArray(opt.optValuesAt, key: key)
        case let .stringSpecial(key, _):
            switch key {
            case .draft:
                setBool(true, key: .draft)
                if !val0.isEmpty { setString(val0, key: .draftText) }
            }
        case let .stringValue(key, _): setString(val0, key: key)
        }
    }

    /// Set the positional parameters
    /// - Parameter values: array of strings

    mutating func setPositional(_ values: [String]) {
        switch values.count {
        case 3:
            outName = values[2]
            fallthrough
        case 2:
            jsonName = values[1]
            fallthrough
        case 1:
            csvName = values[0]
        default:
            break
        }
    }

    func helpAndExit() {
        help(HelpCommandType.help, self)
        exit(0)
    }
}

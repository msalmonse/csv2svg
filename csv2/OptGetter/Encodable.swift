//
//  Encodable.swift
//  csv2
//
//  Created by Michael Salmon on 2021-05-27.
//

import Foundation
import OptGetter

struct encodable: Encodable {
    enum CodingKeys: CodingKey { case commands, arguments, options }

    let commands: [String: CmdsToGet] = [
        "main": plotCmds,
        "show": plotSubCmds,
        "list": listCmds,
        "help": helpCmds
    ]
    let arguments = Options.positionalOpts
    let options: [String: OptsToGet] = [
        "canvas": Options.canvasOpts,
        "common": Options.commonOpts,
        "help": Options.helpOpts,
        "svg": Options.svgOpts
    ]

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(commands, forKey: .commands)
        try container.encode(arguments, forKey: .arguments)
        try container.encode(options, forKey: .options)
    }
}
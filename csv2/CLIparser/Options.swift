//
//  Options.swift
//  csv2
//
//  Created by Michael Salmon on 2021-03-08.
//

import Foundation
import CLIparser

/// The main object for parsing the command line arguments

struct Options {
    let argsList = ArgumentList(options: [.longOnly])
    var debug = 0
    var markdown = false       // add ``` etc to usage
    var random: [Int] = []
    var semi = false
    var tsv = false
    var verbose = false

    // Positional parameters

    var csvName: String?
    var jsonName: String?
    var outName: String?

    // Defaults
    var values = Defaults()

    var separator: String {
        if tsv { return "\t" }
        if semi { return ";" }
        return ","
    }

    /// Fetch options from the command line
    /// - Parameters:
    ///   - command: the main command, used to select the option set
    /// - Throws:
    ///   - CLIparserError.duplicateArgument
    ///   - CLIparserError.duplicateName
    ///   - CLIparserError.illegalValue
    ///   - CLIparserError.insufficientArguments
    ///   - CLIparserError.tooManyOptions
    ///   - CLIparserError.unknownName

    mutating func getOpts(for command: MainCommandType) throws {
        var opts = Self.commonOpts
        switch command {
        case .canvas: opts += Self.canvasOpts
        case .help: opts = Self.helpOpts
        case .pdf: opts += Self.pdfOpts
        case .svg: opts += Self.svgOpts
        default: break
        }

        let envGot = environmentParse(opts)
        for opt in envGot {
            try getOpt(opt: opt, fromEnvironment: true)
        }

        let optsGot = try argsList.optionsParse(opts, OptionsKey.positionalValues)
        for opt in optsGot {
            try getOpt(opt: opt)
        }
    }

    /// Create defaults from command line
    /// - Returns: defaults

    func defaults() -> Defaults {
        return values
    }

    /// Fetch options from the command line, exit on error
    /// - Parameters:
    ///   - command: the main command, used to select the option set
    ///   - start: argument to begin with

    mutating func getOptsOrExit(for command: MainCommandType) {
        do {
            try getOpts(for: command)
        } catch {
            print(error, to: &standardError)
            exit(1)
        }
    }
}

/// Get usage string for common options
/// - Returns: usage string

func commonOptsUsage() -> String? { return optUsage(Options.commonOpts) }

/// Get usage string for canvas
/// - Returns: usage string

func canvasOptsUsage() -> String? { return optUsage(Options.canvasOpts) }

/// Get usage string for help options
/// - Returns: usage string

func helpOptsUsage() -> String? { return optUsage(Options.helpOpts) }

/// Get usage string for PDF
/// - Returns: usage string

func pdfOptsUsage() -> String? { return optUsage(Options.pdfOpts) }

/// Get usage for PNG charts
/// - Returns: usage string

func pngOptsUsage() -> String? { return nil }

/// Get usage for SVG charts
/// - Returns: usage string

func svgOptsUsage() -> String? { return optUsage(Options.svgOpts) }

/// Get usage for positional parameters
/// - Returns: usage string

func positionalArgsUsage() -> String? { return positionalUsage(Options.positionalOpts) }

/// Wrap text
/// - Parameter text: text to wrap
/// - Returns: wrapped text

func textWrap(_ text: String) -> String { return textWrap([text]) }

/// Wrap text array
/// - Parameter text: Array of strings
/// - Returns: wrapped text

func textWrap(_ text: [String]) -> String { return paragraphWrap(text) }

/// Wrap text with indent
/// - Parameter text: text to wrap
/// - Returns: indented wrapped text

func indentedTextWrap(_ text: String) -> String { return indentedTextWrap([text]) }

/// Wrap text array with indent
/// - Parameter text: Array of strings
/// - Returns: indented wrapped text

func indentedTextWrap(_ text: [String]) -> String { return indentedParagraphWrap(text) }

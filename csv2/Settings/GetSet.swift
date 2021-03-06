//
//  GetSet.swift
//  csv2
//
//  Created by Michael Salmon on 2021-05-28.
//

import Foundation

extension Settings {

    /// Set a value in the SettingsValues dict
    /// - Parameters:
    ///   - key: key in domain
    ///   - value: value to store
    ///   - domain: domain for key

    func setValue(_ key: Settings.CodingKeys, _ value: SettingsValue, in domain: DomainKey = .topLevel) {
        values.setValue(key, value, in: domain)
    }

    /// Fetch a BitMap value
    /// - Parameters:
    ///   - key: key in domain
    ///   - domain: domain for key
    /// - Returns: Bool value

    func bitmapValue(_ key: Settings.CodingKeys, in domain: DomainKey = .topLevel) -> BitMap {
        return values.bitmapValue(key, in: domain)
    }

    /// Fetch a Bool value
    /// - Parameters:
    ///   - key: key in domain
    ///   - domain: domain for key
    /// - Returns: Bool value

    func boolValue(_ key: Settings.CodingKeys, in domain: DomainKey = .topLevel) -> Bool {
        return values.boolValue(key, in: domain)
    }

    /// Fetch a Colour value
    /// - Parameters:
    ///   - key: key in domain
    ///   - domain: domain for key
    /// - Returns: String value

    func colourValue(_ key: Settings.CodingKeys, in domain: DomainKey = .topLevel) -> RGBAu8? {
        return values.colourValue(key, in: domain)
    }

    /// Fetch a Colour array
    /// - Parameters:
    ///   - key: key in domain
    ///   - domain: domain for key
    /// - Returns: String array

    func colourArray(_ key: Settings.CodingKeys, in domain: DomainKey = .topLevel) -> [RGBAu8]? {
        return values.colourArray(key, in: domain)
    }

    /// Fetch a Double value
    /// - Parameters:
    ///   - key: key in domain
    ///   - domain: domain for key
    /// - Returns: Double value

    func doubleValue(_ key: Settings.CodingKeys, in domain: DomainKey = .topLevel) -> Double {
        return values.doubleValue(key, in: domain)
    }

    /// Check string for content
    /// - Parameters:
    ///   - key: key in domain
    ///   - domain: domain for key
    /// - Returns: True is string is found and not empty

    func hasContent(_ key: Settings.CodingKeys, in domain: DomainKey = .topLevel) -> Bool {
        return values.hasContent(key, in: domain)
    }

    /// Fetch an Int Array
    /// - Parameters:
    ///   - key: key in domain
    ///   - domain: domain for key
    /// - Returns: Int Array

    func intArray(_ key: Settings.CodingKeys, in domain: DomainKey = .topLevel) -> [Int] {
        return values.intArray(key, in: domain)
    }

    /// Fetch an Int value
    /// - Parameters:
    ///   - key: key in domain
    ///   - domain: domain for key
    /// - Returns: Int value

    func intValue(_ key: Settings.CodingKeys, in domain: DomainKey = .topLevel) -> Int {
        return values.intValue(key, in: domain)
    }

    /// Lookup String value
    /// - Parameters:
    ///   - key: key in domain
    ///   - domain: domain for key
    /// - Returns: String from dict or nil if missing

    func optionalStringValue(_ key: Settings.CodingKeys, in domain: DomainKey = .topLevel) -> String? {
        return values.optionalStringValue(key, in: domain)
    }

    /// Fetch a String value
    /// - Parameters:
    ///   - key: key in domain
    ///   - domain: domain for key
    /// - Returns: String value

    func stringValue(_ key: Settings.CodingKeys, in domain: DomainKey = .topLevel) -> String {
        return values.stringValue(key, in: domain)
    }

    /// Fetch a String array
    /// - Parameters:
    ///   - key: key in domain
    ///   - domain: domain for key
    /// - Returns: String array

    func stringArray(_ key: Settings.CodingKeys, in domain: DomainKey = .topLevel) -> [String] {
        return values.stringArray(key, in: domain)
    }
}

//
//  ColourTranslate.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-12.
//

import Foundation

struct ColourTranslate {
    fileprivate static let name2rgba = [
        "aliceblue":            RGBAu8(r: 240, g: 248, b: 255),
        "antiquewhite":         RGBAu8(r: 250, g: 235, b: 215),
        "aqua":                 RGBAu8(r: 0, g: 240, b: 255),
        "aquamarine":           RGBAu8(r: 127, g: 255, b: 212),
        "azure":                RGBAu8(r: 240, g: 255, b: 255),
        "beige":                RGBAu8(r: 245, g: 245, b: 220),
        "bisque":               RGBAu8(r: 255, g: 228, b: 196),
        "black":                .black,
        "blanchedalmond":       RGBAu8(r: 255, g: 235, b: 205),
        "blue":                 RGBAu8(r: 0, g: 0, b: 255),
        "blueviolet":           RGBAu8(r: 138, g: 43, b: 226),
        "brown":                RGBAu8(r: 165, g: 42, b: 42),
        "buff":                 RGBAu8(r: 240, g: 220, b: 130),
        "burlywood":            RGBAu8(r: 222, g: 184, b: 135),
        "cadetblue":            RGBAu8(r: 95, g: 158, b: 160),
        "celeste":              RGBAu8(u24: 0xb2ffff),
        "chartreuse":           RGBAu8(r: 127, g: 255, b: 0),
        "chocolate":            RGBAu8(r: 210, g: 105, b: 30),
        "clear":                .clear,
        "coral":                RGBAu8(r: 255, g: 127, b: 80),
        "cornflowerblue":       RGBAu8(r: 100, g: 149, b: 237),
        "cornsilk":             RGBAu8(r: 255, g: 248, b: 220),
        "crimson":              RGBAu8(r: 220, g: 20, b: 60),
        "cyan":                 RGBAu8(r: 0, g: 255, b: 255),
        "darkblue":             RGBAu8(r: 0, g: 0, b: 139),
        "darkbuff":             RGBAu8(r: 151, g: 102, b: 56),
        "darkcyan":             RGBAu8(r: 0, g: 139, b: 139),
        "darkgold":             RGBAu8(u24: 0xeebc1d),
        "darkgoldenrod":        RGBAu8(r: 184, g: 134, b: 11),
        "darkgray":             RGBAu8(r: 169, g: 169, b: 169),
        "darkgrey":             RGBAu8(r: 169, g: 169, b: 169),
        "darkgreen":            RGBAu8(r: 0, g: 100, b: 0),
        "darkkhaki":            RGBAu8(r: 189, g: 183, b: 107),
        "darkivory":            RGBAu8(u24: 0xf2e58f),
        "darkmagenta":          RGBAu8(r: 139, g: 0, b: 139),
        "darkmustard":          RGBAu8(r: 0x7c, g: 0x7c, b: 0x40),
        "darkolivegreen":       RGBAu8(r: 85, g: 107, b: 47),
        "darkorange":           RGBAu8(r: 255, g: 140, b: 0),
        "darkorchid":           RGBAu8(r: 153, g: 50, b: 204),
        "darkred":              RGBAu8(r: 139, g: 0, b: 0),
        "darkpink":             RGBAu8(r: 0xe7, g: 0x54, b: 0x80),
        "darksalmon":           RGBAu8(r: 233, g: 150, b: 122),
        "darkseagreen":         RGBAu8(r: 143, g: 188, b: 143),
        "darksilver":           RGBAu8(r: 175, g: 175, b: 175),
        "darkslateblue":        RGBAu8(r: 72, g: 61, b: 139),
        "darkslategray":        RGBAu8(r: 47, g: 79, b: 79),
        "darkslategrey":        RGBAu8(r: 47, g: 79, b: 79),
        "darkturquoise":        RGBAu8(r: 0, g: 206, b: 209),
        "darkviolet":           RGBAu8(r: 148, g: 0, b: 211),
        "darkyellow":           RGBAu8(r: 255, g: 0xcc, b: 0),
        "deeppink":             RGBAu8(r: 255, g: 20, b: 147),
        "deepskyblue":          RGBAu8(r: 0, g: 191, b: 255),
        "dimgray":              RGBAu8(r: 105, g: 105, b: 105),
        "dodgerblue":           RGBAu8(r: 30, g: 144, b: 255),
        "firebrick":            RGBAu8(r: 178, g: 34, b: 34),
        "floralwhite":          RGBAu8(r: 255, g: 250, b: 240),
        "forestgreen":          RGBAu8(r: 34, g: 139, b: 34),
        "fuschia":              RGBAu8(r: 255, g: 0, b: 255),
        "gainsboro":            RGBAu8(r: 220, g: 220, b: 220),
        "ghostwhite":           RGBAu8(r: 248, g: 248, b: 255),
        "gold":                 RGBAu8(r: 255, g: 215, b: 0),
        "goldenrod":            RGBAu8(r: 218, g: 165, b: 32),
        "gray":                 .grey,
        "green":                RGBAu8(r: 0, g: 128, b: 0),
        "greenyellow":          RGBAu8(r: 173, g: 255, b: 47),
        "grey":                 .grey,
        "honeydew":             RGBAu8(r: 240, g: 255, b: 240),
        "hotpink":              RGBAu8(r: 255, g: 105, b: 180),
        "indianred":            RGBAu8(r: 205, g: 92, b: 92),
        "indigo":               RGBAu8(r: 75, g: 0, b: 130),
        "ivory":                RGBAu8(r: 255, g: 255, b: 240),
        "khaki":                RGBAu8(r: 240, g: 230, b: 140),
        "lavender":             RGBAu8(r: 230, g: 230, b: 250),
        "lavenderblush":        RGBAu8(r: 255, g: 240, b: 245),
        "lawngreen":            RGBAu8(r: 124, g: 252, b: 0),
        "lemonchiffon":         RGBAu8(r: 255, g: 250, b: 205),
        "lightblack":           .grey,
        "lightblue":            RGBAu8(r: 173, g: 216, b: 230),
        "lightbuff":            RGBAu8(r: 0xec, g: 0xd9, b: 0xb0),
        "lightcoral":           RGBAu8(r: 240, g: 128, b: 128),
        "lightcyan":            RGBAu8(r: 224, g: 255, b: 255),
        "lightgold":            RGBAu8(r: 0xf1, g: 0xe5, b: 0xac),
        "lightgoldenrod":       RGBAu8(r: 255, g: 236, b: 139),
        "lightgoldenrodyellow": RGBAu8(r: 250, g: 250, b: 210),
        "lightgray":            RGBAu8(r: 211, g: 211, b: 211),
        "lightgreen":           RGBAu8(r: 144, g: 238, b: 144),
        "lightgrey":            RGBAu8(r: 211, g: 211, b: 211),
        "lightivory":           RGBAu8(r: 255, g: 248, b: 201),
        "lightmagenta":         RGBAu8(r: 255, g: 119, b: 255),
        "lightmustard":         RGBAu8(r: 0xee, g: 0xdd, b: 0x62),
        "lightorange":          RGBAu8(r: 0xd9, g: 0xa4, b: 0x65),
        "lightpink":            RGBAu8(r: 255, g: 182, b: 193),
        "lightred":             RGBAu8(r: 255, g: 51, b: 51),
        "lightsalmon":          RGBAu8(r: 255, g: 160, b: 122),
        "lightseagreen":        RGBAu8(r: 32, g: 178, b: 170),
        "lightsilver":          RGBAu8(r: 225, g: 225, b: 225),
        "lightskyblue":         RGBAu8(r: 135, g: 206, b: 250),
        "lightslategray":       RGBAu8(r: 119, g: 136, b: 153),
        "lightslategrey":       RGBAu8(r: 119, g: 136, b: 153),
        "lightsteelblue":       RGBAu8(r: 176, g: 196, b: 222),
        "lightviolet":          RGBAu8(r: 0x7a, g: 0x52, b: 0x99),
        "lightyellow":          RGBAu8(r: 255, g: 255, b: 224),
        "limegreen":            RGBAu8(r: 50, g: 205, b: 50),
        "linen":                RGBAu8(r: 250, g: 240, b: 230),
        "magenta":              RGBAu8(r: 255, g: 0, b: 255),
        "maroon":               RGBAu8(r: 128, g: 0, b: 0),
        "mediumaquamarine":     RGBAu8(r: 102, g: 205, b: 170),
        "mediumblue":           RGBAu8(r: 0, g: 0, b: 205),
        "mediumorchid":         RGBAu8(r: 186, g: 85, b: 211),
        "mediumpurple":         RGBAu8(r: 147, g: 112, b: 219),
        "mediumseagreen":       RGBAu8(r: 60, g: 179, b: 113),
        "mediumslateblue":      RGBAu8(r: 123, g: 104, b: 238),
        "mediumspringgreen":    RGBAu8(r: 0, g: 250, b: 154),
        "mediumturquoise":      RGBAu8(r: 72, g: 209, b: 204),
        "mediumvioletred":      RGBAu8(r: 199, g: 21, b: 133),
        "midnightblue":         RGBAu8(r: 25, g: 25, b: 112),
        "mintcream":            RGBAu8(r: 245, g: 255, b: 250),
        "mistyrose":            RGBAu8(r: 255, g: 228, b: 225),
        "moccasin":             RGBAu8(r: 255, g: 228, b: 181),
        "mustard":              RGBAu8(u24: 0xffb558),
        "navajowhite":          RGBAu8(r: 255, g: 222, b: 173),
        "navy":                 RGBAu8(r: 0, g: 0, b: 128),
        "oldlace":              RGBAu8(r: 253, g: 245, b: 230),
        "olive":                RGBAu8(r: 128, g: 128, b: 0),
        "olivedrab":            RGBAu8(r: 107, g: 142, b: 35),
        "orange":               RGBAu8(r: 255, g: 165, b: 0),
        "orangered":            RGBAu8(r: 255, g: 69, b: 0),
        "orchid":               RGBAu8(r: 218, g: 112, b: 214),
        "palegoldenrod":        RGBAu8(r: 238, g: 232, b: 170),
        "palegreen":            RGBAu8(r: 152, g: 251, b: 152),
        "paleturquoise":        RGBAu8(r: 174, g: 238, b: 238),
        "palevioletred":        RGBAu8(r: 219, g: 112, b: 147),
        "papayawhip":           RGBAu8(r: 255, g: 239, b: 213),
        "peru":                 RGBAu8(r: 205, g: 133, b: 63),
        "pink":                 RGBAu8(r: 255, g: 192, b: 203),
        "plum":                 RGBAu8(r: 221, g: 160, b: 221),
        "powderblue":           RGBAu8(r: 176, g: 224, b: 230),
        "purple":               RGBAu8(r: 128, g: 0, b: 128),
        "rebeccapurple":        RGBAu8(r: 102, g: 51, b: 153),
        "red":                  RGBAu8(r: 255, g: 0, b: 0),
        "rosybrown":            RGBAu8(r: 188, g: 143, b: 143),
        "royalblue":            RGBAu8(r: 65, g: 105, b: 225),
        "saddlebrown":          RGBAu8(r: 139, g: 69, b: 19),
        "salmon":               RGBAu8(r: 250, g: 128, b: 114),
        "sandybrown":           RGBAu8(r: 244, g: 164, b: 96),
        "seagreen":             RGBAu8(r: 46, g: 139, b: 87),
        "seashell":             RGBAu8(r: 255, g: 245, b: 238),
        "sienna":               RGBAu8(r: 160, g: 82, b: 45),
        "silver":               RGBAu8(r: 192, g: 192, b: 192),
        "skyblue":              RGBAu8(r: 135, g: 206, b: 235),
        "slateblue":            RGBAu8(r: 106, g: 90, b: 205),
        "slategray":            RGBAu8(r: 112, g: 128, b: 144),
        "slategrey":            RGBAu8(r: 112, g: 128, b: 144),
        "snow":                 RGBAu8(r: 255, g: 250, b: 250),
        "springgreen":          RGBAu8(r: 0, g: 255, b: 127),
        "steelblue":            RGBAu8(r: 70, g: 130, b: 180),
        "tan":                  RGBAu8(r: 210, g: 180, b: 140),
        "teal":                 RGBAu8(r: 0, g: 128, b: 128),
        "thistle":              RGBAu8(r: 223, g: 191, b: 216),
        "tomato":               RGBAu8(r: 255, g: 99, b: 71),
        "transparent":          .clear,
        "turquoise":            RGBAu8(r: 64, g: 224, b: 208),
        "violet":               RGBAu8(r: 238, g: 130, b: 238),
        "wheat":                RGBAu8(r: 245, g: 222, b: 179),
        "white":                .white,
        "whitesmoke":           RGBAu8(r: 245, g: 245, b: 245),
        "yellow":               RGBAu8(r: 255, g: 255, b: 0),
        "yellowgreen":          RGBAu8(r: 154, g: 205, b: 50)
    ]

    static var all: [String] { name2rgba.keys.map { $0 }.sorted() }

    /// Lookup name in dictionary
    /// - Parameter name: name to lookup
    /// - Returns: Corresponding RGBAu8 value or nil

    static func lookup(_ name: String) -> RGBAu8? { return name2rgba[name] }
}

//
//  SketchGen
//
//  Copyright (c) 2020-Present Omar Albeik - https://github.com/omaralbeik
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

/// Defines a RGBA color value
struct Color: Codable, Classable {
    static let _class = "color"

    let alpha: UnitInterval
    let red: UnitInterval
    let green: UnitInterval
    let blue: UnitInterval
    let hex: String

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        alpha = try container.decode(UnitInterval.self, forKey: .alpha)
        red = try container.decode(UnitInterval.self, forKey: .red)
        green = try container.decode(UnitInterval.self, forKey: .green)
        blue = try container.decode(UnitInterval.self, forKey: .blue)

        let components = [red, green, blue, alpha].map { Int($0 * 255.0) }
        hex = String(format: "#%02X%02X%02X%02X", components[0], components[1], components[2], components[3])
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(alpha, forKey: .alpha)
        try container.encode(red, forKey: .red)
        try container.encode(green, forKey: .green)
        try container.encode(blue, forKey: .blue)
        try container.encode(hex, forKey: .hex)
    }

    private enum CodingKeys: String, CodingKey {
        case alpha, blue, green, red, hex
    }
}

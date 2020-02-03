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

import Foundation

extension Collection where Element == Artboard {
    func colors() -> Context.Colors {
        let prefix = "gen_color_"
        return Set(compactMap {
            guard let rect = $0.layers.rectangles.first else { return nil }
            guard rect.name.isValidKey else { return nil }
            guard rect.name.starts(with: prefix) else { return nil }
            guard let color = rect.style?.fills?.first?.color else { return nil }
            return Pair<Color>(name: rect.name.dropping(prefix: prefix), value: color)
        })
    }

    func shadows() -> Context.Shadows {
        let prefix = "gen_shadow_"
        return Set(compactMap {
            guard let rect = $0.layers.rectangles.first else { return nil }
            guard rect.name.isValidKey else { return nil }
            guard rect.name.starts(with: prefix) else { return nil }
            guard let shadow = rect.style?.shadows?.first else { return nil }
            return Pair<Shadow>(name: rect.name.dropping(prefix: prefix), value: shadow)
        })
    }

    func radiuses() -> Context.Radiuses {
        let prefix = "gen_radius_"
        return Set(compactMap {
            guard let rect = $0.layers.rectangles.first else { return nil }
            guard rect.name.isValidKey else { return nil }
            guard rect.name.starts(with: prefix) else { return nil }
            let radius = rect.fixedRadius
            return Pair<Double>(name: rect.name.dropping(prefix: prefix), value: radius)
        })
    }

    func borders() -> Context.Borders {
        let prefix = "gen_border_"
        return Set(compactMap {
            guard let rect = $0.layers.rectangles.first else { return nil }
            guard rect.name.isValidKey else { return nil }
            guard rect.name.starts(with: prefix) else { return nil }
            guard let border = rect.style?.borders?.first else { return nil }
            return Pair<Border>(name: rect.name.dropping(prefix: prefix), value: border)
        })
    }

    func fonts() -> Context.Fonts {
        let prefix = "gen_font_"
        return Set(compactMap {
            guard let text = $0.layers.texts.first else { return nil }
            guard text.name.isValidKey else { return nil }
            guard text.name.starts(with: prefix) else { return nil }
            guard let attributes = text.style?.textStyle?.encodedAttributes else { return nil }
            let descriptor = attributes.MSAttributedStringFontAttribute
            return Pair<FontDescriptor>(name: text.name.dropping(prefix: prefix), value: descriptor)
        })
    }
}

private extension String {
    var isValidKey: Bool {
        let allowedSet = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_")
        return rangeOfCharacter(from: allowedSet.inverted) == nil
    }

    func dropping(prefix: String) -> String {
        guard hasPrefix(prefix) else { return self }
        return String(dropFirst(prefix.count))
    }
}

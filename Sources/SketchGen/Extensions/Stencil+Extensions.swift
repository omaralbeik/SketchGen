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
import Stencil

final class StencilExtensions: Extension {

    override init() {
        super.init()

        registerFilter("readable", filter: readable)
        registerFilter("camelcased", filter: camelcased)
        registerFilter("snakecased", filter: snakecased)
    }

    private func snakecased(_ input: Any?) -> Any? {
        return input
    }

    private func readable(_ input: Any?) -> Any? {
        guard let stringInput = input as? String else { return nil }
        return stringInput.replacingOccurrences(of: "_", with: " ")
    }

    private func camelcased(_ input: Any?) -> Any? {
        guard let stringInput = input as? String else { return nil }
        let source = stringInput.lowercased()
        let first = source[..<source.index(after: source.startIndex)]
        if source.contains("_") {
            let connected = source.capitalized.replacingOccurrences(of: "_", with: "")
            return first + String(connected.dropFirst())
        }
        let rest = String(source.dropFirst())
        return first + rest
    }
}

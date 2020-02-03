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
import PathKit
import SwiftCLI

protocol SketchParser: VerboseLogger, PackageAvailabilityChecker {
    var verbose: Bool { get }
    func extractContext(from page: Page) -> Context
    func extractContext(fromSketchFileAtPath sourcePath: Path) throws -> Context
}

extension SketchParser {
    var verbose: Bool { VerboseFlag.value }

    func extractContext(from page: Page) -> Context {
        log("Extracting context object from page '\(page.name)':")
        let colors = page.layers.artboards.colors()
        let shadows = page.layers.artboards.shadows()
        let radiuses = page.layers.artboards.radiuses()
        let fonts = page.layers.artboards.fonts()
        let borders = page.layers.artboards.borders()
        let context = Context(colors: colors, shadows: shadows, radiuses: radiuses, fonts: fonts, borders: borders)
        logContents(of: context)
        return context
    }

    func extractContext(fromSketchFileAtPath sourcePath: Path) throws -> Context {
        log("Started parsing \(sourcePath.absolute())")
        let pages = try unzipSketchFile(atPath: sourcePath)

        var context = Context()
        for page in pages {
            context += extractContext(from: page)
        }

        log("Grouping context objects from all pages:")
        logContents(of: context)

        return context
    }

    private func unzipSketchFile(atPath sourcePath: Path) throws -> [Page] {
        guard isPackageAvailable("unzip") else {
            throw CLI.Error(message: "Error: Missing dependency, make sure 'unzip' is installed")
        }

        let tempPath = try Path.processUniqueTemporary()
        do {
            let output = try Task.capture(
                "/usr/bin/unzip",
                "-o", sourcePath.description,
                "-d", tempPath.absolute().description
            )
            log(output.stdout)
        } catch {
            throw CLI.Error(message: "Error: The provided sketch file is invalid")
        }

        log("Unzipped sketch file to \(tempPath)")

        guard let pagesPath = tempPath.glob("pages").first else {
            throw CLI.Error(message: "Error: The provided sketch file is invalid")
        }

        let decoder = JSONDecoder()
        let paths = try pagesPath.children()
        let data = try paths.map { try $0.read() }
        let pages = try data.map { try decoder.decode(Page.self, from: $0) }
        log("Found \(pages.count) pages in sketch file")
        for page in pages {
            log(page.name, indentationLevel: 1)
        }
        return pages
    }

    private func logContents(of context: Context) {
        if !context.colors.isEmpty {
            log("\(context.colors.count) colors", indentationLevel: 1)
        }
        if !context.shadows.isEmpty {
            log("\(context.shadows.count) shadows", indentationLevel: 1)
        }
        if !context.radiuses.isEmpty {
            log("\(context.radiuses.count) radiuses", indentationLevel: 1)
        }
        if !context.fonts.isEmpty {
            log("\(context.fonts.count) fonts", indentationLevel: 1)
        }
        if !context.borders.isEmpty {
            log("\(context.borders.count) borders", indentationLevel: 1)
        }
    }
}

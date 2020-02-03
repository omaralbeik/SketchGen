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
import Stencil
import SwiftCLI

final class GenerateCommand: Command, SketchParser, VerboseLogger, PackageAvailabilityChecker {

    let name = "generate"
    let shortDescription = "Generate source code from a sketch file or a context json file"

    @Param var source: String
    @Param var destination: String
    @Param var templates: String

    @Flag("-s", "--sketch", description: "Generate source code from a sketch file")
    var isSketchFile: Bool

    @Flag("-c", "--context", description: "Generate source code from a pre-generated context json file")
    var isContext: Bool

    func execute() throws {
        guard isSketchFile || isContext else {
            throw CLI.Error(message: "Error: Use '-s' or '-c' to specify the source type")
        }

        let destPath = Path(destination)
        if !destPath.exists {
            try destPath.mkdir()
        }

        guard destPath.isDirectory else {
            throw CLI.Error(message: "Error: \(destPath) is an invalid path")
        }

        var context = Context()

        if isContext {
            let decoder = JSONDecoder()
            let data = try Path(source).read()
            context = try decoder.decode(Context.self, from: data)
        }

        if isSketchFile {
            context = try extractContext(fromSketchFileAtPath: Path(source))
        }

        try generateSourceCode(in: destPath, using: context)
        log("Done generating source code!, check \(destination)")
    }

    private func generateSourceCode(in destination: Path, using context: Context) throws {
        let environment = Environment(loader: FileSystemLoader(paths: [Path(templates)]), extensions: [StencilExtensions()])

        let templateFiles = try Path(templates).children()

        log("Exporting templates:")
        for file in templateFiles {
            guard let rendered = try? environment.renderTemplate(name: file.lastComponent, context: context.dict) else { continue }
            let output = destination + file.lastComponent
            try output.write(rendered)
            log(output.description, indentationLevel: 1)
        }
    }
}

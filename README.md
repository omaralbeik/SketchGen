# SketchGen

SketchGen is a command line tool written in Swift that generates source code from sketch files.

## Features

- ✅ Extract assets from a Sketch file including: colors (RGBA and HEX), shadows, fonts, borders, and radius values
- ✅ Multi-page Sketch file parsing
- ✅ Extract assets into a simple JSON file for easier interaction with other 3rd party tools
- ✅ Generate Readable, `snake_cased`, and `camelCased`, `UPPERCASED`, `lowercased`, and `Capitalized` names
- ✅ Use a templating system to generate source code for any programming language using your preferred style
- ✅ Generate from anywhere including Linux and on CI

## tl;dr

SketchGen + [Example/styles.sketch](https://github.com/omaralbeik/SketchGen/blob/master/Example/styles.sketch) + [Example/templates](https://github.com/omaralbeik/SketchGen/tree/master/Example/templates) = [Example/Generated](https://github.com/omaralbeik/SketchGen/tree/master/Example/Generated)

## Installation

### Homebrew (recommended)

```sh
brew tap omaralbeik/formulae
brew install sketchgen
```

### [Mint](https://github.com/yonaskolb/Mint)

```sh
mint install omaralbeik/SketchGen
```

### Make

```sh
git clone https://github.com/omaralbeik/SketchGen.git
cd SketchGen
make install
```

### Swift Package Manager

#### Use as CLI

```sh
git clone https://github.com/omaralbeik/SketchGen.git
cd SketchGen
swift run sketchgen
```

#### Use as dependency

Add the following to your Package.swift file's dependencies:

```swift
.package(url: "https://github.com/omaralbeik/SketchGen.git", from: "0.1.0"),
```

And then import wherever needed: import SketchGen

## Usage

### Parse a Sketch file

```sh
sketchkit parse <.sketch file path> <destination path>

# Example:
## Parse a a file named styles.sketch in Desktop and create a context.json in Desktop
sketchkit parse ~/Desktop/styles.sketch ~/Desktop
```

### Generate source code

#### From .sketch file

```sh
sketchkit generate -s <.sketch file path> <destination path> <templates folder path>

# Example:
## Parse a file named styles.sketch in Desktop and create source code
## in Desktop/Generated, using templates in /Desktop/templates folder:
sketchkit generate -s ~/Desktop/styles.sketch ~/Desktop/Generated ~/Desktop/templates
```

#### From pre-generated context.json file

```sh
sketchkit generate -c <context.json file path> <destination path> <templates folder path>

# Example:
## Parse a context file named context.json in Desktop and create source code
## in Desktop/Generated, using templates in /Desktop/templates folder:
sketchkit generate -c ~/Desktop/context.json ~/Desktop/Generated ~/Desktop/templates
```

### Flags

|          |                 |                            |
|:---------|:----------------|:---------------------------|
| **`-v`** | **`--verbose`** | Log tech details for nerds |
| **`-h`** | **`--help`**    | Show help information      |

## A word about conventions in your Sketch file

SketchGen expect the followingin your Sketch file:

- Sketch file with **1 or more** pages
- Each page should have **1 or more** artboards
- Each artboard should have **exactly 1** rectangle or text layer
- layer names **can have only english letters, numbers and _** and follow the following conventions:

| Layer Type   | Prefix            | Valid Name Examples                          | Invalid Name Examples                                 |
|:-------------|:------------------|:---------------------------------------------|:------------------------------------------------------|
| **`Color`**  | **`gen_color_`**  | `gen_color_primary`, `gen_color_dark_blue`   | `primary`, `gen_color primary`, `gen_color_dark blue` |
| **`Shadow`** | **`gen_shadow_`** | `gen_shadow_small`, `gen_shadow_extra_large` | `small`, `gen_shadow small`, `gen_shadow_extra large` |
| **`Font`**   | **`gen_font_`**   | `gen_font_body`, `gen_font_heading_1`        | `body`, `gen_font body`, `gen_font_heading 1`         |
| **`Border`** | **`gen_border_`** | `gen_border_small`, `gen_border_extra_large` | `small`, `gen_border small`, `gen_border_extra large` |
| **`Radius`** | **`gen_radius_`** | `gen_radius_small`, `gen_radius_extra_large` | `small`, `gen_radius small`, `gen_radius_extra large` |

> See [Example/styles.sketch](https://github.com/omaralbeik/SketchGen/blob/master/Example/styles.sketch) for an example.

### Source code templates

Templates are written in [Stencil templating language](https://github.com/stencilproject/Stencil).

On top of Stencil's [built-in filters](http://stencil.fuller.li/en/latest/builtins.html#built-in-filters), `snakecased` and `camelcased` filters are added for more flexible source code generation.

> See [Example/templates](https://github.com/omaralbeik/SketchGen/tree/master/Example/templates) for examples for Swift, ObjC, CSS, and XML templates.

## Attributions

### This tool is powered by

- [SwiftCLI](https://github.com/jakeheis/SwiftCLI)
- [Stencil](https://github.com/stencilproject/Stencil)
- [PathKit](https://github.com/kylef/PathKit)
- [Sketch File Format](https://github.com/sketch-hq/sketch-file-format)

### Thanks

- [Mattt](https://twitter.com/mattt) for his great post [Swift Program Distribution with Homebrew](https://nshipster.com/homebrew/)
- [Yonas Kolb](https://github.com/yonaskolb) for his very organized README and scripts in [XcodeGen](https://github.com/yonaskolb/XcodeGen) that I ended up copying most of it 😅

## Contact

Omar Albeik

- [omaralbeik.com](https://omaralbeik.com)
- [twitter.com/omaralbeik](https://twitter.com/omaralbeik)

## License

SketchGen is released under the MIT license. See [LICENSE](https://github.com/omaralbeik/SketchGen/blob/master/LICENSE) for more information.

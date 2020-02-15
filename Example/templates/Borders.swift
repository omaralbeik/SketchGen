// Generated using SketchGen

import UIKit

public struct Border {
    public let color: UIColor
    public let thickness: CGFloat
}

public extension CALayer {
    func applyBorder(_ border: Border) {
        borderColor = border.color.cgColor
        borderWidth = border.thickness
    }
}

public enum Borders {
    {% for border in borders %}
    /// {{ border.name|readable|capitalize }}
    public static let {{ border.name|camelcased }} = Border(
        color: UIColor(red: {{ border.value.color.red }}, green: {{ border.value.color.green }}, blue: {{ border.value.color.blue }}, alpha: {{ border.value.color.alpha }}),
        thickness: {{ border.value.thickness }}
    )
    {% endfor %}
}
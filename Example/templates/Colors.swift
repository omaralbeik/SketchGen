// Generated using SketchGen

import UIKit

public enum Colors {
    {% for color in colors %}
    /// {{ color.name|readable|capitalize }} ({{ color.value.hex }})
    public static let {{ color.name|camelcased }} = UIColor(
        r: {{ color.value.red }},
        g: {{ color.value.green }},
        b: {{ color.value.blue }},
        a: {{ color.value.alpha }}
    )
    {% endfor %}
}
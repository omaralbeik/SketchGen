// Generated using SketchGen

import UIKit

public enum Radiuses {
    {% for radius in radiuses %}
    /// {{ radius.name|readable|capitalize }} ({{ radius.value }})
    public static let {{ radius.name|camelcased }}: CGFloat = {{ radius.value }}
    {% endfor %}
}
// Generated using SketchGen

import UIKit

public struct Radiuses {
    private init() {}
    {% for radius in radiuses %}
    /// {{ radius.name|readable|capitalize }} ({{ radius.value }})
    public static let {{ radius.name|camelcased }}: CGFloat = {{ radius.value }}
    {% endfor %}
}
// Generated using SketchGen

import UIKit

public enum Fonts {
    {% for font in fonts %}
    /// {{ font.name|readable|capitalize }} ({{ font.value.attributes.name }}:{{ font.value.attributes.size }})
    public static let {{ font.name|camelcased }} = UIFont(name: "{{ font.value.attributes.name }}", size: {{ font.value.attributes.size }})
    {% endfor %}
}
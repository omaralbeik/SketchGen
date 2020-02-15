// Generated using SketchGen

import UIKit

public struct Shadow {
    public let color: UIColor
    public let offset: CGSize
    public let radius: CGFloat
    public let opacity: Float
}

public extension CALayer {
    func applyShadow(_ shadow: Shadow) {
        shadowColor = shadow.color.cgColor
        shadowOffset = shadow.offset
        shadowRadius = shadow.radius
        shadowOpacity = shadow.opacity
        masksToBounds = false
        shouldRasterize = true
        rasterizationScale = UIScreen.main.scale
    }
}

public enum Shadows {
    {% for shadow in shadows %}
    /// {{ shadow.name|readable|capitalize }}
    public let {{ shadow.name|camelcased }} = Shadow(
        color: UIColor(red: {{ shadow.value.color.red }}, green: {{ shadow.value.color.green }}, blue: {{ shadow.value.color.blue }}, alpha: {{ shadow.value.color.alpha }}),
        offset: CGSize(width: {{ shadow.value.offsetX }}, height: {{ shadow.value.offsetY }}),
        radius: {{ shadow.value.blurRadius }},
        opacity: {{ shadow.value.contextSettings.opacity }}
    )
    {% endfor %}
}
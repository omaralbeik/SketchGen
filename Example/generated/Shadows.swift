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
    
    /// Level 4
    public let level4 = Shadow(
        color: UIColor(red: 0, green: 0, blue: 0, alpha: 0.24),
        offset: CGSize(width: 0, height: 48),
        radius: 56,
        opacity: 1
    )
    
    /// Level 2
    public let level2 = Shadow(
        color: UIColor(red: 0, green: 0, blue: 0, alpha: 0.1),
        offset: CGSize(width: 0, height: 8),
        radius: 16,
        opacity: 1
    )
    
    /// Level 0
    public let level0 = Shadow(
        color: UIColor(red: 1, green: 1, blue: 1, alpha: 0),
        offset: CGSize(width: 0, height: 0),
        radius: 0,
        opacity: 1
    )
    
    /// Level 1
    public let level1 = Shadow(
        color: UIColor(red: 0, green: 0, blue: 0, alpha: 0.12),
        offset: CGSize(width: 0, height: 4),
        radius: 9,
        opacity: 1
    )
    
    /// Level 3
    public let level3 = Shadow(
        color: UIColor(red: 0, green: 0, blue: 0, alpha: 0.1),
        offset: CGSize(width: 0, height: 15),
        radius: 20,
        opacity: 1
    )
    
}
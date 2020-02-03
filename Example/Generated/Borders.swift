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

public struct Borders {
    private init() {}
    
    /// Zero
    public static let zero = Border(
        color: UIColor(red: 0, green: 0, blue: 0, alpha: 1),
        thickness: 0
    )
    
    /// Small
    public static let small = Border(
        color: UIColor(red: 0, green: 0, blue: 0, alpha: 1),
        thickness: 2
    )
    
    /// Medium
    public static let medium = Border(
        color: UIColor(red: 0, green: 0, blue: 0, alpha: 1),
        thickness: 4
    )
    
    /// Xs
    public static let xs = Border(
        color: UIColor(red: 0, green: 0, blue: 0, alpha: 1),
        thickness: 1
    )
    
    /// Large
    public static let large = Border(
        color: UIColor(red: 0, green: 0, blue: 0, alpha: 1),
        thickness: 8
    )
    
}
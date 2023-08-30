//
//  UIColor+Custom.swift
//  test
//
//  Created by Diana Nikulina on 30.08.2023.
//

import UIKit

extension UIColor {
    static var background: UIColor? {
        UIColor(hex: "#19212C")
    }
    
    static var active: UIColor? {
        UIColor(hex: "#00FF0A")
    }
    
    static var inactive: UIColor? {
        UIColor(hex: "#F00000")
    }
    
    static var text: UIColor? {
        UIColor(hex: "#19212C")
    }
    
    static var under: UIColor? {
        UIColor(hex: "#232198")
    }
    
    static var skeletonBackground: UIColor? {
        UIColor(hex: "#3F4956")
    }
    
    static var skeletonAccent: UIColor {
        UIColor(red: 25 / 255, green: 33 / 255, blue: 44 / 255, alpha: 0.5)
    }
    
    static var topGradient: UIColor {
        guard let color = UIColor(hex: "#AB69FF") else {
            return .purple
        }
        return color
    }
    
    static var bottomGradient: UIColor {
        guard let color = UIColor(hex: "#494BEB") else {
            return .blue
        }
        return color
    }
}

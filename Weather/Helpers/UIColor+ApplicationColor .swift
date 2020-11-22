//
//  UIColor.swift
//  Weather
//
//  Created by Гусейн Агаев on 22.11.2020.
//

import UIKit

extension UIColor {
    
    // MARK: - Initialization
    
    convenience init(hex: UInt, alpha: CGFloat = 1.0) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(hex & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    // MARK: - ApplicationColor
    
    struct ApplicationСolor {
        static var background: [UIColor]  { return [UIColor(hex: 0xFFC371), UIColor(hex: 0xFF5F6D)]  }
        static var interfaceUnit: UIColor { return UIColor(hex: 0x000000, alpha: 0.5) }
        
        static var textColor: UIColor { return UIColor(hex: 0xFFFFFF, alpha: 0.9) }
        static var mainText: UIColor { return UIColor(hex: 0x000000) }
        static var complementaryColor: UIColor { return UIColor(hex: 0x00BFFF) }
        static var textFieldBackground: UIColor { return UIColor(hex: 0xFFFFFF, alpha: 0.5) }

        static var buttonText: UIColor { return UIColor(hex: 0x1DE5E2) }
        static var buttonBackground: [UIColor] { return [UIColor(hex: 0xCB3066), UIColor(hex: 0x00BFFF)] }
    }
}

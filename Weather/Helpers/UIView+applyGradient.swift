//
//  UIView+applyGradient.swift
//  Weather
//
//  Created by Гусейн Агаев on 22.11.2020.
//

import UIKit

// MARK: - UIView
extension UIView {
    
    // MARK: - Public Method
    
    func applyGradient(colours: [UIColor]) -> Void {
        self.applyGradient(colours: colours, locations: nil)
    }
    
    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> Void {
        let gradient: CAGradientLayer = CAGradientLayer()
        
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
    }
}

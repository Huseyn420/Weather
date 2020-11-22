//
//  UIViewController+errorMessages.swift
//  Weather
//
//  Created by Гусейн Агаев on 22.11.2020.
//

import UIKit

// MARK: - UIView
extension UIViewController {
    
    // MARK: - Public Method
    
    func errorMessages(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        present(alert, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.4) {
          alert.dismiss(animated: true, completion: nil)
        }
    }
}

//
//  UIImageView.swift
//  App Commission
//
//  Created by Camilo Oscar Girardelli Baptista on 21/06/23.
//

import Foundation
import UIKit

extension UIImageView {
    func loadFrom(URLAddress: String) {
        guard let url = URL(string: URLAddress) else {
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                        self?.image = loadedImage
                    self?.layer.cornerRadius = 15
                }
            }
        }
    }
}

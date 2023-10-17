//
//  CustomRoundedShadowView.swift
//  App Commission
//
//  Created by Alexandre Gois on 21/06/23.
//

import Foundation
import UIKit

class CustomRoundedShadowView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        
        //Bordas arredondadas
        layer.cornerRadius = 20
        
        // Sombra
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 5, height: 5)
        layer.shadowRadius = 10
        layer.shadowOpacity = 1
    }
}


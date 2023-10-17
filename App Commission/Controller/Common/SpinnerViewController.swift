//
//  SpinnerViewController.swift
//  App Commission
//
//  Created by Camilo Oscar Girardelli Baptista on 21/06/23.
//

import Foundation
import UIKit

class SpinnerViewController: UIViewController {
    static let spinner = SpinnerViewController()
    var spinner = UIActivityIndicatorView(style: .whiteLarge)

    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.7)

        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)

        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
}

//
//  PercentualViewController.swift
//  App Commission
//
//  Created by Camilo Oscar Girardelli Baptista on 06/07/23.
//

import Foundation
import UIKit

class PercentualViewController: UIViewController {
    
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var firstView: UIView!
    
    public init() {
        super.init(nibName: "PercentualViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implementerd")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Performance %"
        createSecondNavBar()
        configCards()
    }
    
    private func configCards() {
        firstView.dropShadow()
        firstView.cornerRadius(radius: 15)
        
        secondView.dropShadow()
        secondView.cornerRadius(radius: 15)
        
        firstView.isUserInteractionEnabled = true
        firstView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.goToCurrent)))
        
        secondView.isUserInteractionEnabled = true
        secondView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.goToHistory)))
    }
    
    @objc func goToCurrent() {
        
        let currentVC = CurrentPeriodViewController()
        self.navigationController?.pushViewController(currentVC, animated: true)
    }
    
    @objc func goToHistory() {
        let vc = PercentualHistoryViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}


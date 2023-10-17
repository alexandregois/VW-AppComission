//
//  IndiceViewController.swift
//  App Commission
//
//  Created by Camilo Oscar Girardelli Baptista on 30/06/23.
//

import Foundation
import UIKit

class IndexViewController: UIViewController {
    
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var thirdView: UIView!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var firstViewLabel: UILabel!
    @IBOutlet weak var secondViewLabel: UILabel!
    @IBOutlet weak var thirdViewImg: UIImageView!
    @IBOutlet weak var thirdViewLabel: UILabel!
    @IBOutlet weak var secondViewImg: UIImageView!
    @IBOutlet weak var firstViewImg: UIImageView!
    
    public init() {
        super.init(nibName: "IndexViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implementerd")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Índices"
        createSecondNavBar()
        configCards()
        createScreenByProfile()
    }
    
    private func configCards() {
        firstView.dropShadow()
        firstView.cornerRadius(radius: 15)
        
        secondView.dropShadow()
        secondView.cornerRadius(radius: 15)
        
        thirdView.dropShadow()
        thirdView.cornerRadius(radius: 15)
        
        firstView.isUserInteractionEnabled = true
        firstView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.goToCurrent)))
        
        secondView.isUserInteractionEnabled = true
        secondView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.goToPerformed)))
        
        thirdView.isUserInteractionEnabled = true
        thirdView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.goToHistory)))
    }
    
    private func createScreenByProfile() {
        if ProfileAccess.shared.profile == . lof {
            thirdView.isHidden = true
            secondView.isHidden = true
            firstView.isHidden = false
        } else {
            thirdView.isHidden = false
            secondView.isHidden = false
            firstView.isHidden = false
        }
    }
    
    @objc func goToCurrent() {
        let currentVC = CurrentViewController()
        self.navigationController?.pushViewController(currentVC, animated: true)
    }
    
    @objc func goToPerformed() {
        let currentVC = PerformedViewController()
        self.navigationController?.pushViewController(currentVC, animated: true)
    }
    
    @objc func goToHistory() {
        let currentVC = HistoryViewController()
        self.navigationController?.pushViewController(currentVC, animated: true)
    }
    
}

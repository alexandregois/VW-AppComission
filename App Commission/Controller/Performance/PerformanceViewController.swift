//
//  PerformanceViewController.swift
//  App Commission
//
//  Created by Camilo Oscar Girardelli Baptista on 06/06/23.
//

import Foundation
import UIKit

class PerformanceViewController: UIViewController {
    
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
        super.init(nibName: "PerformanceViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implementerd")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .white
        title = "Desempenho"
        createNavBar()
        configCards()
        createScreenByProfile()
        configCardActions()
    }
    
    private func configCardActions() {
        firstView.isUserInteractionEnabled = true
        firstView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.firstCardAction)))
        secondView.isUserInteractionEnabled = true
        secondView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.secondCardAction)))
        thirdView.isUserInteractionEnabled = true
        thirdView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.thirdCardAction)))
    }
    
    @objc func firstCardAction() {
        if ProfileAccess.shared.funcs.contains("DESEMPENHO-INDICES") {
            let indiceVC = IndexViewController()
            self.navigationController?.pushViewController(indiceVC, animated: true)
            
        } else {
            let percentualVC = PercentualViewController()
            self.navigationController?.pushViewController(percentualVC, animated: true)
        }
        
    }
    
    @objc func secondCardAction() {
        if ProfileAccess.shared.funcs.contains("DESEMPENHO-INDICES") {
            let percentualVC = PercentualViewController()
            self.navigationController?.pushViewController(percentualVC, animated: true)
            
        } else {
            
        }
    }
    
    @objc func thirdCardAction() {
        if ProfileAccess.shared.funcs.contains("DESEMPENHO-INDICES") {
//            let percentualVC = VolumePenetrationViewController()
            let percentualVC = PerformanceVolumeViewController()
            self.navigationController?.pushViewController(percentualVC, animated: true)
            
        } else {
            
        }        
    }
    
    private func configCards() {
        firstView.dropShadow()
        firstView.cornerRadius(radius: 15)
        
        secondView.dropShadow()
        secondView.cornerRadius(radius: 15)
        
        thirdView.dropShadow()
        thirdView.cornerRadius(radius: 15)
    }
    
    private func createScreenByProfile() {
        if ProfileAccess.shared.funcs.contains("DESEMPENHO-INDICES") {
            thirdView.isHidden = false
            
            firstViewImg.image = UIImage(named: "icon_indication_vw")
            firstViewLabel.text = "Índices"
            
            secondViewImg.image = UIImage(named: "icon_percentage_performance_vw")
            secondViewLabel.text = "Performance Percentual"
            
            thirdViewImg.image = UIImage(named: "icon_volume_performance_vw")
            thirdViewLabel.text = "Performance Volumes"
        } else {
            thirdView.isHidden = true
            
            firstViewImg.image = UIImage(named: "icon_percentage_performance_vw")
            firstViewLabel.text = "Performance Percentual"
            
            secondViewImg.image = UIImage(named: "icon_volume_performance_vw")
            secondViewLabel.text = "Performance Volumes"
        }
    }
    
}

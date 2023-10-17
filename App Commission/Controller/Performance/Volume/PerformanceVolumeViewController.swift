//
//  PerformanceVolumeViewController.swift
//  App Commission
//
//  Created by Alexandre Gois on 26/07/23.
//

import Foundation
import UIKit

class PerformanceVolumeViewController: UIViewController {
    
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var thirdView: UIView!
    @IBOutlet weak var firstView: UIView!
    
    var isFrotaValue: Bool = false
    var isAcumuladoValue: Bool = true
    
    public init() {
        super.init(nibName: "PerformanceVolumeViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implementerd")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        view.backgroundColor = .white
        title = "Performance Volumes"
        createSecondNavBar()
        configCards()
        configCardActions()
    }
    
    private func configCardActions() {
        firstView.isUserInteractionEnabled = true
        firstView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.firstCardAction)))
        secondView.isUserInteractionEnabled = true
        secondView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.secondCardAction)))
    }
    
    @objc func firstCardAction() {
        let percentualVC = VolumePenetrationViewController()
        self.navigationController?.pushViewController(percentualVC, animated: true)
        
    }
    
    @objc func secondCardAction() {
        
        let tipoPerformanceLabel = UILabel()
        tipoPerformanceLabel.text = "ISR Período Vigente"
        let performanceCustomTableVC = ProdutosAgregadosViewController(isFrota: isFrotaValue, tipoPerformance: tipoPerformanceLabel, isAcumulado: isAcumuladoValue)
        self.navigationController?.pushViewController(performanceCustomTableVC, animated: true)
        
    }
    
    private func configCards() {
        firstView.dropShadow()
        firstView.cornerRadius(radius: 15)
        
        secondView.dropShadow()
        secondView.cornerRadius(radius: 15)
        
    }
    
    
}

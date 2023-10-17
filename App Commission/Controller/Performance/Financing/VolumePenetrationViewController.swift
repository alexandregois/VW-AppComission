//
//  VolumePenetrationViewController.swift
//  App Commission
//
//  Created by Alexandre Gois on 20/07/23.
//

import Foundation
import UIKit

class VolumePenetrationViewController: UIViewController{
    
    @IBOutlet weak var aakCardView: UIView!
    @IBOutlet weak var consorcioCardView: UIView!
    @IBOutlet weak var financVeiculosNovosCardView: UIView!
    @IBOutlet weak var penetrationCardView: UIView!
    @IBOutlet weak var financVeiculosUsadosCardView: UIView!
    
    @IBOutlet weak var aakImageView: UIImageView!
    @IBOutlet weak var consorcioImageView: UIImageView!
    @IBOutlet weak var financVeiculosNovosImageView: UIImageView!
    @IBOutlet weak var penetrationImageView: UIImageView!
    @IBOutlet weak var financVeiculosUsadosImageView: UIImageView!
    
    var isFrotaValue: Bool = false
    var isAcumuladoValue: Bool = true
    
    
    
    public init() {
        super.init(nibName: "VolumePenetrationViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implementerd")
    }
    
    @objc func aakImageTapped(_ sender: UITapGestureRecognizer) {
        
        let tipoPerformanceLabel = UILabel()
        tipoPerformanceLabel.text = "Aak"
        let performanceCustomTableVC = PerformanceCustomTable(isFrota: isFrotaValue, tipoPerformance: tipoPerformanceLabel, isAcumulado: isAcumuladoValue)
        self.navigationController?.pushViewController(performanceCustomTableVC, animated: true)
    }
    
    @objc func consorcioImageTapped(_ sender: UITapGestureRecognizer) {
        
        let tipoPerformanceLabel = UILabel()
        tipoPerformanceLabel.text = "Consórcio"
        let performanceCustomTableVC = PerformanceCustomTable(isFrota: isFrotaValue, tipoPerformance: tipoPerformanceLabel, isAcumulado: isAcumuladoValue)
        self.navigationController?.pushViewController(performanceCustomTableVC, animated: true)
        
    }
    
    @objc func financVeiculosNovosImageTapped(_ sender: UITapGestureRecognizer) {
        
        let tipoPerformanceLabel = UILabel()
        tipoPerformanceLabel.text = "Financiamento de Veículos Novos"
        let performanceCustomTableVC = PerformanceCustomTable(isFrota: isFrotaValue, tipoPerformance: tipoPerformanceLabel, isAcumulado: isAcumuladoValue)
        self.navigationController?.pushViewController(performanceCustomTableVC, animated: true)
        
    }
    
    @objc func penetrationImageTapped(_ sender: UITapGestureRecognizer) {
        
        let tipoPerformanceLabel = UILabel()
        tipoPerformanceLabel.text = "Penetration"
        let performanceCustomTableVC = PerformanceCustomTable(isFrota: isFrotaValue, tipoPerformance: tipoPerformanceLabel, isAcumulado: isAcumuladoValue)
        self.navigationController?.pushViewController(performanceCustomTableVC, animated: true)
        
    }
    
    @objc func financVeiculosUsadosImageTapped(_ sender: UITapGestureRecognizer) {
        
        let tipoPerformanceLabel = UILabel()
        tipoPerformanceLabel.text = "Financiamento de Veículos Usados"
        let performanceCustomTableVC = PerformanceCustomTable(isFrota: isFrotaValue, tipoPerformance: tipoPerformanceLabel, isAcumulado: isAcumuladoValue)
        self.navigationController?.pushViewController(performanceCustomTableVC, animated: true)
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.createSecondNavBar()
        
        let tapAakGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(aakImageTapped))
        aakCardView.addGestureRecognizer(tapAakGestureRecognizer)
        
        let tapConsorcioGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(consorcioImageTapped))
        consorcioCardView.addGestureRecognizer(tapConsorcioGestureRecognizer)
        
        let tapFinancVeiculosNovosGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(financVeiculosNovosImageTapped))
        financVeiculosNovosCardView.addGestureRecognizer(tapFinancVeiculosNovosGestureRecognizer)
        
        let tapPenetrationGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(penetrationImageTapped))
        penetrationCardView.addGestureRecognizer(tapPenetrationGestureRecognizer)
        
        let tapFinancVeiculosUsadosGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(financVeiculosUsadosImageTapped))
        financVeiculosUsadosCardView.addGestureRecognizer(tapFinancVeiculosUsadosGestureRecognizer)
        
        
        
        aakCardView.dropShadowSimulador()
        aakCardView.cornerRadius(radius: 15)
        
        consorcioCardView.dropShadowSimulador()
        consorcioCardView.cornerRadius(radius: 15)
        
        financVeiculosNovosCardView.dropShadowSimulador()
        financVeiculosNovosCardView.cornerRadius(radius: 15)
        
        penetrationCardView.dropShadowSimulador()
        penetrationCardView.cornerRadius(radius: 15)
        
        financVeiculosUsadosCardView.dropShadowSimulador()
        financVeiculosUsadosCardView.cornerRadius(radius: 15)
        
    }
    
}

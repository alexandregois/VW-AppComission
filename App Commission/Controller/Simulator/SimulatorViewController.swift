//
//  SimulatorViewController.swift
//  App Commission
//
//  Created by Camilo Oscar Girardelli Baptista on 06/06/23.
//

import Foundation
import UIKit

class SimulatorViewController: UIViewController, SlideViewControllerDelegate, IncrementDecrementViewControllerDelegate {
    
    @IBOutlet weak var aakCardView: UIView!
    @IBOutlet weak var volumeNovosCardView: UIView!
    @IBOutlet weak var volumeUsadosCardView: UIView!
    @IBOutlet weak var volumePenetrationCardView: UIView!
    @IBOutlet weak var isrCardView: UIView!
    
    @IBOutlet weak var dataCargaLabel: UILabel!
    
    @IBOutlet weak var isrLabel: UILabel!
    @IBOutlet weak var volumeNovosLabel: UILabel!
    @IBOutlet weak var volumeUsadosLabel: UILabel!
    @IBOutlet weak var aakLabel: UILabel!
    @IBOutlet weak var penetrationLabel: UILabel!
    
    var simulatorRealizado: SimulatorRealizado
    
    var isrData: UILabel!
    var volumeNovosData: UILabel!
    var volumeUsadosData: UILabel!
    var aakData: UILabel!
    var penetrationData: UILabel!
    
    var aakValue: String = ""
    var volumesUsadosValue: String = ""
    var penetrationValue: String = ""
    var isrValue: String = ""
    
    
    @IBOutlet weak var isrSelecione: UIButton!
    @IBOutlet weak var volumeNovosSelecione: UIButton!
    @IBOutlet weak var volumeUsadosSelecione: UIButton!
    @IBOutlet weak var aakSelecione: UIButton!
    @IBOutlet weak var penetrationSelecione: UIButton!
    
    let defaults = UserDefaults.standard
    
    override func viewWillAppear(_ animated: Bool) {
        aakValue = ""
        volumesUsadosValue = ""
        penetrationValue = ""
        isrValue = ""
        setSublinhado()
        getRealizado()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        createNavBar()
        config()
        setSublinhado()
        formatCards()
        getRealizado()
        populateDataCarga()
        
    }
    
    private func config() {
        view.backgroundColor = .white
        title = "Simulador"
    }
    
    private func formatCards() {
        aakCardView.dropShadowSimulador()
        aakCardView.cornerRadius(radius: 15)
        
        volumeNovosCardView.dropShadowSimulador()
        volumeNovosCardView.cornerRadius(radius: 15)
        
        volumeUsadosCardView.dropShadowSimulador()
        volumeUsadosCardView.cornerRadius(radius: 15)
        
        volumePenetrationCardView.dropShadowSimulador()
        volumePenetrationCardView.cornerRadius(radius: 15)
        
        isrCardView.dropShadowSimulador()
        isrCardView.cornerRadius(radius: 15)
    }
    
    private func getRealizado() {
        self.createSpinnerView()
        SimulatorService.shared.getSimulatorRealizado() { simulatorRealizado, error in
            
            self.removeSpinnerView()
            
            if let simulatorRealizado = simulatorRealizado {
                
                self.simulatorRealizado = simulatorRealizado
                
                let isr = simulatorRealizado.ISR ?? 0.0
                let isrAsPercent = isr // 100.0
                self.isrLabel.text = Utils.formatPercentual(isrAsPercent)
                
                let penetration = simulatorRealizado.PENETRATION ?? 0.0
                //let penetrationpAsPercent = penetration // 100.0
                self.penetrationLabel.text = Utils.formatPercentual(penetration)
                
                let aak = simulatorRealizado.AAK ?? 0.0
                self.aakLabel.text = Utils.formatCasaDecimal(aak)
                
                let volumeNovos = simulatorRealizado.VOLUMES_NOVOS ?? 0.0
                self.volumeNovosLabel.text = Utils.formatCasaDecimal(volumeNovos)
                
                let volumeUsados = simulatorRealizado.VOLUMES_USADOS ?? 0.0
                self.volumeUsadosLabel.text = Utils.formatCasaDecimal(volumeUsados)
                
            } else {
                
                let alertController = UIAlertController(title: "Ops..", message: "Estamos passando por algum problema.. :(", preferredStyle: .alert)
                let confirmAction = UIAlertAction(title: "ok", style: .default) { (action) in
                    self.dismiss(animated: true, completion: nil)
                }
                
                alertController.addAction(confirmAction)
                self.present(alertController, animated: true, completion: nil)
                
                
            }
            
        }
    }
    
    private func populateDataCarga() {
        let dataCarga = defaults.string(forKey: SystemKeys.DATA_CARGA)
        
        self.dataCargaLabel.text = "Realizado até " + dataCarga!
    }
    
    
    @IBAction func aakLabelTapped(_ sender: UIButton) {
        let slideViewController = SlideViewController()
        slideViewController.slideLabelValue = "Aak"
        slideViewController.delegate = self
        if let text = aakLabel.text, let value = Float(Utils.removePontoDeString(input: text)) {
            slideViewController.initialSlideValue = value
        } else {
            slideViewController.initialSlideValue = 0
        }
        slideViewController.modalPresentationStyle = .overFullScreen
        slideViewController.modalTransitionStyle = .crossDissolve
        present(slideViewController, animated: true, completion: nil)
        
    }
    
    @IBAction func volumeNovosLabelTapped() {
        let slideViewController = SlideViewController()
        slideViewController.slideLabelValue = "Volumes Novos"
        slideViewController.delegate = self
        if let text = volumeNovosLabel.text, let value = Float(Utils.removePontoDeString(input: text)) {
            slideViewController.initialSlideValue = value
        } else {
            slideViewController.initialSlideValue = 0
        }
        slideViewController.modalPresentationStyle = .overFullScreen
        slideViewController.modalTransitionStyle = .crossDissolve
        present(slideViewController, animated: true, completion: nil)
    }
    
    @IBAction func volumeUsadosLabelTapped() {
        let slideViewController = SlideViewController()
        slideViewController.slideLabelValue = "Volumes Usados"
        slideViewController.delegate = self
        if let text = volumeUsadosLabel.text, let value = Float(Utils.removePontoDeString(input: text)) {
            slideViewController.initialSlideValue = value
        } else {
            slideViewController.initialSlideValue = 0
        }
        slideViewController.modalPresentationStyle = .overFullScreen
        slideViewController.modalTransitionStyle = .crossDissolve
        present(slideViewController, animated: true, completion: nil)
    }
    
    @IBAction func penetrationLabelTapped() {
        
        let incrementViewController = IncrementDecrementViewController()
        incrementViewController.slideLabelValue = "Penetration"
        incrementViewController.delegate = self
        
        if let penetration = self.simulatorRealizado.PENETRATION {
            let stringValue = String(penetration)
            let cleanedText = stringValue.replacingOccurrences(of: ",", with: "")
            if let floatValue = Float(cleanedText) {
                incrementViewController.initialSlideValue = floatValue
            } else {
                incrementViewController.initialSlideValue = 0
            }
        } else {
            incrementViewController.initialSlideValue = 0
        }
        
        incrementViewController.modalPresentationStyle = .overFullScreen
        incrementViewController.modalTransitionStyle = .crossDissolve
        present(incrementViewController, animated: true, completion: nil)
        
    }
    
    private func setSublinhado() {
        let attributedString = NSMutableAttributedString.init(string: "Selecione")
        
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range:
                                        NSRange.init(location: 0, length: attributedString.length));
        aakSelecione.setAttributedTitle(attributedString, for: .normal)
        volumeUsadosSelecione.setAttributedTitle(attributedString, for: .normal)
        penetrationSelecione.setAttributedTitle(attributedString, for: .normal)
        isrSelecione.setAttributedTitle(attributedString, for: .normal)
    }
    
    func verificaSelecione() -> Bool {
        
        var hasSelecionado = true
        
        if isrValue == "" {
            hasSelecionado = false
        }
        
        if aakValue == "Selecione" {
            
            hasSelecionado = false
        }
        
        if volumesUsadosValue == "" {
            
            hasSelecionado = false
        }
        
        if penetrationValue == "" {
            
            hasSelecionado = false
        }
        
        return hasSelecionado
    }
    
    @IBAction func submeterTapped()
    {
        let defaults = UserDefaults.standard
        let currentUser = User.getGlobal()
        let actualPeriod = defaults.string(forKey: SystemKeys.ACTUAL_PERIOD)
        
        if !verificaSelecione()
        {
            let alertController = UIAlertController(title: "Aviso", message: "Por favor, todas as opções devem ser selecionadas.", preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "ok", style: .default) { (action) in
                self.removeSpinnerView()
            }
            
            alertController.addAction(confirmAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else
        {
            self.createSpinnerView()
            
            if let currentTitle = isrSelecione.currentTitle {
                let updatedTitle = currentTitle.replacingOccurrences(of: "%", with: "").replacingOccurrences(of: ",", with: ".")
                isrSelecione.setTitle(updatedTitle, for: .normal)
            }
            
            if let currentTitle = penetrationSelecione.currentTitle {
                let updatedTitle = currentTitle.replacingOccurrences(of: "%", with: "").replacingOccurrences(of: ",", with: ".")
                penetrationSelecione.setTitle(updatedTitle, for: .normal)
            }
            
            let body: [String: Any] = [
                "cd_dn": currentUser!.codigoDealer!,
                "nr_exercicio": actualPeriod!,
                "aak": aakValue,
                "volumeUsados": volumesUsadosValue,
                "penetration": penetrationValue.replacingOccurrences(of: ",", with: "."),
                "isr": isrValue.replacingOccurrences(of: ",", with: "."),
            ]
            
            let pageP = SimulatorResultViewController()
            pageP.parameters = body
            self.navigationController?.pushViewController(pageP, animated: true)
            
        }
        
    }
    
    @IBAction func isrLabelTapped() {
        
        let incrementViewController = IncrementDecrementViewController()
        incrementViewController.slideLabelValue = "ISR"
        incrementViewController.delegate = self
        
        if let isr = self.simulatorRealizado.ISR {
            let stringValue = String(isr)
            let cleanedText = stringValue.replacingOccurrences(of: ",", with: "")
            if let floatValue = Float(cleanedText) {
                incrementViewController.initialSlideValue = floatValue
            } else {
                incrementViewController.initialSlideValue = 0
            }
        } else {
            incrementViewController.initialSlideValue = 0
        }
        
        incrementViewController.modalPresentationStyle = .overFullScreen
        incrementViewController.modalTransitionStyle = .crossDissolve
        present(incrementViewController, animated: true, completion: nil)
        
    }
    
    func didSelectSlideValue(_ value: String, withParameter parameter: Any?) {
        
        // Use o valor do slide e o parâmetro como necessário
        if let stringValue = parameter as? String {
            
            switch stringValue {
            case "Aak":
                
                let attributedString = NSMutableAttributedString.init(string: value)
                
                attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range:
                                                NSRange.init(location: 0, length: attributedString.length));
                
                aakSelecione.setAttributedTitle(attributedString, for: .normal)
                aakValue = value
                
            case "Volumes Novos":
                
                let attributedString = NSMutableAttributedString.init(string: value)
                
                attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range:
                                                NSRange.init(location: 0, length: attributedString.length));
                
                volumeNovosSelecione.setAttributedTitle(attributedString, for: .normal)
                
                
            case "Volumes Usados":
                let attributedString = NSMutableAttributedString.init(string: value)
                
                attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range:
                                                NSRange.init(location: 0, length: attributedString.length));
                
                volumeUsadosSelecione.setAttributedTitle(attributedString, for: .normal)
                
                volumesUsadosValue = value
                
            case "Penetration":
                let attributedString = NSMutableAttributedString.init(string: "\(value) %")
                
                attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range:
                                                NSRange.init(location: 0, length: attributedString.length));
                
                penetrationSelecione.setAttributedTitle(attributedString, for: .normal)
                penetrationValue = value
                
            default: //ISR

                let attributedString = NSMutableAttributedString.init(string: "\(value) %")
                
                attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range:
                                                NSRange.init(location: 0, length: attributedString.length));
                
                isrSelecione.setAttributedTitle(attributedString, for: .normal)
                isrValue = value
            }
            
        }
        
    }
    
    public init() {
        simulatorRealizado = SimulatorRealizado()
        super.init(nibName: "SimulatorViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implementerd")
    }
    
    func formataPercentual(_ value: Double)
    {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
        formatter.string(from: NSNumber(value: value))
        
    }
    
}



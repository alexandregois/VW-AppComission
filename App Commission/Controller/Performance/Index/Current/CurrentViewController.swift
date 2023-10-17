//
//  CurrentViewController.swift
//  App Commission
//
//  Created by Camilo Oscar Girardelli Baptista on 03/07/23.
//

import Foundation
import UIKit

class CurrentViewController: UIViewController, PerformancePercentualCurrentPeriodPresentation {
    
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var descriptLabel: UILabel!
    @IBOutlet weak var performadoIcon: UIImageView!
    @IBOutlet weak var frotaLabel: UILabel!
    @IBOutlet weak var performadoHelp: UIImageView!
    @IBOutlet weak var vigenteHelp: UIImageView!
    @IBOutlet weak var performadoIndex: UILabel!
    @IBOutlet weak var vigenteIndex: UILabel!
    @IBOutlet weak var performadoView: UIView!
    @IBOutlet weak var vigenteView: UIView!
    
    let defaults = UserDefaults.standard
    
    public init() {
        super.init(nibName: "CurrentViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implementerd")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Índices"
        titleView.text = "Índices"
        createSecondNavBar(true)
        configCards()
        self.createSpinnerView()
        
        let attributedString = NSMutableAttributedString.init(string: "Visualizar Índice Frota")
        
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range:
                                        NSRange.init(location: 0, length: attributedString.length));
        frotaLabel.attributedText = attributedString
        
        CurrentIndexService.shared.getVarejo { currentIndex, error in
            self.removeSpinnerView()
            if currentIndex != nil {
                let vigente: CurrentIndex?
                let performado: CurrentIndex?
                
                if currentIndex![0].statico {
                    performado = currentIndex![0]
                    vigente = currentIndex![1]
                } else {
                    performado = currentIndex![1]
                    vigente = currentIndex![0]
                }
                
                let vigenteFormatado = "\(vigente!.vigente)".replacingOccurrences(of: ".", with: ",")
                let performadoFormatado = "\(performado!.performado)".replacingOccurrences(of: ".", with: ",")
                
                self.vigenteIndex.text = "\(vigenteFormatado) %"
                self.performadoIndex.text = "\(performadoFormatado) %"
                
                if (vigente!.vigente < performado!.performado) {
                    self.performadoIcon.image = UIImage(systemName: "arrow.up")
                } else {
                    self.performadoIcon.image = UIImage(systemName: "arrow.down")
                }
                self.performadoIcon.isHidden = false
            }
            
            if error != nil {
                print(error)
                let alertController = UIAlertController(title: "Ops..", message: "Estamos passando por algum problema.. :(", preferredStyle: .alert)
                
                let confirmAction = UIAlertAction(title: "ok", style: .default) { (action) in
                    
                    self.dismiss(animated: true, completion: nil)
                    
                }
                
                alertController.addAction(confirmAction)
                
                self.present(alertController, animated: true, completion: nil)
            }
            
        }
    }
    
    private func configCards(){
        vigenteView.dropShadow()
        vigenteView.cornerRadius(radius: 15)
        
        performadoView.dropShadow()
        performadoView.cornerRadius(radius: 15)
        
        performadoIcon.image = UIImage(systemName: "arrow.up")
        
        let dataCarga = defaults.string(forKey: SystemKeys.DATA_CARGA)
        
        vigenteIndex.text = ""
        performadoIndex.text = ""
        performadoIcon.isHidden = true
        
        descriptLabel.text = "O índice projetado tem como base a performance atualizada até \(dataCarga!) e poderá sofrer alterações. Os valores apresentados não garantem qualquer tipo de remuneração."
        
        frotaLabel.isUserInteractionEnabled = true
        frotaLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.goToFrota)))
        vigenteHelp.isUserInteractionEnabled = true
        vigenteHelp.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.goToHelpVigente)))
        performadoHelp.isUserInteractionEnabled = true
        performadoHelp.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.goToHelpPerformado)))
    }
    
    @objc func goToFrota() {
        let frotaVC = CurrentFrotaViewController()
        self.navigationController?.pushViewController(frotaVC, animated: true)
    }
    
    @objc func goToHelpVigente() {
        let vc = CurrentHelperViewController()
        vc.delegate = self
        vc.type = .vigente
        vc.isFrota = false
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    @objc func goToHelpPerformado() {
        let vc = CurrentHelperViewController()
        vc.delegate = self
        vc.type = .performado
        vc.isFrota = false
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    func redirectToCurrentPeriod(isFrota: Bool) {
        if isFrota {
            let currentVC = CurrentPeriodFrotaViewController()
            self.navigationController?.pushViewController(currentVC, animated: true)
        } else {
            let currentVC = CurrentPeriodViewController()
            self.navigationController?.pushViewController(currentVC, animated: true)
        }
    }
}

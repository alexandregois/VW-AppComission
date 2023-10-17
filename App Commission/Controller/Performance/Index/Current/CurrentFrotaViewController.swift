//
//  CurrentFrotaViewController.swift
//  App Commission
//
//  Created by Camilo Oscar Girardelli Baptista on 03/07/23.
//

import Foundation


import Foundation
import UIKit

class CurrentFrotaViewController: UIViewController, PerformancePercentualCurrentPeriodPresentation {
    
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
        title = "Índices - Frota"
        titleView.text = "Índices - Frota"
        createSecondNavBar(true)
        configCards()
        self.createSpinnerView()
        CurrentIndexService.shared.getFrota { currentIndex, error in
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
        frotaLabel.isHidden = true
        
        descriptLabel.text = "O índice projetado tem como base a performance atualizada até \(dataCarga!) e poderá sofrer alterações. Os valores apresentados não garantem qualquer tipo de remuneração."
        
        vigenteHelp.isUserInteractionEnabled = true
        vigenteHelp.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.goToHelpVigente)))
        performadoHelp.isUserInteractionEnabled = true
        performadoHelp.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.goToHelpPerformado)))
    }
    
    @objc func goToHelpVigente() {
        let vc = CurrentHelperViewController()
        vc.delegate = self
        vc.type = .vigente
        vc.isFrota = true
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    @objc func goToHelpPerformado() {
        let vc = CurrentHelperViewController()
        vc.delegate = self
        vc.type = .performado
        vc.isFrota = true
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    override func shareScreen() {
        let image = view.takeScreenshot()
        UIGraphicsEndImageContext()
        
        let imageToShare = [ image ]
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
        
        self.present(activityViewController, animated: true, completion: nil)
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


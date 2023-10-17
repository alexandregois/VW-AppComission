//
//  CurrentPeriodViewController.swift
//  App Commission
//
//  Created by Camilo Oscar Girardelli Baptista on 06/07/23.
//

import Foundation
import UIKit

class CurrentPeriodViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var ContentView: UIView!
    @IBOutlet weak var cardsView: UIView!
    @IBOutlet weak var leftTopCardsView: UIView!
    @IBOutlet weak var rightTopCardsView: UIView!
    @IBOutlet weak var leftBottonCardsView: UIView!
    @IBOutlet weak var rigthBottonCardsView: UIView!
    @IBOutlet weak var anteriorPenetrationValue: UILabel!
    @IBOutlet weak var anteriorIsrValue: UILabel!
    @IBOutlet weak var actualPenetrationValue: UILabel!
    @IBOutlet weak var actualIsrValue: UILabel!
    @IBOutlet weak var typeTableTitle: UILabel!
    @IBOutlet weak var showFrota: UILabel!
    @IBOutlet weak var screenTitle: UILabel!
    @IBOutlet weak var penetrationHelp: UIImageView!
    @IBOutlet weak var isrHelp: UIImageView!
    @IBOutlet weak var footerInfo: UILabel!
    
    //FirstGraphView
    @IBOutlet weak var firstGraphView: UIView!
    @IBOutlet weak var BrIndicator: UIView!
    @IBOutlet weak var groupIndicator: UIView!
    @IBOutlet weak var regIndicator: UIView!
    @IBOutlet weak var BrGraphBar: UIView!
    @IBOutlet weak var regGraphBar: UIView!
    @IBOutlet weak var GroupGrraphBar: UIView!
    @IBOutlet weak var regBarTitle: UILabel!
    @IBOutlet weak var brBarTitle: UILabel!
    @IBOutlet weak var groupBarTitle: UILabel!
    @IBOutlet weak var regGraphLabel: UILabel!
    
    //SecondGraphView
    @IBOutlet weak var secondGraphView: UIView!
    @IBOutlet weak var regSecondGraphLabel: UILabel!
    @IBOutlet weak var secondBrIndicator: UIView!
    @IBOutlet weak var secondRegIndicatoer: UIView!
    @IBOutlet weak var secondGroupIndicator: UIView!
    @IBOutlet weak var secondBrGraphBar: UIView!
    @IBOutlet weak var secondRegGraphBar: UIView!
    @IBOutlet weak var secondGroupGraphBar: UIView!
    @IBOutlet weak var secondBrBarTitle: UILabel!
    @IBOutlet weak var secondGroupBarTitle: UILabel!
    @IBOutlet weak var secondRegBarTitle: UILabel!
    
    let defaults = UserDefaults.standard
    
    public init() {
        super.init(nibName: "CurrentPeriodViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implementerd")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Índices"
        typeTableTitle.text = "Varejo"
        screenTitle.text = "Período Vigente"
        createSecondNavBar(true)
        configCardsView()
        configFooter()
        showFrota.isHidden = false
        scrollView.delegate = self
        
        
        let attributedString = NSMutableAttributedString.init(string: "Visualizar Índice Frota")
        
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range:
                                        NSRange.init(location: 0, length: attributedString.length));
        showFrota.attributedText = attributedString
        
        showFrota.isUserInteractionEnabled = true
        showFrota.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.gotToFrotaView)))
        
        penetrationHelp.isUserInteractionEnabled = true
        penetrationHelp.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.openPenetrationVarejoHelpView)))
        
        isrHelp.isUserInteractionEnabled = true
        isrHelp.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.openIsrVarejoHelpView)))
        
        self.createSpinnerView()
        CurrentPeriodService.shared.getVarejo { performanceCurrentPeriod, error in
            
            if performanceCurrentPeriod != nil {
                let periodoAtual = performanceCurrentPeriod!.periodoAtual
                let periodoAnterior = performanceCurrentPeriod!.periodoAnterior
                self.configTable(periodoAtual: periodoAtual, periodoAnterior: periodoAnterior)
                self.configFirstGraphView(brValue: periodoAtual.penetrationBr!, regValue: periodoAtual.penetrationRegional!, groupValue: periodoAtual.penetrationGrupo!, label: periodoAtual.cdRegional!)
                self.configSecondGraphView(brValue: periodoAtual.isrBr!, regValue: periodoAtual.isrRegional!, groupValue: periodoAtual.isrGrupo!, label: periodoAtual.cdRegional!)
                self.removeSpinnerView()
            }
            
            if error != nil {
                self.removeSpinnerView()
                
                let alertController = UIAlertController(title: "Ops..", message: "Estamos passando por algum problema.. :(", preferredStyle: .alert)
                
                let confirmAction = UIAlertAction(title: "ok", style: .default) { (action) in
                    
                    self.dismiss(animated: true, completion: nil)
                    
                }
                
                alertController.addAction(confirmAction)
                
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    @objc func gotToFrotaView() {
        let currentVC = CurrentPeriodFrotaViewController()
        self.navigationController?.pushViewController(currentVC, animated: true)
    }
    
    @objc func openPenetrationVarejoHelpView() {
        let vc = PenetratrionVarejoHelpViewController()
        vc.tituloLabel = "Penetration Varejo"
        vc.descLabel = "Penetration Varejo Indicador que avalia a quantidade de contratos de financiamento novos em relação aos faturamentos (AaK), segmentado em varejo (faturamento varejo + faturamento frotistas faixas 0 e 1)."
    
        vc.subDescLabel = "Penetration Varejo (Varejo + frota faixas 0 e 1)"
        vc.superiorFormulaLabel = "Financ novos varejo"
        vc.inferiorFormulaLabel = "Aak varejo - Consórcio"
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    private func configFooter() {
        let dataCarga = defaults.string(forKey: SystemKeys.DATA_CARGA)
        
        footerInfo.text = "O índice projetado tem como base a performance atualizada até \(dataCarga!) e poderá sofrer alterações. Os valores apresentados não garantem qualquer tipo de remuneração."
    }
    
    @objc func openIsrVarejoHelpView() {
        let vc = IsrVarejoHelpViewController()
        vc.tituloLabel = "ISR"
        vc.descLabel = "ISR Indicador que avalia as vendas de produtos agregados em contratos de financiamento e à vista em relação aos contratos de financiamento de novos e usados, segmentado em varejo (varejo + frota faixas 0 e 1)."
    
        vc.subDescLabel = "ISR Agregados Varejo (varejo + frota faixas 0 e 1)"
        vc.superiorFormulaLabel = "Vol ponderado prod agregados varejo ou à vista varejo"
        vc.inferiorFormulaLabel = "Vol financ (novos + usados) varejo"
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    private func configTable(periodoAtual: CurrentPeriod, periodoAnterior: CurrentPeriod) {
        anteriorPenetrationValue.text = "\(periodoAnterior.penetrationGrupo!)%"
        actualPenetrationValue.text = "\(periodoAtual.penetrationGrupo!)%"
        anteriorIsrValue.text = "\(periodoAnterior.isrGrupo!)%"
        actualIsrValue.text = "\(periodoAtual.isrGrupo!)%"
        cardsView.isHidden = false
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x != 0 {
            scrollView.contentOffset.x = 0
        }
    }
    
    private func configFirstGraphView(brValue: Double, regValue: Double, groupValue: Double, label: String) {
        firstGraphView.dropShadow()
        firstGraphView.cornerRadius(radius: 15)
        BrIndicator.cornerRadius(radius: 3)
        regIndicator.cornerRadius(radius: 3)
        groupIndicator.cornerRadius(radius: 3)
        BrGraphBar.cornerRadius(radius: 5)
        GroupGrraphBar.cornerRadius(radius: 5)
        regGraphBar.cornerRadius(radius: 5)
        
        let brGraphHeigth = (brValue * 155) / 100
        let regGraphHeigth = (regValue * 155) / 100
        let groupGraphHeigth = (groupValue * 155) / 100
        
        
        let positionBrY = self.BrGraphBar.frame.origin.y + 155
        let finalBrPosition = positionBrY - brGraphHeigth
        
        let positionRegY = self.regGraphBar.frame.origin.y + 155
        let finalRegPosition = positionRegY - regGraphHeigth
        
        let positionGroupY = self.GroupGrraphBar.frame.origin.y + 155
        let finalGroupPosition = positionGroupY - groupGraphHeigth
        
        BrGraphBar.frame = CGRect(x: self.BrGraphBar.frame.origin.x, y: finalBrPosition, width: self.BrGraphBar.frame.width, height: brGraphHeigth.rounded(toPlaces: 1))
        regGraphBar.frame = CGRect(x: self.regGraphBar.frame.origin.x, y: finalRegPosition, width: self.regGraphBar.frame.width, height: regGraphHeigth.rounded(toPlaces: 1))
        GroupGrraphBar.frame = CGRect(x: self.GroupGrraphBar.frame.origin.x, y: finalGroupPosition, width: self.GroupGrraphBar.frame.width, height: groupGraphHeigth.rounded(toPlaces: 1))
        
        regBarTitle.text = "\(regValue)%"
        regBarTitle.frame = CGRect(x: self.regBarTitle.frame.origin.x, y: self.regBarTitle.frame.origin.y + (155 - regGraphHeigth), width: self.regBarTitle.frame.width, height: self.regBarTitle.frame.height)
        
        brBarTitle.text = "\(brValue)%"
        brBarTitle.frame = CGRect(x: self.brBarTitle.frame.origin.x, y: self.brBarTitle.frame.origin.y + (155 - brGraphHeigth), width: self.brBarTitle.frame.width, height: self.brBarTitle.frame.height)
        
        groupBarTitle.text = "\(groupValue)%"
        groupBarTitle.frame = CGRect(x: self.groupBarTitle.frame.origin.x, y: self.groupBarTitle.frame.origin.y + (155 - groupGraphHeigth), width: self.groupBarTitle.frame.width, height: self.groupBarTitle.frame.height)
        
        regGraphLabel.text = label
        
        firstGraphView.isHidden = false
    }
    
    private func configSecondGraphView(brValue: Double, regValue: Double, groupValue: Double, label: String) {
        secondGraphView.dropShadow()
        secondGraphView.cornerRadius(radius: 15)
        secondBrIndicator.cornerRadius(radius: 3)
        secondRegIndicatoer.cornerRadius(radius: 3)
        secondGroupIndicator.cornerRadius(radius: 3)
        secondBrGraphBar.cornerRadius(radius: 5)
        secondGroupGraphBar.cornerRadius(radius: 5)
        secondRegGraphBar.cornerRadius(radius: 5)
        
        let brGraphHeigth = ((brValue * 155) / 100) * 0.7
        let regGraphHeigth = ((regValue * 155) / 100) * 0.7
        let groupGraphHeigth = ((groupValue * 155) / 100) * 0.7
        
        
        let positionBrY = self.secondBrGraphBar.frame.origin.y + 155
        let finalBrPosition = positionBrY - brGraphHeigth
        
        let positionRegY = self.secondRegGraphBar.frame.origin.y + 155
        let finalRegPosition = positionRegY - regGraphHeigth
        
        let positionGroupY = self.secondGroupGraphBar.frame.origin.y + 155
        let finalGroupPosition = positionGroupY - groupGraphHeigth
        
        secondBrGraphBar.frame = CGRect(x: self.secondBrGraphBar.frame.origin.x, y: finalBrPosition, width: self.secondBrGraphBar.frame.width, height: brGraphHeigth.rounded(toPlaces: 1))
        secondRegGraphBar.frame = CGRect(x: self.secondRegGraphBar.frame.origin.x, y: finalRegPosition, width: self.secondRegGraphBar.frame.width, height: regGraphHeigth.rounded(toPlaces: 1))
        secondGroupGraphBar.frame = CGRect(x: self.secondGroupGraphBar.frame.origin.x, y: finalGroupPosition, width: self.secondGroupGraphBar.frame.width, height: groupGraphHeigth.rounded(toPlaces: 1))
        
        secondRegBarTitle.text = "\(regValue)%"
        secondRegBarTitle.frame = CGRect(x: self.secondRegBarTitle.frame.origin.x, y: self.secondRegBarTitle.frame.origin.y + (155 - regGraphHeigth), width: self.secondRegBarTitle.frame.width, height: self.secondRegBarTitle.frame.height)
        
        secondBrBarTitle.text = "\(brValue)%"
        secondBrBarTitle.frame = CGRect(x: self.secondBrBarTitle.frame.origin.x, y: self.secondBrBarTitle.frame.origin.y + (155 - brGraphHeigth), width: self.secondBrBarTitle.frame.width, height: self.secondBrBarTitle.frame.height)
        
        secondGroupBarTitle.text = "\(groupValue)%"
        secondGroupBarTitle.frame = CGRect(x: self.secondGroupBarTitle.frame.origin.x, y: self.secondGroupBarTitle.frame.origin.y + (155 - groupGraphHeigth), width: self.secondGroupBarTitle.frame.width, height: self.secondGroupBarTitle.frame.height)
        
        regSecondGraphLabel.text = label
        
        secondGraphView.isHidden = false
        
    }
    
    
    private func configCardsView() {
        cardsView.isHidden = true
        firstGraphView.isHidden = true
        secondGraphView.isHidden = true
        cardsView.dropShadow()
        cardsView.cornerRadius(radius: 15)
        leftTopCardsView.roundCorners(corners: [.topLeft], radius: 15)
        rightTopCardsView.roundCorners(corners: [.topRight], radius: 15)
        leftBottonCardsView.roundCorners(corners: [.bottomLeft], radius: 15)
        rigthBottonCardsView.roundCorners(corners: [.bottomRight], radius: 15)
    }
    
    override func shareScreen() {
        let image = view.snapshot(scrollView: scrollView)
        UIGraphicsEndImageContext()
        
        let imageToShare = [ image! ]
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
        
        self.present(activityViewController, animated: true, completion: nil)
    }
}

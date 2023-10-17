//
//  SimulatorResultViewController.swift
//  App Commission
//
//  Created by Alexandre Gois on 18/07/23.
//

import Foundation
import UIKit

class SimulatorResultViewController: UIViewController {
    var parameters: [String: Any]?
    
    @IBOutlet weak var penetrationVarejoCardView: UIView!
    @IBOutlet weak var isrVarejoCardView: UIView!
    @IBOutlet weak var volumesUsadosCardView: UIView!
    @IBOutlet weak var volumesNovosCardView: UIView!
    @IBOutlet weak var pontosContratoCardView: UIView!
    @IBOutlet weak var indicePerformadoCardView: UIView!
    @IBOutlet weak var indiceProjetadoCardView: UIView!
    @IBOutlet weak var variacaoIndiceCardView: UIView!
    @IBOutlet weak var mixTabelaCardView: UIView!
    @IBOutlet weak var valorMedioFimMesCardView: UIView!
    @IBOutlet weak var comissaoMediaMesCardView: UIView!
    @IBOutlet weak var comissaoProjetadaCardView: UIView!
    @IBOutlet weak var variacaoComissionalMesCardView: UIView!
    
    
    @IBOutlet weak var penetrationVarejoResultLabel: UILabel!
    @IBOutlet weak var isrVarejoResultLabel: UILabel!
    @IBOutlet weak var volumesUsadosResultLabel: UILabel!
    @IBOutlet weak var volumesNovosResultLabel: UILabel!
    @IBOutlet weak var pontosContratoResultLabel: UILabel!
    @IBOutlet weak var indicePerformadoResultLabel: UILabel!
    @IBOutlet weak var indiceProjetadoResultLabel: UILabel!
    @IBOutlet weak var variacaoIndiceResultLabel: UILabel!
    @IBOutlet weak var mixTabelaResultLabel: UILabel!
    @IBOutlet weak var valorMedioFimMesResultLabel: UILabel!
    @IBOutlet weak var comissaoMediaMesResultLabel: UILabel!
    @IBOutlet weak var comissaoProjetadaResultLabel: UILabel!
    @IBOutlet weak var variacaoComissionalMesResultLabel: UILabel!
    
    @IBOutlet weak var textoTopoLabel: UILabel!
    @IBOutlet weak var textoRodapeLabel: UILabel!
    
    @IBOutlet weak var novaSimulacaoButton: UIButton!
    
    let defaults = UserDefaults.standard
    
    
    public init() {
        super.init(nibName: "SimulatorResultViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implementerd")
    }
    
    @IBAction func novaSimulacaoButtonTapped() {
        _ = navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Simulador Resultado"
        createSecondNavBar(true)
        self.configCards()
        self.isHiddeView(true)
        
        self.createSpinnerView()
        
        if let unwrappedParameters = parameters {
            self.getSimulation(body: unwrappedParameters)
        } else {
            self.showErroModal()
        }
    }
    
    private func getSimulation(body: [String: Any]) {
        SimulatorService.shared.postSimulatorProjection(body: body) { simulatorProjection, error in
            
            if let simulatorProjection = simulatorProjection {
                
                self.populateCards(simulatorProjection: simulatorProjection)
                
            } else {
                self.showErroModal()
            }
        }
    }
    
    private func showErroModal() {
        self.removeSpinnerView()
        
        let alertController = UIAlertController(title: "Ops..", message: "Estamos passando por algum problema.. :(", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "ok", style: .default) { (action) in
            
        }
        
        alertController.addAction(confirmAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func populateCards(simulatorProjection: SimulatorProjection) {
        
        let penetrationVarejo = simulatorProjection.PENETRATION_VAREJO ?? 0.0
        self.penetrationVarejoResultLabel.text = Utils.formatPercentual(penetrationVarejo)
        
        let isrVarejo = simulatorProjection.ISR_VAREJO ?? 0.0
        self.isrVarejoResultLabel.text = Utils.formatPercentual(isrVarejo)
        
        let volumesUsados = simulatorProjection.VOLUMES_USADOS ?? 0.0
        self.volumesUsadosResultLabel.text = Utils.formatCasaDecimal(volumesUsados)
        
        let volumesNovos = simulatorProjection.VOLUMES_NOVOS ?? 0.0
        self.volumesNovosResultLabel.text = Utils.formatCasaDecimal(volumesNovos)
        
        let pontosContrato = simulatorProjection.PONTOS_POR_CONTRATO ?? 0.0
        self.pontosContratoResultLabel.text = Utils.formatCasaDecimal(pontosContrato)
        
        let indicePerformado = simulatorProjection.INDICE_PERFORMADO ?? 0.0
        self.indicePerformadoResultLabel.text = Utils.formatPercentual(indicePerformado)
        
        let indiceProjetado = simulatorProjection.INDICE_PROJETADO ?? 0.0
        self.indiceProjetadoResultLabel.text = Utils.formatPercentual(indiceProjetado)
        
        let variacaoIndice = simulatorProjection.VARIACAO_INDICE ?? 0.0
        self.variacaoIndiceResultLabel.text = Utils.formatCasaDecimal(variacaoIndice) + "pp"
        
        let mixTabela = simulatorProjection.MIX_TABELA ?? 0.0
        self.mixTabelaResultLabel.text = Utils.formatPercentual(mixTabela)
        
        let valorMedioFimMes = simulatorProjection.VALOR_MEDIO_FIN ?? 0.0
        self.valorMedioFimMesResultLabel.text = Utils.formatCasaDecimal(valorMedioFimMes)
        
        let comissaoMediaMes = simulatorProjection.COMISSAO_MEDIA_MES ?? 0.0
        self.comissaoMediaMesResultLabel.text = Utils.formatCasaDecimal(comissaoMediaMes)
        
        let comissaoProjetada = simulatorProjection.COMISSAO_PROJETADA ?? 0.0
        self.comissaoProjetadaResultLabel.text = Utils.formatCasaDecimal(comissaoProjetada)
        
        let  variacaoComissionalMes = simulatorProjection.VARIACAO_COMMISSIONAL_MENSAL ?? 0.0
        self.variacaoComissionalMesResultLabel.text = Utils.formatCasaDecimal( variacaoComissionalMes)
        
        self.isHiddeView(false)
        self.configTexts()
        self.removeSpinnerView()
    }
    
    private func configTexts() {
        
        let dataCarga = defaults.string(forKey: SystemKeys.DATA_CARGA)
        
        if dataCarga != nil {
            
            if let dataCarga = dataCarga {
                
                self.textoTopoLabel.text = "O índice projetado tem como base a performance atualizada até " + Utils.formatDataHora(dataCarga) + " e poderá sofrer alterações. Os valores apresentados não garantem qualquer tipo de remuneração."
                
                self.textoRodapeLabel.text = "O índice projetado tem como base a performance atualizada até " + Utils.formatDataHora(dataCarga) + " e poderá sofrer alterações. Os valores apresentados não garantem qualquer tipo de remuneração."
                
            }
            
        }
    }
    
    private func configCards() {
        penetrationVarejoCardView.dropShadowSimulador()
        penetrationVarejoCardView.cornerRadius(radius: 15)
        
        isrVarejoCardView.dropShadowSimulador()
        isrVarejoCardView.cornerRadius(radius: 15)
        
        volumesUsadosCardView.dropShadowSimulador()
        volumesUsadosCardView.cornerRadius(radius: 15)
        
        volumesNovosCardView.dropShadowSimulador()
        volumesNovosCardView.cornerRadius(radius: 15)
        
        pontosContratoCardView.dropShadowSimulador()
        pontosContratoCardView.cornerRadius(radius: 15)
        
        indicePerformadoCardView.dropShadowSimulador()
        indicePerformadoCardView.cornerRadius(radius: 15)
        
        indiceProjetadoCardView.dropShadowSimulador()
        indiceProjetadoCardView.cornerRadius(radius: 15)
        
        variacaoIndiceCardView.dropShadowSimulador()
        variacaoIndiceCardView.cornerRadius(radius: 15)
        
        mixTabelaCardView.dropShadowSimulador()
        mixTabelaCardView.cornerRadius(radius: 15)
        
        valorMedioFimMesCardView.dropShadowSimulador()
        valorMedioFimMesCardView.cornerRadius(radius: 15)
        
        comissaoMediaMesCardView.dropShadowSimulador()
        comissaoMediaMesCardView.cornerRadius(radius: 15)
        
        comissaoProjetadaCardView.dropShadowSimulador()
        comissaoProjetadaCardView.cornerRadius(radius: 15)
        
        variacaoComissionalMesCardView.dropShadowSimulador()
        variacaoComissionalMesCardView.cornerRadius(radius: 15)
        
        
        novaSimulacaoButton.layer.borderColor = UIColor(hex: 0x0182D6).cgColor
        novaSimulacaoButton.layer.borderWidth = 1.0
        novaSimulacaoButton.layer.cornerRadius = 15
    }
    
    private func isHiddeView(_ hide: Bool) {
        penetrationVarejoCardView.isHidden = hide
        isrVarejoCardView.isHidden = hide
        
        volumesUsadosCardView.isHidden = hide
        
        volumesNovosCardView.isHidden = hide
        
        pontosContratoCardView.isHidden = hide
        
        indicePerformadoCardView.isHidden = hide
        
        indiceProjetadoCardView.isHidden = hide
        
        variacaoIndiceCardView.isHidden = hide
        
        mixTabelaCardView.isHidden = hide
        
        valorMedioFimMesCardView.isHidden = hide
        
        comissaoMediaMesCardView.isHidden = hide
        
        comissaoProjetadaCardView.isHidden = hide
        
        variacaoComissionalMesCardView.isHidden = hide
        
    }
    
}





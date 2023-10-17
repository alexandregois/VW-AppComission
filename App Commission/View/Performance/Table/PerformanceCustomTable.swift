//
//  PerformanceCustomTable.swift
//  App Commission
//
//  Created by Alexandre Gois on 07/08/23.
//

import Foundation
import UIKit

class PerformanceCustomTable: UIViewController, UIScrollViewDelegate {
    
    let defaults = UserDefaults.standard
    
    var tipoPerformance: UILabel
    var isAcumulado: Bool
    
    var volumePenetration: VolumePenetrationModel?
    var volumePenetrationCdDns:[VolumePenetrationCdDn] = []
    
    var periods: [String] = []
    var allPeriods: [String] = []
    
    @IBOutlet weak var viewTabela: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var textoRodapeLabel: UILabel!
    
    @IBOutlet weak var genericErrorMsg: UILabel!
    
    @IBOutlet weak var tituloTabela: UILabel!
    @IBOutlet weak var linkFrota: UILabel!
    
    @IBOutlet weak var periodsSelectField: UITextField!
    var periodsSelected: String?
    
    @IBOutlet weak var performanceTableView: UITableView!
    
    var periodsPickerView = UIPickerView()
    
    let modelName = UIDevice.current.name
    
    
    public init(isFrota: Bool, tipoPerformance: UILabel, isAcumulado: Bool) {
        
        self.tipoPerformance = tipoPerformance
        self.isAcumulado = isAcumulado
        
        super.init(nibName: "PerformanceVolumePenetration", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implementerd")
    }
    
    private func configTexts() {
        
        let dataCarga = defaults.string(forKey: SystemKeys.DATA_CARGA)
        
        if dataCarga != nil {
            
            if let dataCarga = dataCarga {
                
                self.textoRodapeLabel.text = "Os volumes apresentados tem como base a performance atualizada até " + Utils.formatDataHora(dataCarga) + " e poderá sofrer alterações. Os valores apresentados não garantem qualquer tipo de remuneração."
                
            }
            
        }
    }
    
    override func viewDidLoad() {
        print(modelName)
        viewTabela.dropShadowSimulador()
        viewTabela.cornerRadius(radius: 15)
        self.createSecondNavBar(true)
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(endEdit))
        view.addGestureRecognizer(tap)
        viewTabela.frame = CGRect(x: viewTabela.layer.position.x, y: viewTabela.layer.position.y, width: self.performanceTableView.bounds.width, height: viewTabela.bounds.height)
        
        self.performanceTableView.register(UINib(nibName: "PerformanceCustomTableViewCell", bundle: nil), forCellReuseIdentifier: "PerformanceCustomTableViewCell")
        
        super.viewDidLoad()
        scrollView.delegate = self
        
        linkFrota.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(linkFrotaTapped))
        linkFrota.addGestureRecognizer(tapGesture)
        
        
        periodsPickerView.tag = 1
        periodsSelectField.placeholder = "Selecione"
        
        periodsSelectField.cornerRadius(radius: 25)
        
        periodsSelectField.inputView = periodsPickerView
        periodsSelectField.inputView?.cornerRadius(radius: 25)
        periodsPickerView.delegate = self
        
        periodsPickerView.dataSource = self
        
        self.genericErrorMsg.isHidden = true
        self.performanceTableView.delegate = self
        self.performanceTableView.dataSource = self
        self.performanceTableView.separatorStyle = .none
        self.performanceTableView.layer.cornerRadius = 15
        self.performanceTableView.backgroundColor = .clear
        
        self.montaTituloLink()
        
        self.getPeriods()
        self.getPerformanceCustom(isFrota: false, tipoPerformance: self.tipoPerformance, isAcumulado: self.isAcumulado, actualPeriod: nil)
        
        self.configTexts()
        
    }
    
    @objc func endEdit() {
        view.endEditing(true)
    }
    
    func montaTituloLink()
    {
        if let tipoPerformanceText = tipoPerformance.text {
            var textoLink = ""
            
            if tipoPerformanceText == "Financiamento de Veículos Usados" {
                self.tituloTabela.text = "\(tipoPerformanceText)"
            } else {
                self.tituloTabela.text = "\(tipoPerformanceText) - Varejo"
                textoLink = "\(tipoPerformanceText) - Frota"
            }
            
            
            let attributedString = NSMutableAttributedString.init(string: textoLink)
            
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range:
                                            NSRange.init(location: 0, length: attributedString.length));
            linkFrota.attributedText = attributedString
        }
    }
    
    @objc func linkFrotaTapped() {
        let vc = PerformanceFrotaCustomTable(isFrota: true, tipoPerformance: self.tipoPerformance, isAcumulado: true)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func getPeriods()
    {
        self.createSpinnerView()
        
        VolumePenetrationService.shared.getPeriodosVolumePenetration { periods, error in
            
            self.removeSpinnerView()
            
            if let periods = periods {
                
                let list = periods.listMeses
                self.allPeriods = list.map { String($0) } + ["Acumulado Período"]
                self.periods = list.map { String($0) } + ["Acumulado Período"]
                
                self.periodsSelectField.text = "Acumulado Período"
                
                self.periodsSelectField.textColor = .darkGray
                
                self.periodsPickerView.reloadAllComponents()
                
            } else {
                
                let alertController = UIAlertController(title: "Ops..", message: "Estamos passando por algum problema.. :(", preferredStyle: .alert)
                
                let confirmAction = UIAlertAction(title: "ok", style: .default) { (action) in
                    
                    self.dismiss(animated: true, completion: nil)
                    
                }
                
                alertController.addAction(confirmAction)
                
                self.present(alertController, animated: true, completion: nil)
                
                self.periodsSelectField.isEnabled = false
            }
            
        }
    }
    
    
    private func getPerformanceCustom(isFrota: Bool, tipoPerformance: UILabel, isAcumulado: Bool, actualPeriod: String?) {
        
        switch tipoPerformance.text {
        case "Aak": //Aak
            
            VolumePenetrationService.shared.getVolumePenetrationAak(isFrota: isFrota, acumulado: isAcumulado, actualPeriod: actualPeriod) { volumePerformance, error in
                self.removeSpinnerView()
                if let volumePerformance = volumePerformance {
                    self.genericErrorMsg.isHidden = true
                    self.volumePenetration = volumePerformance
                    if let listCdDn = volumePerformance.listCdDn {
                        self.volumePenetrationCdDns = listCdDn
                        self.volumePenetrationCdDns.append(VolumePenetrationCdDn())
                    } else {
                        self.volumePenetrationCdDns = [] // Limpa o array se não houver dados
                    }
                    self.performanceTableView.reloadData()
                    
                } else {
                    self.genericErrorMsg.isHidden = false
                    self.volumePenetrationCdDns = [] // Limpa o array em caso de erro
                    self.performanceTableView.reloadData()
                }
            }
            
        case "Consórcio": //Consórcio
            
            VolumePenetrationService.shared.getVolumePenetrationConsorcio(isFrota: isFrota, acumulado: isAcumulado, actualPeriod: actualPeriod) { volumePerformance, error in
                self.removeSpinnerView()
                if let volumePerformance = volumePerformance {
                    self.genericErrorMsg.isHidden = true
                    self.volumePenetration = volumePerformance
                    if let listCdDn = volumePerformance.listCdDn {
                        self.volumePenetrationCdDns = listCdDn
                        self.volumePenetrationCdDns.append(VolumePenetrationCdDn())
                    } else {
                        self.volumePenetrationCdDns = [] // Limpa o array se não houver dados
                    }
                    self.performanceTableView.reloadData()
                    
                } else {
                    self.genericErrorMsg.isHidden = false
                    self.volumePenetrationCdDns = [] // Limpa o array em caso de erro
                    self.performanceTableView.reloadData()
                }
            }
            
        case "Financiamento de Veículos Novos": //Veículos Novos
            
            VolumePenetrationService.shared.getVolumePenetrationVeiculosNovos(isFrota: isFrota, acumulado: isAcumulado, actualPeriod: actualPeriod) { volumePerformance, error in
                self.removeSpinnerView()
                if let volumePerformance = volumePerformance {
                    self.genericErrorMsg.isHidden = true
                    self.volumePenetration = volumePerformance
                    if let listCdDn = volumePerformance.listCdDn {
                        self.volumePenetrationCdDns = listCdDn
                        self.volumePenetrationCdDns.append(VolumePenetrationCdDn())
                    } else {
                        self.volumePenetrationCdDns = [] // Limpa o array se não houver dados
                    }
                    self.performanceTableView.reloadData()
                    
                } else {
                    self.genericErrorMsg.isHidden = false
                    self.volumePenetrationCdDns = [] // Limpa o array em caso de erro
                    self.performanceTableView.reloadData()
                }
            }
            
        case "Financiamento de Veículos Usados": //Veículos Usados
            
            VolumePenetrationService.shared.getVolumePenetrationVeiculosUsados(isFrota: isFrota, acumulado: isAcumulado, actualPeriod: actualPeriod) { volumePerformance, error in
                self.removeSpinnerView()
                if let volumePerformance = volumePerformance {
                    self.genericErrorMsg.isHidden = true
                    self.volumePenetration = volumePerformance
                    if let listCdDn = volumePerformance.listCdDn {
                        self.volumePenetrationCdDns = listCdDn
                        self.volumePenetrationCdDns.append(VolumePenetrationCdDn())
                    } else {
                        self.volumePenetrationCdDns = [] // Limpa o array se não houver dados
                    }
                    self.performanceTableView.reloadData()
                    
                } else {
                    self.genericErrorMsg.isHidden = false
                    self.volumePenetrationCdDns = [] // Limpa o array em caso de erro
                    self.performanceTableView.reloadData()
                }
            }
            
        default: //penetration
            
            VolumePenetrationService.shared.getVolumePenetration(isFrota: isFrota, acumulado: isAcumulado, actualPeriod: actualPeriod) { volumePerformance, error in
                self.removeSpinnerView()
                if let volumePerformance = volumePerformance {
                    self.genericErrorMsg.isHidden = true
                    self.volumePenetration = volumePerformance
                    if let listCdDn = volumePerformance.listCdDn {
                        self.volumePenetrationCdDns = listCdDn
                        self.volumePenetrationCdDns.append(VolumePenetrationCdDn())
                    } else {
                        self.volumePenetrationCdDns = [] // Limpa o array se não houver dados
                    }
                    self.performanceTableView.reloadData()
                    
                } else {
                    self.genericErrorMsg.isHidden = false
                    self.volumePenetrationCdDns = [] // Limpa o array em caso de erro
                    self.performanceTableView.reloadData()
                }
            }
            
        }
        performanceTableView.isHidden = false
    }
    
}

extension PerformanceCustomTable: UITableViewDelegate, UITableViewDataSource, UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch pickerView.tag {
        case 1:
            return periods.count
        default:
            return 1
            
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        switch pickerView.tag {
        case 1:
            return periods[row]
        default:
            return "Data not found"
            
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch pickerView.tag {
            
        case 1:
            performanceTableView.isHidden = true
            self.createSpinnerView()
            let selectedPeriod = periods[row]
            periodsSelectField.text = selectedPeriod
            
            let isAcumuladoSelected = selectedPeriod == "Acumulado Período"
            
            if isAcumuladoSelected {
                let periodo = defaults.string(forKey: SystemKeys.ACTUAL_PERIOD)
                self.getPerformanceCustom(isFrota: false, tipoPerformance: self.tipoPerformance, isAcumulado: isAcumuladoSelected, actualPeriod: periodo)
            } else {
                self.getPerformanceCustom(isFrota: false, tipoPerformance: self.tipoPerformance, isAcumulado: isAcumuladoSelected, actualPeriod: selectedPeriod)
            }
            
            periodsSelectField.resignFirstResponder()
            
        default:
            
            self.periodsSelectField.text = "Acumulado Período"
            
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return volumePenetrationCdDns.count + 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1.5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = performanceTableView.dequeueReusableCell(withIdentifier: "PerformanceCustomTableViewCell", for: indexPath) as! PerformanceCustomTableViewCell
        
        if volumePenetrationCdDns.count == 0 {
            return cell
        }
        
        if indexPath.section == 0 {
            cell.textoEsquerdo.text = "DN"
            cell.textoDireito.text = periodsSelectField.text
            cell.configurarCores(viewDireitaColor: UIColor(hex: 0x001E50), textoDireitoColor: .white)
        }
        // Se for a última seção
        else if indexPath.section == (volumePenetrationCdDns.count) {
            cell.textoEsquerdo.text = volumePenetration?.grupo
            
            if tipoPerformance.text == "Penetration" {
                if let valor = volumePenetration?.nrGrupo.map { String(Float($0)) } {
                    cell.textoDireito.text = "\(valor) %"
                }
            } else {
                if let valor = volumePenetration?.nrGrupo.map { String(Int($0)) } {
                    cell.textoDireito.text = "\(valor)"
                }
            }
            
            cell.configurarCores(viewDireitaColor: UIColor(hex: 0x001E50), textoDireitoColor: .white)
        }
        else {
            let volumePenetrationCdDn = volumePenetrationCdDns[indexPath.section - 1]
            
            cell.textoEsquerdo.text = "\(volumePenetrationCdDn.cdDn ?? 0)"
            
            if tipoPerformance.text == "Penetration" {
                let valor = String(format: "%.2f", volumePenetrationCdDn.valueCdDn!)
                cell.textoDireito.text = "\(valor) %"
            } else {
                let roundedValue = Int(volumePenetrationCdDn.valueCdDn ?? 0.0)
                cell.textoDireito.text = "\(roundedValue)"
            }
            
            cell.configurarCores(viewDireitaColor: UIColor(hex: 0xF2F2F7), textoDireitoColor: .gray)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if volumePenetrationCdDns.count == 0 {
            return 0
        }
        return 70
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x != 0 {
            scrollView.contentOffset.x = 0
        }
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

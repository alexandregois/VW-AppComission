//
//  ProdutosAgregadosFrotaViewController.swift
//  App Commission
//
//  Created by Alexandre Gois on 16/08/23.
//

import Foundation
import UIKit

struct ListItemTabelaFrota {
    let chave: String
    let valor: Int
}

class ProdutosAgregadosFrotaViewController: UIViewController, UIScrollViewDelegate {
    
    let defaults = UserDefaults.standard
    
    var isFrota: Bool
    var tipoPerformance: UILabel
    var isAcumulado: Bool
    var nm_grp_comission: String?
    var cd_dn: String?
    var keyboarIsOpen: Bool = false
    
    var countProduto: Int = 0
    var countIsr: Int = 0
    
    var volumePenetration: VolumePenetrationModel?
    var volumePenetrationCdDns:[VolumePenetrationCdDn] = []
    
    var volumePenetrationProdutosAgregados: [ListItemTabelaFrota] = []
    
    var volumePerformance: VolumePenetrationProdutosAgregadosModel?
    
    var periods: [String] = []
    var allPeriods: [String] = []
    
    var listDns: [String] = []
    var allListDns: [String] = []
    
    @IBOutlet weak var viewTableHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewContentHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var viewTabela: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var textoRodapeLabel: UILabel!
    @IBOutlet weak var genericErrorMsg: UILabel!
    @IBOutlet weak var tituloTabela: UILabel!
    @IBOutlet weak var linkFrota: UILabel!
    @IBOutlet weak var periodsSelectField: UITextField!
    
    @IBOutlet weak var tituloSelectField: UILabel!
    
    var periodsSelected: String?
    @IBOutlet weak var performanceTableView: UITableView!
    var periodsPickerView = UIPickerView()
    let modelName = UIDevice.current.name
    @IBOutlet weak var viewSelectedIsr: UIView!
    @IBOutlet weak var viewSelectedProdutos: UIView!
    @IBOutlet weak var viewSelected: UIView!
    
    @IBOutlet weak var labelSelectedIsr: UILabel!
    @IBOutlet weak var labelSelectedProdutos: UILabel!
    
    public init(isFrota: Bool, tipoPerformance: UILabel, isAcumulado: Bool)//, nm_grp_comission: String?, cd_dn: String?)
    {
        
        self.isFrota = isFrota
        self.tipoPerformance = tipoPerformance
        self.isAcumulado = isAcumulado
        
        super.init(nibName: "ProdutosAgregadosViewController", bundle: nil)
        
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
        linkFrota.isHidden = true
        viewTabela.dropShadow()
        viewTabela.cornerRadius(radius: 15)
        
        self.labelSelectedProdutos.textColor = .darkGray
        self.viewSelectedProdutos.backgroundColor = .white
        
        self.createSecondNavBar(true)
        viewTabela.frame = CGRect(x: viewTabela.layer.position.x, y: viewTabela.layer.position.y, width: self.performanceTableView.bounds.width, height: viewTabela.bounds.height)
        
        self.performanceTableView.register(UINib(nibName: "PerformanceCustomTableViewCell", bundle: nil), forCellReuseIdentifier: "PerformanceCustomTableViewCell")
        self.performanceTableView.register(UINib(nibName: "PerformanceCustomTableViewCellLink", bundle: nil), forCellReuseIdentifier: "PerformanceCustomTableViewCellLink")
        
        super.viewDidLoad()
        scrollView.delegate = self
        
        linkFrota.isUserInteractionEnabled = true
        
        let tapLinkFrotaGesture = UITapGestureRecognizer(target: self, action: #selector(linkFrotaTapped))
        linkFrota.addGestureRecognizer(tapLinkFrotaGesture)
        
        let tapGestureIsr = UITapGestureRecognizer(target: self, action: #selector(handleTapOnIsr))
        viewSelectedIsr.addGestureRecognizer(tapGestureIsr)
        
        let tapGestureProdutos = UITapGestureRecognizer(target: self, action: #selector(handleTapOnProdutos))
        viewSelectedProdutos.addGestureRecognizer(tapGestureProdutos)
        
        
        viewSelectedIsr.dropShadow()
        viewSelectedIsr.cornerRadius(radius: 15)
        
        viewSelectedProdutos.dropShadow()
        viewSelectedProdutos.cornerRadius(radius: 15)
        
        viewSelected.dropShadowSimulador()
        viewSelected.cornerRadius(radius: 15)
        
        periodsPickerView.tag = 1
        periodsSelectField.cornerRadius(radius: 25)
        
        periodsSelectField.inputView = periodsPickerView
        //periodsSelectField.inputView?.cornerRadius(radius: 25)
        
        periodsPickerView.delegate = self
        periodsPickerView.dataSource = self
        
        self.genericErrorMsg.isHidden = true
        self.performanceTableView.delegate = self
        self.performanceTableView.dataSource = self
        self.performanceTableView.separatorStyle = .none
        self.performanceTableView.layer.cornerRadius = 15
        self.performanceTableView.backgroundColor = .clear
        
        
        self.selectIsr()
        
        self.montaTituloLink()
        
        self.getPeriods()
        self.getPerformanceCustom(isFrota: self.isFrota, tipoPerformance: self.tipoPerformance, isAcumulado: self.isAcumulado, actualPeriod: nil, cd_dn: nil)
        
        self.countIsr = 1
        
        self.configTexts()
        
        
    }
    
    @objc func handleTapOnIsr(sender: UITapGestureRecognizer) {
        
        self.countProduto = 0
        
        if (self.countIsr == 0)
        {
            selectIsr()
            
            self.isFrota = true
            self.isAcumulado = true
            self.tipoPerformance.text = "ISR Período Vigente"
            self.tituloSelectField.text = "Volume Contemplado"
            self.tituloTabela.text = "ISR Período Vigente - Frota"
            
            self.montaTituloLink()
            
            self.getPeriods()
            
            self.getPerformanceCustom(isFrota: self.isFrota, tipoPerformance: self.tipoPerformance, isAcumulado: self.isAcumulado, actualPeriod: nil, cd_dn: nil)
            
            self.countIsr = 1
        }
        
    }
    
    func selectProduto()
    {
        self.tipoPerformance.text = "Volume Produtos Agregados"
        self.tituloTabela.text = "Volume Produtos Agregados - Frota"
        self.labelSelectedIsr.textColor = .darkGray
        self.viewSelectedIsr.backgroundColor = .white
        self.labelSelectedProdutos.textColor = .white
        self.viewSelectedProdutos.backgroundColor = .systemBlue
        
    }
    
    func selectIsr()
    {
        self.tipoPerformance.text = "ISR Período Vigente"
        self.tituloTabela.text = "ISR Período Vigente - Frota"
        self.labelSelectedProdutos.textColor = .darkGray
        self.viewSelectedProdutos.backgroundColor = .white
        self.labelSelectedIsr.textColor = .white
        self.viewSelectedIsr.backgroundColor = .systemBlue
        
    }
    
    
    @objc func handleTapOnProdutos(sender: UITapGestureRecognizer) {
        
        self.countIsr = 0
        
        if (self.countProduto == 0)
        {
            selectProduto()
            
            self.isFrota = true
            self.isAcumulado = true
            self.tipoPerformance.text = "Volume Produtos Agregados"
            self.tituloSelectField.text = "Grupo/DN"
            self.tituloTabela.text = "Volume Produtos Agregados - Frota"
            
            self.montaTituloLink()
            
            getListaDnGrupo(actualPeriod: nil, codigoDealer: nil, nm_grp_comission: nm_grp_comission)
            
            self.getPerformanceCustom(isFrota: self.isFrota, tipoPerformance: self.tipoPerformance, isAcumulado: self.isAcumulado, actualPeriod: nil, cd_dn: nil)
            
            self.countProduto = 1
        }
    }
    
    func montaTituloLink()
    {
        if let tipoPerformanceText = tipoPerformance.text {
            
            var textoLink = ""
            if linkFrota != nil && !self.isFrota {
                textoLink = "\(tipoPerformanceText) - Frota"
            } else {
                textoLink = "\(tipoPerformanceText) - Varejo"
            }
            
            let attributedString = NSMutableAttributedString.init(string: textoLink)
            
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range:
                                            NSRange.init(location: 0, length: attributedString.length));
            linkFrota.attributedText = attributedString
        }
        
    }
    
    func adjustTableViewHeight() {
        
        self.performanceTableView.layoutIfNeeded()
        let height = self.performanceTableView.contentSize.height
        self.tableViewHeightConstraint.constant = height
        
        self.viewTableHeightConstraint.constant = height - 550
        self.viewTabela.layoutIfNeeded()
        
        self.viewContentHeightConstraint.constant = height + 700
    }
    
    @objc func linkFrotaTapped() {
        
        if (tipoPerformance.text == "ISR Período Vigente")
        {
            let tipoPerformanceLabel = UILabel()
            tipoPerformanceLabel.text = "ISR Período Vigente"
            let performanceProdutosAgregados = ProdutosAgregadosViewController(isFrota: false, tipoPerformance: tipoPerformanceLabel, isAcumulado: self.isAcumulado)
            self.navigationController?.pushViewController(performanceProdutosAgregados, animated: true)
            
        }
        else
        {
            let tipoPerformanceLabel = UILabel()
            tipoPerformanceLabel.text = "Volume Produtos Agregados"
            let performanceProdutosAgregados = ProdutosAgregadosViewController(isFrota: false, tipoPerformance: tipoPerformanceLabel, isAcumulado: self.isAcumulado)
            self.navigationController?.pushViewController(performanceProdutosAgregados, animated: true)
        }
        
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
    
    func getListaDnGrupo(actualPeriod: String?, codigoDealer: String?, nm_grp_comission: String?)
    {
        self.createSpinnerView()
        
        VolumePenetrationService.shared.getListaDnGrupo(actualPeriod: actualPeriod, codigoDealer: codigoDealer) { listDns, error in
            
            self.removeSpinnerView()
            
            if let listDns = listDns {
                
                let list = listDns.listCdDn
                var mappedList = list.map { String($0) }
                
                let grupo = listDns.grupo
                mappedList.append(grupo)
                self.nm_grp_comission = grupo
                
                self.allListDns = mappedList
                self.listDns = mappedList
                
                self.periodsSelectField.text = grupo
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
    
    private func getPerformanceCustom(isFrota: Bool, tipoPerformance: UILabel, isAcumulado: Bool, actualPeriod: String?, cd_dn: String?) {
                
        self.volumePenetrationCdDns = []
        self.volumePenetrationProdutosAgregados = []
        
        self.createSpinnerView()
        
        switch tipoPerformance.text {
        case "ISR Período Vigente": //Isr
            
            VolumePenetrationService.shared.getVolumePenetrationIsrGrupo(isFrota: isFrota, acumulado: isAcumulado, actualPeriod: actualPeriod) { volumePerformance, error in
                self.removeSpinnerView()
                if let volumePerformance = volumePerformance {
                    self.genericErrorMsg.isHidden = true
                    self.volumePenetration = volumePerformance
                    if let listCdDn = volumePerformance.listCdDn {
                        self.volumePenetrationCdDns = listCdDn
                    } else {
                        self.volumePenetrationCdDns = []
                    }
                    self.performanceTableView.reloadData()
                    
                } else {
                    self.genericErrorMsg.isHidden = false
                    self.volumePenetrationCdDns = []
                    self.performanceTableView.reloadData()
                }
            }
            
        default: //Produtos Agregados
            
            VolumePenetrationService.shared.getVolumeProdutosAgregados(isFrota: isFrota, actualPeriod: actualPeriod, nm_grp_comission: nm_grp_comission, cd_dn: cd_dn) { volumePerformance, error in
                self.removeSpinnerView()
                if let volumePerformance = volumePerformance {
                    self.genericErrorMsg.isHidden = true
                    self.volumePerformance = volumePerformance
                    self.volumePenetration?.grupo = volumePerformance.grupo
                    self.volumePenetration?.nrExercicio = volumePerformance.nrExercicio
                    self.volumePenetration?.segmento = volumePerformance.tpSegmento
                    
                    let valorAcidentesPessoais = volumePerformance.acidentesPessoais ?? 0
                    self.volumePenetrationProdutosAgregados.append(ListItemTabelaFrota(chave: "Acidentes Pessoais", valor: valorAcidentesPessoais))
                    
                    let valorFranquia = volumePerformance.franquia ?? 0
                    self.volumePenetrationProdutosAgregados.append(ListItemTabelaFrota(chave: "Franquia", valor: valorFranquia))
                    
                    let valorGap = volumePerformance.gap ?? 0
                    self.volumePenetrationProdutosAgregados.append(ListItemTabelaFrota(chave: "Gap", valor: valorGap))
                    
                    let valorGarantia = volumePerformance.garantiaExtendida ?? 0
                    self.volumePenetrationProdutosAgregados.append(ListItemTabelaFrota(chave: "Garantia Extendida", valor: valorGarantia))
                    
                    let valorPps = volumePerformance.pps ?? 0
                    self.volumePenetrationProdutosAgregados.append(ListItemTabelaFrota(chave: "PPS", valor: valorPps))
                    
                    let valorSeguro = volumePerformance.seguroCasco ?? 0
                    self.volumePenetrationProdutosAgregados.append(ListItemTabelaFrota(chave: "Seguro Casco", valor: valorSeguro))
                    
                    let valorSpf = volumePerformance.spf ?? 0
                    self.volumePenetrationProdutosAgregados.append(ListItemTabelaFrota(chave: "SPF", valor: valorSpf))
                    
                    self.performanceTableView.reloadData()
                    
                    self.adjustTableViewHeight()
                    
                } else {
                    self.genericErrorMsg.isHidden = false
                    self.volumePenetrationProdutosAgregados = []
                    self.performanceTableView.reloadData()
                }
            }
            
        }
        
    }
    
}

extension ProdutosAgregadosFrotaViewController: UITableViewDelegate, UITableViewDataSource, UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch pickerView.tag {
        case 1:
            
            if (tipoPerformance.text == "ISR Período Vigente")
            {
                return periods.count
            }
            else
            {
                return listDns.count
            }
            
        default:
            return 1
            
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        keyboarIsOpen = true
        switch pickerView.tag {
        case 1:
            
            if (tipoPerformance.text == "ISR Período Vigente")
            {
                return periods[row]
            }
            else
            {
                return listDns[row]
            }
            
        default:
            return "Data not found"
            
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch pickerView.tag {
            
        case 1:
            
            if (tipoPerformance.text == "ISR Período Vigente")
            {
                let selectedPeriod = periods[row]
                periodsSelectField.text = selectedPeriod
                
                let isAcumuladoSelected = selectedPeriod == "Acumulado Período"
                
                if isAcumuladoSelected {
                    let periodo = defaults.string(forKey: SystemKeys.ACTUAL_PERIOD)
                    self.getPerformanceCustom(isFrota: self.isFrota, tipoPerformance: self.tipoPerformance, isAcumulado: isAcumuladoSelected, actualPeriod: periodo, cd_dn: nil)
                } else {
                    self.getPerformanceCustom(isFrota: self.isFrota, tipoPerformance: self.tipoPerformance, isAcumulado: isAcumuladoSelected, actualPeriod: selectedPeriod, cd_dn: nil)
                }
                
            }
            else
            {
                
                let selectedCdDn = listDns[row]
                periodsSelectField.text = selectedCdDn
                self.getPerformanceCustom(isFrota: self.isFrota, tipoPerformance: self.tipoPerformance, isAcumulado: false, actualPeriod: nil, cd_dn: selectedCdDn)
                
            }
            
            periodsSelectField.resignFirstResponder()
            
        default:
            
            self.periodsSelectField.text = "Selecione"
            
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if tipoPerformance.text != "ISR Período Vigente" {
            return volumePenetrationProdutosAgregados.count + 1
        } else {
            return volumePenetrationCdDns.count + 1
        }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if keyboarIsOpen {
            view.endEditing(true)
            keyboarIsOpen = false
        } else {
            if tableView.cellForRow(at: indexPath)?.tag == 100 {
                if indexPath.section - 1 == 3 {
                    let data = self.volumePerformance?.garantiaExtendidaList
                    let vc = DetalheTabelaViewController()
                    vc.garantiaExtendidaList = data
                    vc.isFrota = true
                    vc.ppsList = nil
                    vc.seguroCascoList = nil
                    vc.spfList = nil
                    vc.grpComission = self.periodsSelectField.text
                    vc.titulo = "Garantia Estendida Frota - Detalhe"
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
                if indexPath.section - 1 == 4 {
                    let data = self.volumePerformance?.ppsList
                    
                    let vc = DetalheTabelaViewController()
                    vc.ppsList = data
                    vc.isFrota = true
                    vc.seguroCascoList = nil
                    vc.spfList = nil
                    vc.garantiaExtendidaList = nil
                    vc.grpComission = self.periodsSelectField.text
                    vc.titulo = "PPS Frota - Detalhe"
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
                if indexPath.section - 1 == 5 {
                    let data = self.volumePerformance?.seguroCascoList
                    
                    let vc = DetalheTabelaViewController()
                    vc.seguroCascoList = data
                    vc.isFrota = true
                    vc.ppsList = nil
                    vc.spfList = nil
                    vc.garantiaExtendidaList = nil
                    vc.grpComission = self.periodsSelectField.text
                    vc.titulo = "Seguro Casco Frota - Detalhe"
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
                if indexPath.section - 1 == 6 {
                    
                    let data = self.volumePerformance?.spfList
                    let vc = DetalheTabelaViewController()
                    vc.spfList = data
                    vc.isFrota = true
                    vc.ppsList = nil
                    vc.seguroCascoList = nil
                    vc.garantiaExtendidaList = nil
                    vc.grpComission = self.periodsSelectField.text
                    vc.titulo = "SPF Frota - Detalhe"
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        var cell: UITableViewCell
            
        let usarCellLink = tipoPerformance.text != "ISR Período Vigente"
        && indexPath.section > 0
        && indexPath.section <= volumePenetrationProdutosAgregados.count
        && !["Acidentes Pessoais", "Franquia", "Gap"].contains(volumePenetrationProdutosAgregados[indexPath.section - 1].chave)
            
        if usarCellLink {
            let cellProdutosAgregados = performanceTableView.dequeueReusableCell(withIdentifier: "PerformanceCustomTableViewCellLink", for: indexPath) as! PerformanceCustomTableViewCellLink
            cell = cellProdutosAgregados
            cell.tag = 100
        } else {
            let cellRegular = performanceTableView.dequeueReusableCell(withIdentifier: "PerformanceCustomTableViewCell", for: indexPath) as! PerformanceCustomTableViewCell
            cell = cellRegular
            cell.tag = 1
        }
            
        if let specificCell = cell as? PerformanceCustomTableViewCell {
                
            switch indexPath.section {
            case 0: // Primeira seção
                specificCell.textoEsquerdo.text = "Grupo Commission"
                specificCell.textoDireito.text = periodsSelectField.text

                if (tipoPerformance.text == "Volume Produtos Agregados" && periodsSelectField.text == "Acumulado Período") {
                    periodsSelectField.text = volumePenetration?.grupo
                    specificCell.textoDireito.text = periodsSelectField.text
                }
                    
                specificCell.configurarCores(viewDireitaColor: UIColor(hex: 0x001E50), textoDireitoColor: .white)
                    
            case volumePenetrationCdDns.count: // Última seção
                specificCell.textoEsquerdo.text = volumePenetration?.grupo
                specificCell.textoDireito.text = String(format: "%.2f", volumePenetration?.nrGrupo ?? 0.0)
                specificCell.configurarCores(viewDireitaColor: UIColor(hex: 0x001E50), textoDireitoColor: .white)
                    
            default:
                if indexPath.section > 0 && indexPath.section <= volumePenetrationProdutosAgregados.count {
                    let item = volumePenetrationProdutosAgregados[indexPath.section - 1]
                    specificCell.textoEsquerdo.text = item.chave
                    specificCell.textoDireito.text = "\(item.valor)"
                        
                    specificCell.configurarCores(viewDireitaColor: UIColor(hex: 0xF2F2F7), textoDireitoColor: .gray)
                        
                } else {
                    let volumePenetrationCdDn = volumePenetrationCdDns[indexPath.section]
                    specificCell.textoEsquerdo.text = "\(volumePenetrationCdDn.cdDn ?? 0)"
                    specificCell.textoDireito.text = tipoPerformance.text == "ISR Período Vigente" ? String(format: "%.2f", volumePenetrationCdDn.valueCdDn ?? 0.0) : "\(Int(volumePenetrationCdDn.valueCdDn ?? 0.0))"
                    specificCell.configurarCores(viewDireitaColor: UIColor(hex: 0xF2F2F7), textoDireitoColor: .gray)
                }
            }
                
        } else if let specificCellLink = cell as? PerformanceCustomTableViewCellLink {
            let item = volumePenetrationProdutosAgregados[indexPath.section - 1]
            specificCellLink.textoEsquerdo.text = item.chave
            specificCellLink.textoDireito.text = "\(item.valor)"
        }
            
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tipoPerformance.text != "ISR Período Vigente" {
            if volumePenetrationProdutosAgregados.count == 0 {
                return 0
            }
        } else {
            if volumePenetrationCdDns.count == 0 {
                return 0
            }
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


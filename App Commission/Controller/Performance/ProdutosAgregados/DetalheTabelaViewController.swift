//
//  DetalheTabelaViewController.swift
//  App Commission
//
//  Created by Camilo Oscar Girardelli Baptista on 16/08/23.
//

import Foundation
import UIKit

struct DataTabela {
    let chave: String
    let valor: String
    let hasDetalhes: Bool
}

class DetalheTabelaViewController: UIViewController, UIScrollViewDelegate,UITableViewDelegate, UITableViewDataSource {
    
    let defaults = UserDefaults.standard
    var garantiaExtendidaList: GarantiaExtendidaList?
    var ppsList: PPSList?
    var seguroCascoList: SeguroCascoList?
    var spfList: SPFList?
    var dataList:[DataTabela] = []
    @IBOutlet weak var frotaLabel: UILabel!
    var grpComission: String?
    var titulo: String?
    var isFrota: Bool = false
    
    let tipoList = ["listGarantiaEstEndIDACLP", "listGarantiaEstClpFin",
                    "listGarantiaEstClpAvi", "listGarantiaEstendidaVw", "listGarantiaEstendidaVwFin",
                     "listGarantiaEstendidaVwAvi", "listGEVwEssencial12", "listGEVwEssencial24",
                      "listGEVWEssenModelo12", "listGEVWEssenModelo24", "listGEVWEssenModelo36",
                       "listGEVWEssenModelo48", "listGEVWTotalModelo12"]
    
    @IBOutlet weak var viewTableHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewContentHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var viewTabela: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var textoRodapeLabel: UILabel!
    @IBOutlet weak var tituloLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    public init() {
        super.init(nibName: "DetalheTabelaViewController", bundle: nil)
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
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.tableView.layer.cornerRadius = 15
        self.tableView.backgroundColor = .clear
        tituloLabel.text = self.titulo!
        frotaLabel.isHidden = true
        createSecondNavBar(true)
        populateDataList()
        viewTabela.dropShadowSimulador()
        viewTabela.cornerRadius(radius: 15)
        viewTabela.frame = CGRect(x: viewTabela.layer.position.x, y: viewTabela.layer.position.y, width: self.tableView.bounds.width, height: viewTabela.bounds.height)
        self.tableView.register(UINib(nibName: "PerformanceCustomTableViewCell", bundle: nil), forCellReuseIdentifier: "PerformanceCustomTableViewCell")
        
        configTexts()
    }
    
    
    private func populateDataList() {
        if garantiaExtendidaList != nil {
            dataList = []
            dataList.append(DataTabela(chave: "Grupo Comission", valor: grpComission!, hasDetalhes: false))
            dataList.append(DataTabela(chave: "GARANTIA ESTENDIDA CLP", valor: "\(garantiaExtendidaList?.garantiaEstendidaClp ?? 0)", hasDetalhes: true))
            dataList.append(DataTabela(chave: "GAR ESTENDIDA CLP FIN", valor: "\(garantiaExtendidaList?.garEstendidaClpFin ?? 0)", hasDetalhes: true))
            dataList.append(DataTabela(chave: "GAR ESTENDIDA CLP AVI", valor: "\(garantiaExtendidaList?.garEstendidaClpAvi ?? 0)" , hasDetalhes: true))
            dataList.append(DataTabela(chave: "GARANTIA ESTENDIDA VW", valor: "\(garantiaExtendidaList?.garantiaEstendidaVw ?? 0)" , hasDetalhes: true))
            dataList.append(DataTabela(chave: "GAR ESTENDIDA VW FIN", valor: "\(garantiaExtendidaList?.garEstendidaVwFin ?? 0)" , hasDetalhes: true))
            dataList.append(DataTabela(chave: "GAR ESTENDIDA VW AVI", valor: "\(garantiaExtendidaList?.garEstendidaVwAvi ?? 0)" , hasDetalhes: true))
            dataList.append(DataTabela(chave: "GE VW ESSENCIAL 12", valor: "\(garantiaExtendidaList?.geVwEssencial12 ?? 0)" , hasDetalhes: true))
            dataList.append(DataTabela(chave: "GE VW ESSENCIAL 24", valor: "\(garantiaExtendidaList?.geVwEssencial24 ?? 0)" , hasDetalhes: true))
            dataList.append(DataTabela(chave: "GE VW TOTAL 12", valor: "\(garantiaExtendidaList?.geVwTotal12 ?? 0)" , hasDetalhes: true))
            dataList.append(DataTabela(chave: "GE VW TOTAL 24", valor: "\(garantiaExtendidaList?.geVwTotal24 ?? 0)" , hasDetalhes: true))
            dataList.append(DataTabela(chave: "GE ESS MODELO 12", valor: "\(garantiaExtendidaList?.geVwEssenModelo12 ?? 0)" , hasDetalhes: true))
            dataList.append(DataTabela(chave: "GE ESS MODELO 24", valor: "\(garantiaExtendidaList?.geVwEssenModelo24 ?? 0)" , hasDetalhes: true))
            dataList.append(DataTabela(chave: "GE ESS MODELO 36", valor: "\(garantiaExtendidaList?.geVwEssenModelo36 ?? 0)" , hasDetalhes: true))
            dataList.append(DataTabela(chave: "GE ESS MODELO 48", valor: "\(garantiaExtendidaList?.geVwEssenModelo48 ?? 0)" , hasDetalhes: true))
            dataList.append(DataTabela(chave: "GE TOTAL MODELO 12", valor: "\(garantiaExtendidaList?.geVwTotalModelo12 ?? 0)" , hasDetalhes: true))
            dataList.append(DataTabela(chave: "GE TOTAL MODELO 24", valor: "\(garantiaExtendidaList?.geVwTotalModelo24 ??  0)", hasDetalhes: false))
            dataList.append(DataTabela(chave: "GE TOTAL MODELO 36", valor: "\(garantiaExtendidaList?.geVwTotalModelo36 ?? 0)", hasDetalhes: false))
            dataList.append(DataTabela(chave: "GE TOTAL MODELO 48", valor: "\(garantiaExtendidaList?.geVwTotalModelo48 ?? 0)", hasDetalhes: false))
            dataList.append(DataTabela(chave: "AAP GE", valor: "\(garantiaExtendidaList?.aapGe ?? 0)", hasDetalhes: false))
            dataList.append(DataTabela(chave: "GE EVR", valor: "\(garantiaExtendidaList?.geEvr ?? 0)", hasDetalhes: false))
            dataList.append(DataTabela(chave: "GE VW ESSEN VI 12", valor: "\(garantiaExtendidaList?.geVwEssenVi12 ?? 0)", hasDetalhes: false))
            dataList.append(DataTabela(chave: "GE VW ESSEN VI 24", valor: "\(garantiaExtendidaList?.geVwEssenVi24 ?? 0)", hasDetalhes: false))
            dataList.append(DataTabela(chave: "GE VW ESSEN VI 36", valor: "\(garantiaExtendidaList?.geVwEssenVi36 ?? 0)", hasDetalhes: false))
            dataList.append(DataTabela(chave: "GE VW ESSEN VI 48", valor: "\(garantiaExtendidaList?.geVwEssenVi48 ?? 0)", hasDetalhes: false))
            dataList.append(DataTabela(chave: "GE VW ESSEN MOD VI 12", valor: "\(garantiaExtendidaList?.geVwEssenModVi12 ?? 0)", hasDetalhes: false))
            dataList.append(DataTabela(chave: "GE VW ESSEN MOD VI 24", valor: "\(garantiaExtendidaList?.geVwEssenModVi24 ?? 0)", hasDetalhes: false))
            dataList.append(DataTabela(chave: "GE VW ESSEN MOD VI 36", valor: "\(garantiaExtendidaList?.geVwEssenModVi36 ?? 0)", hasDetalhes: false))
            dataList.append(DataTabela(chave: "GE VW ESSEN MOD VI 48", valor: "\(garantiaExtendidaList?.geVwEssenModVi48 ?? 0)", hasDetalhes: false))
            dataList.append(DataTabela(chave: "GE VW TOTAL VI 12", valor: "\(garantiaExtendidaList?.geVwTotalVi12 ?? 0)", hasDetalhes: false))
            dataList.append(DataTabela(chave: "GE VW TOTAL VI 24", valor: "\(garantiaExtendidaList?.geVwTotalVi24 ?? 0)", hasDetalhes: false))
            dataList.append(DataTabela(chave: "GE VW TOTAL VI 36", valor: "\(garantiaExtendidaList?.geVwTotalVi36 ?? 0)", hasDetalhes: false))
            dataList.append(DataTabela(chave: "GE VW TOTAL VI 48", valor: "\(garantiaExtendidaList?.geVwTotalVi48 ?? 0)", hasDetalhes: false))
            dataList.append(DataTabela(chave: "GE VW TOTAL MOD VI 12", valor: "\(garantiaExtendidaList?.geVwTotalModVi12 ?? 0)", hasDetalhes: false))
            dataList.append(DataTabela(chave: "GE VW TOTAL MOD VI 24", valor: "\(garantiaExtendidaList?.geVwTotalModVi24 ?? 0)", hasDetalhes: false))
            dataList.append(DataTabela(chave: "GE VW TOTAL MOD VI 36", valor: "\(garantiaExtendidaList?.geVwTotalModVi36 ?? 0)", hasDetalhes: false))
            dataList.append(DataTabela(chave: "GE VW TOTAL MOD VI 48", valor: "\(garantiaExtendidaList?.geVwTotalModVi48 ?? 0)", hasDetalhes: false))
            dataList.append(DataTabela(chave: "GE VW TOTAL6", valor: "\(garantiaExtendidaList?.geVwTotal6 ?? 0)", hasDetalhes: false))
            dataList.append(DataTabela(chave: "GE VW ESSENCIAL6", valor: "\(garantiaExtendidaList?.geVwEssencial6 ?? 0)", hasDetalhes: false))
            dataList.append(DataTabela(chave: "GARANTIA MECANICA AAP", valor: "\(garantiaExtendidaList?.garantiaMecanicaAAP ?? 0)", hasDetalhes: false))
            dataList.append(DataTabela(chave: "GARANTIA MECANICA SNC", valor: "\(garantiaExtendidaList?.garantiaMecanicaSNC ?? 0)", hasDetalhes: false))
            dataList.append(DataTabela(chave: "GARANTIA MECANICA GM", valor: "\(garantiaExtendidaList?.garantiaMecanicaGM ?? 0)", hasDetalhes: false))
            dataList.append(DataTabela(chave: "GARANTIA MECANICA GM6", valor: "\(garantiaExtendidaList?.garantiaMecanicaGM6 ?? 0)", hasDetalhes: false))
            dataList.append(DataTabela(chave: "GM ESSENCIAL 12", valor: "\(garantiaExtendidaList?.gmEssencial12 ?? 0)", hasDetalhes: false))
            dataList.append(DataTabela(chave: "GM ESSENCIAL 24", valor: "\(garantiaExtendidaList?.gmEssencial24 ?? 0)", hasDetalhes: false))
            dataList.append(DataTabela(chave: "GM TOP 12", valor: "\(garantiaExtendidaList?.gmTop12 ?? 0)", hasDetalhes: false))
            dataList.append(DataTabela(chave: "GM TOP 24", valor: "\(garantiaExtendidaList?.gmTop24 ?? 0)", hasDetalhes: false))
            dataList.append(DataTabela(chave: "AAP GM", valor: "\(garantiaExtendidaList?.aapGm ?? 0)", hasDetalhes: false))
            dataList.append(DataTabela(chave: "GM ESSENCIAL6", valor: "\(garantiaExtendidaList?.gmEssencial6 ?? 0)", hasDetalhes: false))
            dataList.append(DataTabela(chave: "GM TOP6", valor: "\(garantiaExtendidaList?.gmTop6 ?? 0)", hasDetalhes: false))
        }
        
        if ppsList != nil {
            dataList = []
            dataList.append(DataTabela(chave: "Grupo Comission", valor: grpComission!, hasDetalhes: false))
            dataList.append(DataTabela(chave: "PPS A VISTA", valor: "\(ppsList?.ppsAVista ?? 0)", hasDetalhes: false))
            dataList.append(DataTabela(chave: "PPS FINANCIADO", valor: "\(ppsList?.ppsFinanciado ?? 0)", hasDetalhes: false))
            dataList.append(DataTabela(chave: "PPS A VISTA VENDA INTERNET", valor: "\(ppsList?.ppsAVistaVendaInternet ?? 0)", hasDetalhes: false))
        }
        
        if seguroCascoList != nil {
            dataList = []
            dataList.append(DataTabela(chave: "Grupo Comission", valor: grpComission!, hasDetalhes: false))
            dataList.append(DataTabela(chave: "SEG CASCO VAREJO FX1", valor: "\(seguroCascoList?.segCascoVarejoFX1 ?? 0)", hasDetalhes: false))
            dataList.append(DataTabela(chave: "SEG CASCO VAREJO FX2", valor: "\(seguroCascoList?.segCascoVarejoFX2 ?? 0)", hasDetalhes: false))
            dataList.append(DataTabela(chave: "SEG CASCO FROTA", valor: "\(seguroCascoList?.segCascoFrota ?? 0)", hasDetalhes: false))
            dataList.append(DataTabela(chave: "SEG PLURI 24 FX1", valor: "\(seguroCascoList?.segPluri24FX1 ?? 0)", hasDetalhes: false))
            dataList.append(DataTabela(chave: "SEG PLURI 24 FX2", valor: "\(seguroCascoList?.segPluri24FX2 ?? 0)", hasDetalhes: false))
            dataList.append(DataTabela(chave: "SEG PLURI 36 FX1", valor: "\(seguroCascoList?.segPluri36FX1 ?? 0)", hasDetalhes: false))
            dataList.append(DataTabela(chave: "SEG PLURI 36 FX2", valor: "\(seguroCascoList?.segPluri36FX2 ?? 0)", hasDetalhes: false))
            dataList.append(DataTabela(chave: "SEG DESC MAIOR", valor: "\(seguroCascoList?.segDescMaior ?? 0)", hasDetalhes: false))
            dataList.append(DataTabela(chave: "SEG PORTO SEGURO CASCO", valor: "\(seguroCascoList?.segPortoSeguroCasco ?? 0)", hasDetalhes: false))
            dataList.append(DataTabela(chave: "SEG CASCO DUPL", valor: "\(seguroCascoList?.segCascoDupl ?? 0)", hasDetalhes: false))
            dataList.append(DataTabela(chave: "SEG CASCO VAR VI 12", valor: "\(seguroCascoList?.segCascoVarVi12 ?? 0)", hasDetalhes: false))
            dataList.append(DataTabela(chave: "SEG CASCO VAR VI 24", valor: "\(seguroCascoList?.segCascoVarVi24 ?? 0)", hasDetalhes: false))
            dataList.append(DataTabela(chave: "SEG CASCO VAR VI 36", valor: "\(seguroCascoList?.segCascoVarVi36 ?? 0)", hasDetalhes: false))
            dataList.append(DataTabela(chave: "SEG CASCO VAR VI 48", valor: "\(seguroCascoList?.segCascoVarVi48 ?? 0)", hasDetalhes: false))
            dataList.append(DataTabela(chave: "SEGURO RF", valor: "\(seguroCascoList?.seguroRf ?? 0)", hasDetalhes: false))
        }
        
        if spfList != nil {
            dataList = []
            dataList.append(DataTabela(chave: "Grupo Comission", valor: grpComission!, hasDetalhes: false))
            dataList.append(DataTabela(chave: "SPF PLUS", valor: "\(spfList?.spfPlus ?? 0)", hasDetalhes: false))
            dataList.append(DataTabela(chave: "SPF NORMAL", valor: "\(spfList?.spfNormal ?? 0)", hasDetalhes: false))
            dataList.append(DataTabela(chave: "SPF BASICO", valor: "\(spfList?.spfBasico ?? 0)", hasDetalhes: false))
        }
        self.tableView.register(UINib(nibName: "PerformanceCustomTableViewCell", bundle: nil), forCellReuseIdentifier: "PerformanceCustomTableViewCell")
        self.adjustTableViewHeight()
        tableView.reloadData()
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataList.count
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
        
        if garantiaExtendidaList != nil {
            if dataList[indexPath.section].hasDetalhes {
                let vc = DetalheLinhaProdutoViewController()
                vc.grpComission = grpComission!
                vc.tipo = tipoList[indexPath.section - 1]
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PerformanceCustomTableViewCell", for: indexPath) as! PerformanceCustomTableViewCell
        
        if dataList.count == 0 {
            return cell
        } else {
            let volumePenetrationCdDn = dataList[indexPath.section]
            if indexPath.section == 0 {
                if garantiaExtendidaList != nil {
                    cell.iconSetaDetalhe.isHidden = true
                }
                cell.configurarCores(viewDireitaColor: UIColor(hex: 0x001E50), textoDireitoColor: .white)
            }else {
                cell.iconSetaDetalhe.isHidden = !volumePenetrationCdDn.hasDetalhes
                cell.configurarCores(viewDireitaColor: UIColor(hex: 0xF2F2F7), textoDireitoColor: .gray)
                
                if indexPath.section % 2 != 0 {
                    cell.viewDireita.backgroundColor = UIColor.systemGray5
                } else {
                    cell.viewDireita.backgroundColor = UIColor.systemGray6
                }
            }
            
            cell.textoEsquerdo.text = "\(volumePenetrationCdDn.chave)"
            cell.textoDireito.text = "\(volumePenetrationCdDn.valor)"
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if dataList.count == 0 {
            return 0
        }
        if isFrota {
            return 65
        }
        return 65
    }
    
    func adjustTableViewHeight() {
        
        self.tableView.layoutIfNeeded()
        let height = self.tableView.contentSize.height
        self.tableViewHeightConstraint.constant = height
        
        self.viewTableHeightConstraint.constant = height + 300 // - 250
        self.viewTabela.layoutIfNeeded()
        
        self.viewContentHeightConstraint.constant = height + 500
        
//        if garantiaExtendidaList != nil {
//            self.viewContentHeightConstraint.constant = height + 500
//        } else if ppsList != nil {
//            self.viewContentHeightConstraint.constant = height + 480
//        } else if ppsList != nil || spfList != nil {
//            self.viewContentHeightConstraint.constant = height + 480
//        } else if seguroCascoList != nil {
//            self.viewContentHeightConstraint.constant = height + 1000
//        }
        
        self.tableView.register(UINib(nibName: "PerformanceCustomTableViewCell", bundle: nil), forCellReuseIdentifier: "PerformanceCustomTableViewCell")
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

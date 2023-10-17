//
//  DetalheLinhaProdutoViewController.swift
//  App Commission
//
//  Created by Camilo Oscar Girardelli Baptista on 17/08/23.
//

import Foundation
import UIKit

struct DataLinha {
    let chave: Int
    let valor: Int
    let hasDetalhes: Bool
}

class DetalheLinhaProdutoViewController: UIViewController, UIScrollViewDelegate,UITableViewDelegate, UITableViewDataSource {
    
    let defaults = UserDefaults.standard
    var volumePenetrationProdutosAgregadosLista: VolumePenetrationProdutosAgregadosListaCdDnModel?
    var grpComission: String?
    var tipo: String?
    var dataList: [DataLinha] = []
    var dataListTemp: [DataLinha] = []
    var primeiraLinha: String?
    
    @IBOutlet weak var viewTableHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewContentHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewTabela: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var textoRodapeLabel: UILabel!
    @IBOutlet weak var tituloLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var frotaLabel: UILabel!
    
    public init() {
        super.init(nibName: "DetalheTabelaViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implementerd")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.tableView.layer.cornerRadius = 15
        self.tableView.backgroundColor = .clear
        createSecondNavBar(true)
        getData()
        configTexts()
        frotaLabel.isHidden = true
        viewTabela.dropShadowSimulador()
        viewTabela.cornerRadius(radius: 15)
        viewTabela.frame = CGRect(x: viewTabela.layer.position.x, y: viewTabela.layer.position.y, width: self.tableView.bounds.width, height: viewTabela.bounds.height)
        self.tableView.register(UINib(nibName: "PerformanceCustomTableViewCell", bundle: nil), forCellReuseIdentifier: "PerformanceCustomTableViewCell")
    }
    
    
    private func getData() {
        
        self.createSpinnerView()
        
        var tipo:String = "nm_grp_comission=" + grpComission!
        
        if grpComission != nil && grpComission!.isInt {
            tipo = "cd_dn=" + grpComission!
        }
        
        VolumePenetrationService.shared.getVolumeProdutosAgregadosListaCdDn(isFrota: false, type: tipo) { volumePerformance, error in
            self.removeSpinnerView()
            if let volumePerformance = volumePerformance {
                self.volumePenetrationProdutosAgregadosLista = volumePerformance
                self.populateDataList()
            } else {
                let alertController = UIAlertController(title: "Ops..", message: "Estamos passando por algum problema.. :(", preferredStyle: .alert)
                
                let confirmAction = UIAlertAction(title: "ok", style: .default) { (action) in
                    
                    //self.dismiss(animated: true, completion: nil)
                    
                }
                
                alertController.addAction(confirmAction)
                
                self.present(alertController, animated: true, completion: nil)
            }
        }
        
        tableView.reloadData()
    }
    
    func populateDataList() {
        
        if tipo == "listGarantiaEstEndIDACLP" {
            primeiraLinha = "GARANTIA ESTENDIDA CLP"
            dataListTemp = []
            for data in volumePenetrationProdutosAgregadosLista!.listGarantiaEstEndIDACLP! {
                
                dataListTemp.append(DataLinha(chave: data.cdDn!, valor: data.valor ?? 0, hasDetalhes: false))
            }
        }
        else if tipo == "listGarantiaEstClpFin" {
            primeiraLinha = "GAR ESTENDIDA FIN"
            dataListTemp = []
            for data in volumePenetrationProdutosAgregadosLista!.listGarantiaEstClpFin! {
                
                dataListTemp.append(DataLinha(chave: data.cdDn!, valor: data.valor ?? 0, hasDetalhes: false))
            }
        }
        else if tipo == "listGarantiaEstClpAvi" {
            primeiraLinha = "GAR ESTENDIDA CLP AVI"
            dataListTemp = []
            for data in volumePenetrationProdutosAgregadosLista!.listGarantiaEstClpAvi! {
                
                dataListTemp.append(DataLinha(chave: data.cdDn!, valor: data.valor ?? 0, hasDetalhes: false))
            }
        }
        else if tipo == "listGarantiaEstendidaVw" {
            primeiraLinha = "GARANTIA ESTENDIDA VW"
            dataListTemp = []
            for data in volumePenetrationProdutosAgregadosLista!.listGarantiaEstendidaVw! {
                
                dataListTemp.append(DataLinha(chave: data.cdDn!, valor: data.valor ?? 0, hasDetalhes: false))
            }
        }
        else if tipo == "listGarantiaEstendidaVwFin" {
            primeiraLinha = "GAR ESTENDIDA VW FIN"
            dataListTemp = []
            for data in volumePenetrationProdutosAgregadosLista!.listGarantiaEstendidaVwFin! {
                
                dataListTemp.append(DataLinha(chave: data.cdDn!, valor: data.valor ?? 0, hasDetalhes: false))
            }
        }
        else if tipo == "listGarantiaEstendidaVwAvi" {
            primeiraLinha = "GAR ESTENDIDA VW AVI"
            dataListTemp = []
            for data in volumePenetrationProdutosAgregadosLista!.listGarantiaEstendidaVwAvi! {
                
                dataListTemp.append(DataLinha(chave: data.cdDn!, valor: data.valor ?? 0, hasDetalhes: false))
            }
        }
        else if tipo == "listGEVwEssencial12" {
            primeiraLinha = "GE VW ESSENCIAL 12"
            dataListTemp = []
            for data in volumePenetrationProdutosAgregadosLista!.listGEVwEssencial12! {
                
                dataListTemp.append(DataLinha(chave: data.cdDn!, valor: data.valor ?? 0, hasDetalhes: false))
            }
        }
        else if tipo == "listGEVwEssencial24" {
            primeiraLinha = "GE VW ESSENCIAL 24"
            dataListTemp = []
            for data in volumePenetrationProdutosAgregadosLista!.listGEVwEssencial24! {
                
                dataListTemp.append(DataLinha(chave: data.cdDn!, valor: data.valor ?? 0, hasDetalhes: false))
            }
        }
        else if tipo == "listGEVWEssenModelo12" {
            primeiraLinha = "GE VW ESSEN MODELO 12"
            dataListTemp = []
            for data in volumePenetrationProdutosAgregadosLista!.listGEVWEssenModelo12! {
                
                dataListTemp.append(DataLinha(chave: data.cdDn!, valor: data.valor ?? 0, hasDetalhes: false))
            }
        }
        else if tipo == "listGEVWEssenModelo24" {
            primeiraLinha = "GE VW ESSEN MODELO 24"
            dataListTemp = []
            for data in volumePenetrationProdutosAgregadosLista!.listGEVWEssenModelo24! {
                
                dataListTemp.append(DataLinha(chave: data.cdDn!, valor: data.valor ?? 0, hasDetalhes: false))
            }
        }
        else if tipo == "listGEVWEssenModelo36" {
            primeiraLinha = "GE VW ESSEN MODELO 36"
            dataListTemp = []
            for data in volumePenetrationProdutosAgregadosLista!.listGEVWEssenModelo36! {
                
                dataListTemp.append(DataLinha(chave: data.cdDn!, valor: data.valor ?? 0, hasDetalhes: false))
            }
        }
        else if tipo == "listGEVWEssenModelo48" {
            primeiraLinha = "GE VW ESSEN MODELO 48"
            dataListTemp = []
            for data in volumePenetrationProdutosAgregadosLista!.listGEVWEssenModelo48! {
                
                dataListTemp.append(DataLinha(chave: data.cdDn!, valor: data.valor ?? 0, hasDetalhes: false))
            }
        }
        else if tipo == "listGEVWTotalModelo12" {
            primeiraLinha = "GE VW TOTAL MODELO 12"
            dataListTemp = []
            for data in volumePenetrationProdutosAgregadosLista!.listGEVWTotalModelo12! {
                
                dataListTemp.append(DataLinha(chave: data.cdDn!, valor: data.valor ?? 0, hasDetalhes: false))
            }
        }
        
        dataList = dataListTemp.sorted(by: { $0.chave < $1.chave })
        //adjustTableViewHeight()
        self.tableView.reloadData()
    }
    
    private func configTexts() {
        
        self.tituloLabel.text = "Detalhe Linha"
        
        let dataCarga = defaults.string(forKey: SystemKeys.DATA_CARGA)
        
        if dataCarga != nil {
            
            if let dataCarga = dataCarga {
                
                self.textoRodapeLabel.text = "O índice projetado tem como base a performance atualizada até " + Utils.formatDataHora(dataCarga) + " e poderá sofrer alterações. Os valores apresentados não garantem qualquer tipo de remuneração."
                
            }
            
        }
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataList.count + 1
        
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
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PerformanceCustomTableViewCell", for: indexPath) as! PerformanceCustomTableViewCell
        
        if dataList.count == 0 {
            return cell
        } else {
            if indexPath.section == 0 {
                cell.configurarCores(viewDireitaColor: UIColor(hex: 0x001E50), textoDireitoColor: .white)
                cell.textoEsquerdo.text = ""
                cell.textoDireito.text = "\(primeiraLinha!)"
            }else {
                let volumePenetrationCdDn = dataList[indexPath.section - 1]
                cell.iconSetaDetalhe.isHidden = !volumePenetrationCdDn.hasDetalhes
                cell.configurarCores(viewDireitaColor: UIColor(hex: 0xF2F2F7), textoDireitoColor: .gray)
                
                if indexPath.section % 2 != 0 {
                    cell.viewDireita.backgroundColor = UIColor.systemGray5
                } else {
                    cell.viewDireita.backgroundColor = UIColor.systemGray6
                }
                
                cell.textoEsquerdo.text = "\(volumePenetrationCdDn.chave)"
                cell.textoDireito.text = "\(volumePenetrationCdDn.valor)"
            }
            
            
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if dataList.count == 0 {
            return 0
        }
        return 70
    }
    
    func adjustTableViewHeight() {
        
//        self.tableView.layoutIfNeeded()
//        let height = self.tableView.contentSize.height
//        self.tableViewHeightConstraint.constant = height
        
//        self.viewTableHeightConstraint.constant = self.tableView.frame.height + 20 // - 250
        self.viewTabela.layoutIfNeeded()
        self.viewContentHeightConstraint.constant = self.tableView.frame.height + 200
        
//        self.tableView.layoutIfNeeded()
//        let height = self.tableView.contentSize.height
//        self.tableViewHeightConstraint.constant = height
//
//        self.viewTableHeightConstraint.constant = height - 250
//        self.viewTabela.layoutIfNeeded()
//
//        self.viewContentHeightConstraint.constant = height + 700
        
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


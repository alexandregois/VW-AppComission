//
//  PerformedViewController.swift
//  App Commission
//
//  Created by Camilo Oscar Girardelli Baptista on 11/07/23.
//

import Foundation
import UIKit

class PerformedViewController: UIViewController {
    
    @IBOutlet weak var screenTitle: UILabel!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var footerInfo: UILabel!
    @IBOutlet weak var fullTableLabel: UILabel!
    @IBOutlet weak var indiceFrotaLabel: UILabel!
    
    //selector
    @IBOutlet weak var selectableView: UIView!
    @IBOutlet weak var varejoView: UIView!
    @IBOutlet weak var aceleraView: UIView!
    @IBOutlet weak var varejoLabel: UILabel!
    @IBOutlet weak var aceleraLabel: UILabel!
    
    //table
    @IBOutlet weak var topLeftTableView: UIView!
    @IBOutlet weak var topRightTableView: UIView!
    @IBOutlet weak var bottonLeftTableView: UIView!
    @IBOutlet weak var bottonRightTableView: UIView!
    //firstLine
    @IBOutlet weak var labelCell00: UILabel!
    @IBOutlet weak var labelCell01: UILabel!
    @IBOutlet weak var labelCell02: UILabel!
    @IBOutlet weak var labelCell03: UILabel!
    
    //secondLine
    @IBOutlet weak var labelCell10: UILabel!
    
    @IBOutlet weak var labelCell11: UILabel!
    @IBOutlet weak var backCell11: UIView!
    
    @IBOutlet weak var labelCell12: UILabel!
    @IBOutlet weak var backCell12: UIView!
    
    @IBOutlet weak var labelCell13: UILabel!
    @IBOutlet weak var backCell13: UIView!
    
    //thirdLine
    @IBOutlet weak var labelCell20: UILabel!
    
    @IBOutlet weak var labelCell21: UILabel!
    @IBOutlet weak var backCell21: UIView!
    
    @IBOutlet weak var labelCell22: UILabel!
    @IBOutlet weak var backCell22: UIView!
    
    @IBOutlet weak var labelCell23: UILabel!
    @IBOutlet weak var backCell23: UIView!
    
    //forthLine
    @IBOutlet weak var labelCell30: UILabel!
    
    @IBOutlet weak var labelCell31: UILabel!
    @IBOutlet weak var backCell31: UIView!
    
    @IBOutlet weak var labelCell32: UILabel!
    @IBOutlet weak var backCell32: UIView!
    
    @IBOutlet weak var labelCell33: UILabel!
    @IBOutlet weak var backCell33: UIView!
    
    let defaults = UserDefaults.standard
    
    var performedIndex: PerformedIndex?
    
    public init() {
        super.init(nibName: "PerformedViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implementerd")
    }
    
    override func viewDidLoad() {
        self.screenTitle.text = "Performada"
        super.viewDidLoad()
        createSecondNavBar(true)
        configCards()
        selectVarejo()
    }
    
    private func configCards() {
        backView.isHidden = true
        backView.cornerRadius(radius: 15)
        backView.dropShadow()
        configSelectable()
        configTable()
        configFooter()
        let attributedString = NSMutableAttributedString.init(string: "Visualizar Índice Frota")
        
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range:
                                        NSRange.init(location: 0, length: attributedString.length));
        indiceFrotaLabel.attributedText = attributedString
        
        let fullTableAttributedString = NSMutableAttributedString.init(string: "Visualizar tabela completa")
        
        fullTableAttributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range:
                                        NSRange.init(location: 0, length: fullTableAttributedString.length));
        fullTableLabel.attributedText = fullTableAttributedString
    }
    
    private func configFooter() {
        let dataCarga = defaults.string(forKey: SystemKeys.DATA_CARGA)
        
        footerInfo.text = "O índice projetado tem como base a performance atualizada até \(dataCarga!) e poderá sofrer alterações. Os valores apresentados não garantem qualquer tipo de remuneração."
        fullTableLabel.isUserInteractionEnabled = true
        fullTableLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.goToFullTable)))
        
        indiceFrotaLabel.isUserInteractionEnabled = true
        indiceFrotaLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.goToFrota)))
    }
    
    private func configSelectable() {
        selectableView.cornerRadius(radius: 10)
        varejoView.cornerRadius(radius: 10)
        aceleraView.cornerRadius(radius: 10)
        aceleraView.backgroundColor = .white
        aceleraLabel.textColor = .gray
        aceleraLabel.isUserInteractionEnabled = true
        aceleraLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.selectAcelera)))
        
        varejoView.backgroundColor = .systemBlue
        varejoLabel.textColor = .white
        varejoLabel.isUserInteractionEnabled = true
        varejoLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.selectVarejo)))
    }
    
    private func configTable() {
        topLeftTableView.roundCorners(corners: [.topLeft], radius: 15)
        topRightTableView.roundCorners(corners: [.topRight], radius: 15)
        bottonLeftTableView.roundCorners(corners: [.bottomLeft], radius: 15)
        bottonRightTableView.roundCorners(corners: [.bottomRight], radius: 15)
        backCell11.backgroundColor = .white
        labelCell11.textColor = .gray
        
        backCell12.backgroundColor = .white
        labelCell12.textColor = .gray
        
        backCell13.backgroundColor = .white
        labelCell13.textColor = .gray
        
        backCell21.backgroundColor = .systemGray5
        labelCell21.textColor = .gray
        
        backCell22.backgroundColor = .systemGray5
        labelCell22.textColor = .gray
        
        backCell23.backgroundColor = .systemGray5
        labelCell23.textColor = .gray
        
        backCell31.backgroundColor = .white
        labelCell31.textColor = .gray
        
        backCell32.backgroundColor = .white
        labelCell32.textColor = .gray
        
        backCell33.backgroundColor = .white
        labelCell33.textColor = .gray
    }
    
    private func populateSummaryTable(tabelaReduzida: TableData) {
        //vertical
        labelCell10.text = tabelaReduzida.negociadoVertical[0]
        labelCell20.text = tabelaReduzida.negociadoVertical[1]
        labelCell30.text = tabelaReduzida.negociadoVertical[2]
        
        //horizontal
        labelCell01.text = tabelaReduzida.referenciaHorizontal[0]
        labelCell02.text = tabelaReduzida.referenciaHorizontal[1]
        labelCell03.text = tabelaReduzida.referenciaHorizontal[2]
        
        //dados
        let dados1 = tabelaReduzida.valores[0]
        
        if dados1[0].components(separatedBy: " - ").count > 1 {
            labelCell11.text = dados1[0].components(separatedBy: " - ")[0]
            labelCell11.textColor = .white
            backCell11.backgroundColor = UIColor(named: "vwBlue")
            backCell11.cornerRadius(radius: 10)
        } else {
            labelCell11.text = dados1[0]
        }
        
        if dados1[1].components(separatedBy: " - ").count > 1 {
            labelCell21.text = dados1[1].components(separatedBy: " - ")[0]
            labelCell21.textColor = .white
            backCell21.backgroundColor = UIColor(named: "vwBlue")
            backCell21.cornerRadius(radius: 10)
        } else {
            labelCell21.text = dados1[1]
        }
        
        if dados1[2].components(separatedBy: " - ").count > 1 {
            labelCell31.text = dados1[2].components(separatedBy: " - ")[0]
            labelCell31.textColor = .white
            backCell31.backgroundColor = UIColor(named: "vwBlue")
            backCell31.cornerRadius(radius: 10)
        } else {
            labelCell31.text = dados1[2]
        }
        
        let dados2 = tabelaReduzida.valores[1]
        
        if dados2[0].components(separatedBy: " - ").count > 1 {
            labelCell12.text = dados2[0].components(separatedBy: " - ")[0]
            labelCell12.textColor = .white
            backCell12.backgroundColor = UIColor(named: "vwBlue")
            backCell12.cornerRadius(radius: 10)
        } else {
            labelCell12.text = dados2[0]
        }
        
        if dados2[1].components(separatedBy: " - ").count > 1 {
            labelCell22.text = dados2[1].components(separatedBy: " - ")[0]
            labelCell22.textColor = .white
            backCell22.backgroundColor = UIColor(named: "vwBlue")
            backCell22.cornerRadius(radius: 10)
        } else {
            labelCell22.text = dados2[1]
        }
        
        if dados2[2].components(separatedBy: " - ").count > 1 {
            labelCell32.text = dados2[2].components(separatedBy: " - ")[0]
            labelCell32.textColor = .white
            backCell32.backgroundColor = UIColor(named: "vwBlue")
            backCell32.cornerRadius(radius: 10)
        } else {
            labelCell32.text = dados2[2]
        }
        
        let dados3 = tabelaReduzida.valores[2]
        
        if dados3[0].components(separatedBy: " - ").count > 1 {
            labelCell13.text = dados3[0].components(separatedBy: " - ")[0]
            labelCell13.textColor = .white
            backCell13.backgroundColor = UIColor(named: "vwBlue")
            backCell13.cornerRadius(radius: 10)
        } else {
            labelCell13.text = dados3[0]
        }
        
        if dados3[1].components(separatedBy: " - ").count > 1 {
            labelCell23.text = dados3[1].components(separatedBy: " - ")[0]
            labelCell23.textColor = .white
            backCell23.backgroundColor = UIColor(named: "vwBlue")
            backCell23.cornerRadius(radius: 10)
        } else {
            labelCell23.text = dados3[1]
        }
        
        if dados3[2].components(separatedBy: " - ").count > 1 {
            labelCell33.text = dados3[2].components(separatedBy: " - ")[0]
            labelCell33.textColor = .white
            backCell33.backgroundColor = UIColor(named: "vwBlue")
            backCell33.cornerRadius(radius: 10)
        } else {
            labelCell33.text = dados3[2]
        }
        
        backView.isHidden = false
    }
    
    @objc func goToFrota() {
        let frotaVC = PerformedFrotaViewController()
        self.navigationController?.pushViewController(frotaVC, animated: true)
    }
    
    
    @objc func selectAcelera() {
        varejoView.backgroundColor = .white
        varejoLabel.textColor = .gray
        aceleraView.backgroundColor = .systemBlue
        aceleraLabel.textColor = .white
        fullTableLabel.isHidden = true
        indiceFrotaLabel.isHidden = true
        self.configTable()
        
        self.createSpinnerView()
        PerformedService.shared.getAcelera { performedIndex, error in
            if performedIndex != nil {
                self.performedIndex = performedIndex
                self.removeSpinnerView()
                self.populateSummaryTable(tabelaReduzida: performedIndex!.tabelaResumida)
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
    
    @objc func selectVarejo() {
        varejoView.backgroundColor = .systemBlue
        varejoLabel.textColor = .white
        aceleraView.backgroundColor = .white
        aceleraLabel.textColor = .gray
        fullTableLabel.isHidden = false
        indiceFrotaLabel.isHidden = false
        self.configTable()
        
        self.createSpinnerView()
        PerformedService.shared.getVarejo { performedIndex, error in
            if performedIndex != nil {
                self.performedIndex = performedIndex
                self.removeSpinnerView()
                self.populateSummaryTable(tabelaReduzida: performedIndex!.tabelaResumida)
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
    
    @objc func goToFullTable() {
        let vc = PerformedFullTableViewController()
        vc.performedIndex = self.performedIndex
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

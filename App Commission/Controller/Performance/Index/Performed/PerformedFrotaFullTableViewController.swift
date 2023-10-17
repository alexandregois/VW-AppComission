//
//  PerformedFrotaFullTableViewController.swift
//  App Commission
//
//  Created by Camilo Oscar Girardelli Baptista on 04/08/23.
//

import Foundation
import UIKit

class PerformedFrotaFullTableViewController: UIViewController {
    
    @IBOutlet weak var screenTitle: UILabel!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var footerInfo: UILabel!
    
    //table
    @IBOutlet weak var topLeftTableView: UIView!
    @IBOutlet weak var topRightTableView: UIView!
    @IBOutlet weak var bottonLeftTableView: UIView!
    @IBOutlet weak var bottonRightTableView: UIView!
   
    //line 1
    @IBOutlet weak var labelCell00: UILabel!
    @IBOutlet weak var labelCell01: UILabel!
    @IBOutlet weak var labelCell02: UILabel!
    @IBOutlet weak var labelCell03: UILabel!
    
    //line 2
    @IBOutlet weak var labelCell10: UILabel!
    
    @IBOutlet weak var labelCell11: UILabel!
    @IBOutlet weak var backCell11: UIView!
    
    @IBOutlet weak var labelCell12: UILabel!
    @IBOutlet weak var backCell12: UIView!
    
    @IBOutlet weak var labelCell13: UILabel!
    @IBOutlet weak var backCell13: UIView!
    
    
    //line 3
    @IBOutlet weak var labelCell20: UILabel!
    
    @IBOutlet weak var labelCell21: UILabel!
    @IBOutlet weak var backCell21: UIView!
    
    @IBOutlet weak var labelCell22: UILabel!
    @IBOutlet weak var backCell22: UIView!
    
    @IBOutlet weak var labelCell23: UILabel!
    @IBOutlet weak var backCell23: UIView!
    
    //line 4
    @IBOutlet weak var labelCell30: UILabel!
    
    @IBOutlet weak var labelCell31: UILabel!
    @IBOutlet weak var backCell31: UIView!
    
    @IBOutlet weak var labelCell32: UILabel!
    @IBOutlet weak var backCell32: UIView!
    
    @IBOutlet weak var labelCell33: UILabel!
    @IBOutlet weak var backCell33: UIView!
    
    //line 5
    @IBOutlet weak var labelCell40: UILabel!
    
    @IBOutlet weak var labelCell41: UILabel!
    @IBOutlet weak var backCell41: UIView!
    
    @IBOutlet weak var labelCell42: UILabel!
    @IBOutlet weak var backCell42: UIView!
    
    @IBOutlet weak var labelCell43: UILabel!
    @IBOutlet weak var backCell43: UIView!
    
    //line 6
    @IBOutlet weak var labelCell50: UILabel!
    
    @IBOutlet weak var labelCell51: UILabel!
    @IBOutlet weak var backCell51: UIView!
    
    @IBOutlet weak var labelCell52: UILabel!
    @IBOutlet weak var backCell52: UIView!
    
    @IBOutlet weak var labelCell53: UILabel!
    @IBOutlet weak var backCell53: UIView!
    
    //line 7
    @IBOutlet weak var labelCell60: UILabel!
    
    @IBOutlet weak var labelCell61: UILabel!
    @IBOutlet weak var backCell61: UIView!
    
    @IBOutlet weak var labelCell62: UILabel!
    @IBOutlet weak var backCell62: UIView!
    
    @IBOutlet weak var labelCell63: UILabel!
    @IBOutlet weak var backCell63: UIView!
    
    //line 8
    @IBOutlet weak var labelCell70: UILabel!
    
    @IBOutlet weak var labelCell71: UILabel!
    @IBOutlet weak var backCell71: UIView!
    
    @IBOutlet weak var labelCell72: UILabel!
    @IBOutlet weak var backCell72: UIView!
    
    @IBOutlet weak var labelCell73: UILabel!
    @IBOutlet weak var backCell73: UIView!
    
    //line 9
    @IBOutlet weak var labelCell80: UILabel!
    
    @IBOutlet weak var labelCell81: UILabel!
    @IBOutlet weak var backCell81: UIView!
    
    @IBOutlet weak var labelCell82: UILabel!
    @IBOutlet weak var backCell82: UIView!
    
    @IBOutlet weak var labelCell83: UILabel!
    @IBOutlet weak var backCell83: UIView!
    
    //line 10
    @IBOutlet weak var labelCell90: UILabel!
    
    @IBOutlet weak var labelCell91: UILabel!
    @IBOutlet weak var backCell91: UIView!
    
    @IBOutlet weak var labelCell92: UILabel!
    @IBOutlet weak var backCell92: UIView!
    
    @IBOutlet weak var labelCell93: UILabel!
    @IBOutlet weak var backCell93: UIView!
    
    //line 11
    @IBOutlet weak var labelCell100: UILabel!
    
    @IBOutlet weak var labelCell101: UILabel!
    @IBOutlet weak var backCell101: UIView!
    
    @IBOutlet weak var labelCell102: UILabel!
    @IBOutlet weak var backCell102: UIView!
    
    @IBOutlet weak var labelCell103: UILabel!
    @IBOutlet weak var backCell103: UIView!
    
    //line 12
    @IBOutlet weak var labelCell110: UILabel!
    
    @IBOutlet weak var labelCell111: UILabel!
    @IBOutlet weak var backCell111: UIView!
    
    @IBOutlet weak var labelCell112: UILabel!
    @IBOutlet weak var backCell112: UIView!
    
    @IBOutlet weak var labelCell113: UILabel!
    @IBOutlet weak var backCell113: UIView!
    
    //line 13
    @IBOutlet weak var labelCell120: UILabel!
    
    @IBOutlet weak var labelCell121: UILabel!
    @IBOutlet weak var backCell121: UIView!
    
    @IBOutlet weak var labelCell122: UILabel!
    @IBOutlet weak var backCell122: UIView!
    
    @IBOutlet weak var labelCell123: UILabel!
    @IBOutlet weak var backCell123: UIView!
    
    //line 14
    @IBOutlet weak var labelCell130: UILabel!
    
    @IBOutlet weak var labelCell131: UILabel!
    @IBOutlet weak var backCell131: UIView!
    
    @IBOutlet weak var labelCell132: UILabel!
    @IBOutlet weak var backCell132: UIView!
    
    @IBOutlet weak var labelCell133: UILabel!
    @IBOutlet weak var backCell133: UIView!
    
    //line 15
    @IBOutlet weak var labelCell140: UILabel!
    
    @IBOutlet weak var labelCell141: UILabel!
    @IBOutlet weak var backCell141: UIView!
    
    @IBOutlet weak var labelCell142: UILabel!
    @IBOutlet weak var backCell142: UIView!
    
    @IBOutlet weak var labelCell143: UILabel!
    @IBOutlet weak var backCell143: UIView!
    
    //line 16
    @IBOutlet weak var labelCell150: UILabel!
    
    @IBOutlet weak var labelCell151: UILabel!
    @IBOutlet weak var backCell151: UIView!
    
    @IBOutlet weak var labelCell152: UILabel!
    @IBOutlet weak var backCell152: UIView!
    
    @IBOutlet weak var labelCell153: UILabel!
    @IBOutlet weak var backCell153: UIView!
    
    //line 17
    @IBOutlet weak var labelCell160: UILabel!
    
    @IBOutlet weak var labelCell161: UILabel!
    @IBOutlet weak var backCell161: UIView!
    
    @IBOutlet weak var labelCell162: UILabel!
    @IBOutlet weak var backCell162: UIView!
    
    @IBOutlet weak var labelCell163: UILabel!
    @IBOutlet weak var backCell163: UIView!
    
    let defaults = UserDefaults.standard
    
    var performedIndex: PerformedIndex?
    
    public init() {
        super.init(nibName: "PerformedFrotaFullTableViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implementerd")
    }
    
    override func viewDidLoad() {
        //self.screenTitle.text = "Performada"
        super.viewDidLoad()
        createSecondNavBar(true)
        configCards()
        populateSummaryTable(tabela: performedIndex!.tabelaCompleta)
    }
    
    private func configCards() {
        backView.cornerRadius(radius: 15)
        backView.dropShadow()
        configTable()
        configFooter()
    }
    
    private func configFooter() {
        let dataCarga = defaults.string(forKey: SystemKeys.DATA_CARGA)
        
        footerInfo.text = "O índice projetado tem como base a performance atualizada até \(dataCarga!) e poderá sofrer alterações. Os valores apresentados não garantem qualquer tipo de remuneração."
    }
    
    private func configTable() {
        topLeftTableView.roundCorners(corners: [.topLeft], radius: 15)
        topRightTableView.roundCorners(corners: [.topRight], radius: 15)
        bottonLeftTableView.roundCorners(corners: [.bottomLeft], radius: 15)
        bottonRightTableView.roundCorners(corners: [.bottomRight], radius: 15)
        
        backCell11.backgroundColor = .white
        labelCell11.textColor = .gray
        
        backCell12.backgroundColor = .systemGray5
        labelCell12.textColor = .gray
        
        backCell13.backgroundColor = .white
        labelCell13.textColor = .gray
        
        backCell21.backgroundColor = .white
        labelCell21.textColor = .gray
        
        backCell22.backgroundColor = .systemGray5
        labelCell22.textColor = .gray
        
        backCell23.backgroundColor = .white
        labelCell23.textColor = .gray
        
        backCell31.backgroundColor = .white
        labelCell31.textColor = .gray
        
        backCell32.backgroundColor = .systemGray5
        labelCell32.textColor = .gray
        
        backCell33.backgroundColor = .white
        labelCell33.textColor = .gray
        
        backCell41.backgroundColor = .white
        labelCell41.textColor = .gray
        
        backCell42.backgroundColor = .systemGray5
        labelCell42.textColor = .gray
        
        backCell43.backgroundColor = .white
        labelCell43.textColor = .gray
        
        backCell51.backgroundColor = .white
        labelCell51.textColor = .gray
        
        backCell52.backgroundColor = .systemGray5
        labelCell52.textColor = .gray
        
        backCell53.backgroundColor = .white
        labelCell53.textColor = .gray
        
        backCell61.backgroundColor = .white
        labelCell61.textColor = .gray
        
        backCell62.backgroundColor = .systemGray5
        labelCell62.textColor = .gray
        
        backCell63.backgroundColor = .white
        labelCell63.textColor = .gray
        
        backCell71.backgroundColor = .white
        labelCell71.textColor = .gray
        
        backCell72.backgroundColor = .systemGray5
        labelCell72.textColor = .gray
        
        backCell73.backgroundColor = .white
        labelCell73.textColor = .gray
        
        backCell81.backgroundColor = .white
        labelCell81.textColor = .gray
        
        backCell82.backgroundColor = .systemGray5
        labelCell82.textColor = .gray
        
        backCell83.backgroundColor = .white
        labelCell83.textColor = .gray
        
        backCell91.backgroundColor = .white
        labelCell91.textColor = .gray
        
        backCell92.backgroundColor = .systemGray5
        labelCell92.textColor = .gray
        
        backCell93.backgroundColor = .white
        labelCell93.textColor = .gray
        
        backCell101.backgroundColor = .white
        labelCell101.textColor = .gray
        
        backCell102.backgroundColor = .systemGray5
        labelCell102.textColor = .gray
        
        backCell103.backgroundColor = .white
        labelCell103.textColor = .gray
        
        backCell111.backgroundColor = .white
        labelCell111.textColor = .gray
        
        backCell112.backgroundColor = .systemGray5
        labelCell112.textColor = .gray
        
        backCell113.backgroundColor = .white
        labelCell113.textColor = .gray
        
        backCell121.backgroundColor = .white
        labelCell121.textColor = .gray
        
        backCell122.backgroundColor = .systemGray5
        labelCell122.textColor = .gray
        
        backCell123.backgroundColor = .white
        labelCell123.textColor = .gray
        
        backCell131.backgroundColor = .white
        labelCell131.textColor = .gray
        
        backCell132.backgroundColor = .systemGray5
        labelCell132.textColor = .gray
        
        backCell133.backgroundColor = .white
        labelCell133.textColor = .gray
        
        backCell141.backgroundColor = .white
        labelCell141.textColor = .gray
        
        backCell142.backgroundColor = .systemGray5
        labelCell142.textColor = .gray
        
        backCell143.backgroundColor = .white
        labelCell143.textColor = .gray
        
        backCell151.backgroundColor = .white
        labelCell151.textColor = .gray
        
        backCell152.backgroundColor = .systemGray5
        labelCell152.textColor = .gray
        
        backCell153.backgroundColor = .white
        labelCell153.textColor = .gray
        
        backCell161.backgroundColor = .white
        labelCell161.textColor = .gray
        
        backCell162.backgroundColor = .systemGray5
        labelCell162.textColor = .gray
        
        backCell163.backgroundColor = .white
        labelCell163.textColor = .gray
        
    }
    
    private func populateSummaryTable(tabela: TableData) {
        
        //horizontal
        labelCell10.text = tabela.referenciaHorizontal[0]
        labelCell20.text = tabela.referenciaHorizontal[1]
        labelCell30.text = tabela.referenciaHorizontal[2]
        labelCell40.text = tabela.referenciaHorizontal[3]
        labelCell50.text = tabela.referenciaHorizontal[4]
        labelCell60.text = tabela.referenciaHorizontal[5]
        labelCell70.text = tabela.referenciaHorizontal[6]
        labelCell80.text = tabela.referenciaHorizontal[7]
        labelCell90.text = tabela.referenciaHorizontal[8]
        labelCell100.text = tabela.referenciaHorizontal[9]
        labelCell110.text = tabela.referenciaHorizontal[10]
        labelCell120.text = tabela.referenciaHorizontal[11]
        labelCell130.text = tabela.referenciaHorizontal[12]
        labelCell140.text = tabela.referenciaHorizontal[13]
        labelCell150.text = tabela.referenciaHorizontal[14]
        labelCell160.text = tabela.referenciaHorizontal[15]
        
        
        //vertical
        labelCell01.text = tabela.negociadoVertical[0]
        labelCell02.text = tabela.negociadoVertical[1]
        labelCell03.text = tabela.negociadoVertical[2]
        
        //dados
        let dados1 = tabela.valores[0]
        
        if dados1[0].components(separatedBy: " - ").count > 1 {
            labelCell11.text = dados1[0].components(separatedBy: " - ")[0]
            labelCell11.textColor = .white
            backCell11.backgroundColor = UIColor(named: "vwBlue")
            backCell11.cornerRadius(radius: 10)
        } else {
            labelCell11.text = dados1[0]
        }
        
        if dados1[1].components(separatedBy: " - ").count > 1 {
            labelCell12.text = dados1[1].components(separatedBy: " - ")[0]
            labelCell12.textColor = .white
            backCell12.backgroundColor = UIColor(named: "vwBlue")
            backCell12.cornerRadius(radius: 10)
        } else {
            labelCell12.text = dados1[1]
        }
        
        if dados1[2].components(separatedBy: " - ").count > 1 {
            labelCell13.text = dados1[2].components(separatedBy: " - ")[0]
            labelCell13.textColor = .white
            backCell13.backgroundColor = UIColor(named: "vwBlue")
            backCell13.cornerRadius(radius: 10)
        } else {
            labelCell13.text = dados1[2]
        }
        
        
        let dados2 = tabela.valores[1]
        
        if dados2[0].components(separatedBy: " - ").count > 1 {
            labelCell21.text = dados2[0].components(separatedBy: " - ")[0]
            labelCell21.textColor = .white
            backCell21.backgroundColor = UIColor(named: "vwBlue")
            backCell21.cornerRadius(radius: 10)
        } else {
            labelCell21.text = dados2[0]
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
            labelCell23.text = dados2[2].components(separatedBy: " - ")[0]
            labelCell23.textColor = .white
            backCell23.backgroundColor = UIColor(named: "vwBlue")
            backCell23.cornerRadius(radius: 10)
        } else {
            labelCell23.text = dados2[2]
        }
        
        let dados3 = tabela.valores[2]
        
        if dados3[0].components(separatedBy: " - ").count > 1 {
            labelCell31.text = dados3[0].components(separatedBy: " - ")[0]
            labelCell31.textColor = .white
            backCell31.backgroundColor = UIColor(named: "vwBlue")
            backCell31.cornerRadius(radius: 10)
        } else {
            labelCell31.text = dados3[0]
        }
        
        if dados3[1].components(separatedBy: " - ").count > 1 {
            labelCell32.text = dados3[1].components(separatedBy: " - ")[0]
            labelCell32.textColor = .white
            backCell32.backgroundColor = UIColor(named: "vwBlue")
            backCell32.cornerRadius(radius: 10)
        } else {
            labelCell32.text = dados3[1]
        }
        
        if dados3[2].components(separatedBy: " - ").count > 1 {
            labelCell33.text = dados3[2].components(separatedBy: " - ")[0]
            labelCell33.textColor = .white
            backCell33.backgroundColor = UIColor(named: "vwBlue")
            backCell33.cornerRadius(radius: 10)
        } else {
            labelCell33.text = dados3[2]
        }
        
        let dados4 = tabela.valores[3]
        
        if dados4[0].components(separatedBy: " - ").count > 1 {
            labelCell41.text = dados4[0].components(separatedBy: " - ")[0]
            labelCell41.textColor = .white
            backCell41.backgroundColor = UIColor(named: "vwBlue")
            backCell41.cornerRadius(radius: 10)
        } else {
            labelCell41.text = dados4[0]
        }
        
        if dados4[1].components(separatedBy: " - ").count > 1 {
            labelCell42.text = dados4[1].components(separatedBy: " - ")[0]
            labelCell42.textColor = .white
            backCell42.backgroundColor = UIColor(named: "vwBlue")
            backCell42.cornerRadius(radius: 10)
        } else {
            labelCell42.text = dados4[1]
        }
        
        if dados4[2].components(separatedBy: " - ").count > 1 {
            labelCell43.text = dados4[2].components(separatedBy: " - ")[0]
            labelCell43.textColor = .white
            backCell43.backgroundColor = UIColor(named: "vwBlue")
            backCell43.cornerRadius(radius: 10)
        } else {
            labelCell43.text = dados4[2]
        }
        
        let dados5 = tabela.valores[4]
        
        if dados5[0].components(separatedBy: " - ").count > 1 {
            labelCell51.text = dados5[0].components(separatedBy: " - ")[0]
            labelCell51.textColor = .white
            backCell51.backgroundColor = UIColor(named: "vwBlue")
            backCell51.cornerRadius(radius: 10)
        } else {
            labelCell51.text = dados5[0]
        }
        
        if dados5[1].components(separatedBy: " - ").count > 1 {
            labelCell52.text = dados5[1].components(separatedBy: " - ")[0]
            labelCell52.textColor = .white
            backCell52.backgroundColor = UIColor(named: "vwBlue")
            backCell52.cornerRadius(radius: 10)
        } else {
            labelCell52.text = dados5[1]
        }
        
        if dados5[2].components(separatedBy: " - ").count > 1 {
            labelCell53.text = dados5[2].components(separatedBy: " - ")[0]
            labelCell53.textColor = .white
            backCell53.backgroundColor = UIColor(named: "vwBlue")
            backCell53.cornerRadius(radius: 10)
        } else {
            labelCell53.text = dados5[2]
        }
        
        let dados6 = tabela.valores[5]
        
        if dados6[0].components(separatedBy: " - ").count > 1 {
            labelCell61.text = dados6[0].components(separatedBy: " - ")[0]
            labelCell61.textColor = .white
            backCell61.backgroundColor = UIColor(named: "vwBlue")
            backCell61.cornerRadius(radius: 10)
        } else {
            labelCell61.text = dados6[0]
        }
        
        if dados6[1].components(separatedBy: " - ").count > 1 {
            labelCell62.text = dados6[1].components(separatedBy: " - ")[0]
            labelCell62.textColor = .white
            backCell62.backgroundColor = UIColor(named: "vwBlue")
            backCell62.cornerRadius(radius: 10)
        } else {
            labelCell62.text = dados6[1]
        }
        
        if dados6[2].components(separatedBy: " - ").count > 1 {
            labelCell63.text = dados6[2].components(separatedBy: " - ")[0]
            labelCell63.textColor = .white
            backCell63.backgroundColor = UIColor(named: "vwBlue")
            backCell63.cornerRadius(radius: 10)
        } else {
            labelCell63.text = dados6[2]
        }
        
        let dados7 = tabela.valores[6]
        
        if dados7[0].components(separatedBy: " - ").count > 1 {
            labelCell71.text = dados7[0].components(separatedBy: " - ")[0]
            labelCell71.textColor = .white
            backCell71.backgroundColor = UIColor(named: "vwBlue")
            backCell71.cornerRadius(radius: 10)
        } else {
            labelCell71.text = dados7[0]
        }
        
        if dados7[1].components(separatedBy: " - ").count > 1 {
            labelCell72.text = dados7[1].components(separatedBy: " - ")[0]
            labelCell72.textColor = .white
            backCell72.backgroundColor = UIColor(named: "vwBlue")
            backCell72.cornerRadius(radius: 10)
        } else {
            labelCell72.text = dados7[1]
        }
        
        if dados7[2].components(separatedBy: " - ").count > 1 {
            labelCell73.text = dados7[2].components(separatedBy: " - ")[0]
            labelCell73.textColor = .white
            backCell73.backgroundColor = UIColor(named: "vwBlue")
            backCell73.cornerRadius(radius: 10)
        } else {
            labelCell73.text = dados7[2]
        }
        
        let dados8 = tabela.valores[7]
        
        if dados8[0].components(separatedBy: " - ").count > 1 {
            labelCell81.text = dados8[0].components(separatedBy: " - ")[0]
            labelCell81.textColor = .white
            backCell81.backgroundColor = UIColor(named: "vwBlue")
            backCell71.cornerRadius(radius: 10)
        } else {
            labelCell71.text = dados8[0]
        }
        
        if dados8[1].components(separatedBy: " - ").count > 1 {
            labelCell82.text = dados8[1].components(separatedBy: " - ")[0]
            labelCell82.textColor = .white
            backCell82.backgroundColor = UIColor(named: "vwBlue")
            backCell82.cornerRadius(radius: 10)
        } else {
            labelCell82.text = dados8[1]
        }
        
        if dados8[2].components(separatedBy: " - ").count > 1 {
            labelCell83.text = dados8[2].components(separatedBy: " - ")[0]
            labelCell83.textColor = .white
            backCell83.backgroundColor = UIColor(named: "vwBlue")
            backCell83.cornerRadius(radius: 10)
        } else {
            labelCell83.text = dados8[2]
        }
        
        let dados9 = tabela.valores[8]
        
        if dados9[0].components(separatedBy: " - ").count > 1 {
            labelCell91.text = dados9[0].components(separatedBy: " - ")[0]
            labelCell91.textColor = .white
            backCell91.backgroundColor = UIColor(named: "vwBlue")
            backCell91.cornerRadius(radius: 10)
        } else {
            labelCell91.text = dados9[0]
        }
        
        if dados9[1].components(separatedBy: " - ").count > 1 {
            labelCell92.text = dados9[1].components(separatedBy: " - ")[0]
            labelCell92.textColor = .white
            backCell92.backgroundColor = UIColor(named: "vwBlue")
            backCell92.cornerRadius(radius: 10)
        } else {
            labelCell92.text = dados9[1]
        }
        
        if dados9[2].components(separatedBy: " - ").count > 1 {
            labelCell93.text = dados9[2].components(separatedBy: " - ")[0]
            labelCell93.textColor = .white
            backCell93.backgroundColor = UIColor(named: "vwBlue")
            backCell93.cornerRadius(radius: 10)
        } else {
            labelCell93.text = dados9[2]
        }
        
        let dados10 = tabela.valores[9]
        
        if dados10[0].components(separatedBy: " - ").count > 1 {
            labelCell101.text = dados10[0].components(separatedBy: " - ")[0]
            labelCell101.textColor = .white
            backCell101.backgroundColor = UIColor(named: "vwBlue")
            backCell101.cornerRadius(radius: 10)
        } else {
            labelCell101.text = dados10[0]
        }
        
        if dados10[1].components(separatedBy: " - ").count > 1 {
            labelCell102.text = dados10[1].components(separatedBy: " - ")[0]
            labelCell102.textColor = .white
            backCell102.backgroundColor = UIColor(named: "vwBlue")
            backCell102.cornerRadius(radius: 10)
        } else {
            labelCell102.text = dados10[1]
        }
        
        if dados10[2].components(separatedBy: " - ").count > 1 {
            labelCell103.text = dados10[2].components(separatedBy: " - ")[0]
            labelCell103.textColor = .white
            backCell103.backgroundColor = UIColor(named: "vwBlue")
            backCell103.cornerRadius(radius: 10)
        } else {
            labelCell103.text = dados10[2]
        }
        
        let dados11 = tabela.valores[10]
        
        if dados11[0].components(separatedBy: " - ").count > 1 {
            labelCell111.text = dados11[0].components(separatedBy: " - ")[0]
            labelCell111.textColor = .white
            backCell111.backgroundColor = UIColor(named: "vwBlue")
            backCell111.cornerRadius(radius: 10)
        } else {
            labelCell111.text = dados11[0]
        }
        
        if dados11[1].components(separatedBy: " - ").count > 1 {
            labelCell112.text = dados11[1].components(separatedBy: " - ")[0]
            labelCell112.textColor = .white
            backCell112.backgroundColor = UIColor(named: "vwBlue")
            backCell112.cornerRadius(radius: 10)
        } else {
            labelCell112.text = dados11[1]
        }
        
        if dados11[2].components(separatedBy: " - ").count > 1 {
            labelCell113.text = dados11[2].components(separatedBy: " - ")[0]
            labelCell113.textColor = .white
            backCell113.backgroundColor = UIColor(named: "vwBlue")
            backCell113.cornerRadius(radius: 10)
        } else {
            labelCell113.text = dados11[2]
        }
        
        let dados12 = tabela.valores[11]
        
        if dados12[0].components(separatedBy: " - ").count > 1 {
            labelCell121.text = dados12[0].components(separatedBy: " - ")[0]
            labelCell121.textColor = .white
            backCell121.backgroundColor = UIColor(named: "vwBlue")
            backCell121.cornerRadius(radius: 10)
        } else {
            labelCell121.text = dados12[0]
        }
        
        if dados12[1].components(separatedBy: " - ").count > 1 {
            labelCell122.text = dados12[1].components(separatedBy: " - ")[0]
            labelCell122.textColor = .white
            backCell122.backgroundColor = UIColor(named: "vwBlue")
            backCell122.cornerRadius(radius: 10)
        } else {
            labelCell122.text = dados12[1]
        }
        
        if dados12[2].components(separatedBy: " - ").count > 1 {
            labelCell123.text = dados12[2].components(separatedBy: " - ")[0]
            labelCell123.textColor = .white
            backCell123.backgroundColor = UIColor(named: "vwBlue")
            backCell123.cornerRadius(radius: 10)
        } else {
            labelCell123.text = dados12[2]
        }
        
        let dados13 = tabela.valores[12]
        
        if dados13[0].components(separatedBy: " - ").count > 1 {
            labelCell131.text = dados13[0].components(separatedBy: " - ")[0]
            labelCell131.textColor = .white
            backCell131.backgroundColor = UIColor(named: "vwBlue")
            backCell131.cornerRadius(radius: 10)
        } else {
            labelCell131.text = dados13[0]
        }
        
        if dados13[1].components(separatedBy: " - ").count > 1 {
            labelCell132.text = dados13[1].components(separatedBy: " - ")[0]
            labelCell132.textColor = .white
            backCell132.backgroundColor = UIColor(named: "vwBlue")
            backCell132.cornerRadius(radius: 10)
        } else {
            labelCell132.text = dados13[1]
        }
        
        if dados13[2].components(separatedBy: " - ").count > 1 {
            labelCell133.text = dados13[2].components(separatedBy: " - ")[0]
            labelCell133.textColor = .white
            backCell133.backgroundColor = UIColor(named: "vwBlue")
            backCell133.cornerRadius(radius: 10)
        } else {
            labelCell133.text = dados13[2]
        }
        
        let dados14 = tabela.valores[13]
        
        if dados14[0].components(separatedBy: " - ").count > 1 {
            labelCell141.text = dados14[0].components(separatedBy: " - ")[0]
            labelCell141.textColor = .white
            backCell141.backgroundColor = UIColor(named: "vwBlue")
            backCell141.cornerRadius(radius: 10)
        } else {
            labelCell141.text = dados14[0]
        }
        
        if dados14[1].components(separatedBy: " - ").count > 1 {
            labelCell142.text = dados14[1].components(separatedBy: " - ")[0]
            labelCell142.textColor = .white
            backCell142.backgroundColor = UIColor(named: "vwBlue")
            backCell142.cornerRadius(radius: 10)
        } else {
            labelCell142.text = dados14[1]
        }
        
        if dados14[2].components(separatedBy: " - ").count > 1 {
            labelCell143.text = dados14[2].components(separatedBy: " - ")[0]
            labelCell143.textColor = .white
            backCell143.backgroundColor = UIColor(named: "vwBlue")
            backCell143.cornerRadius(radius: 10)
        } else {
            labelCell143.text = dados14[2]
        }
        
        let dados15 = tabela.valores[14]
        
        if dados15[0].components(separatedBy: " - ").count > 1 {
            labelCell151.text = dados15[0].components(separatedBy: " - ")[0]
            labelCell151.textColor = .white
            backCell151.backgroundColor = UIColor(named: "vwBlue")
            backCell151.cornerRadius(radius: 10)
        } else {
            labelCell151.text = dados15[0]
        }
        
        if dados15[1].components(separatedBy: " - ").count > 1 {
            labelCell152.text = dados15[1].components(separatedBy: " - ")[0]
            labelCell152.textColor = .white
            backCell152.backgroundColor = UIColor(named: "vwBlue")
            backCell152.cornerRadius(radius: 10)
        } else {
            labelCell152.text = dados15[1]
        }
        
        if dados15[2].components(separatedBy: " - ").count > 1 {
            labelCell153.text = dados15[2].components(separatedBy: " - ")[0]
            labelCell153.textColor = .white
            backCell153.backgroundColor = UIColor(named: "vwBlue")
            backCell153.cornerRadius(radius: 10)
        } else {
            labelCell153.text = dados15[2]
        }
        
        let dados16 = tabela.valores[15]
        
        if dados16[0].components(separatedBy: " - ").count > 1 {
            labelCell161.text = dados16[0].components(separatedBy: " - ")[0]
            labelCell161.textColor = .white
            backCell161.backgroundColor = UIColor(named: "vwBlue")
            backCell161.cornerRadius(radius: 10)
        } else {
            labelCell161.text = dados16[0]
        }
        
        if dados16[1].components(separatedBy: " - ").count > 1 {
            labelCell162.text = dados16[1].components(separatedBy: " - ")[0]
            labelCell162.textColor = .white
            backCell162.backgroundColor = UIColor(named: "vwBlue")
            backCell162.cornerRadius(radius: 10)
        } else {
            labelCell162.text = dados16[1]
        }
        
        if dados16[2].components(separatedBy: " - ").count > 1 {
            labelCell163.text = dados16[2].components(separatedBy: " - ")[0]
            labelCell163.textColor = .white
            backCell163.backgroundColor = UIColor(named: "vwBlue")
            backCell163.cornerRadius(radius: 10)
        } else {
            labelCell163.text = dados16[2]
        }
        
        backView.isHidden = false
    }
    
}

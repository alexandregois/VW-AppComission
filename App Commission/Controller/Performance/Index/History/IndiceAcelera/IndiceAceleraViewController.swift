//
//  IndiceAceleraViewController.swift
//  App Commission
//
//  Created by Camilo Oscar Girardelli Baptista on 13/07/23.
//

import Foundation
import UIKit
import Charts

class IndiceAceleraViewController: UIViewController, ChartViewDelegate {
    @IBOutlet weak var chartView: UIView!
    @IBOutlet weak var chart: LineChartView!
    @IBOutlet weak var indicativoVarejo: UIView!
    @IBOutlet weak var indicativoAcelera: UIView!
    @IBOutlet weak var indiceFrotaLabel: UILabel!
    @IBOutlet weak var fullGraphs: UILabel!
    @IBOutlet weak var screenTitle: UILabel!
    @IBOutlet weak var graphsIndicativoLinha: UILabel!
    
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var footerInfo: UILabel!
    var months: [String] = []
    
    public init() {
        super.init(nibName: "IndiceAceleraViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implementerd")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Índices e Acelera"
        screenTitle.text = "Índices e Acelera"
        graphsIndicativoLinha.text = "Índice Varejo"
        createSecondNavBar(true)
        indicativoVarejo.cornerRadius(radius: 6)
        indicativoAcelera.cornerRadius(radius: 6)
        chart.isUserInteractionEnabled = false
        let attributedString = NSMutableAttributedString.init(string: "Visualizar Índice Frota")
        
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range:
                                        NSRange.init(location: 0, length: attributedString.length));
        indiceFrotaLabel.attributedText = attributedString
        
        let attString = NSMutableAttributedString.init(string: "Visualizar gráfico completo")
        
        attString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range:
                                        NSRange.init(location: 0, length: attString.length));
        fullGraphs.attributedText = attString
        
        chartView.dropShadow()
        chartView.cornerRadius(radius: 15)
        
        self.createSpinnerView()
        configFooter()
        IndiceAceleraService.shared.getVarejo { indiceAcelera, error in
            
            if indiceAcelera != nil {
                
                let simpleData = indiceAcelera![0..<3]
                
                self.months.append("\(simpleData[2].periodo)")
                self.months.append("\(simpleData[1].periodo)")
                self.months.append("\(simpleData[0].periodo)")
                
                self.createChart(indiceAceleraArray: Array(simpleData))
                self.removeSpinnerView()
                
            }
            
            if error != nil {
                self.removeSpinnerView()
            }
        }
        
    }
    
    private func createChart(indiceAceleraArray: [IndiceAcelera]) {
        
        var axMax = 0
        
        for pf in indiceAceleraArray {
            if Int(pf.indiceVarejo.replacingOccurrences(of: "%", with: "").components(separatedBy: ",")[0])! > axMax {
                axMax = Int(pf.indiceVarejo.replacingOccurrences(of: "%", with: "").components(separatedBy: ",")[0])!
            }
        }
        
        for pf in indiceAceleraArray {
            if Int(pf.programaAcelera.replacingOccurrences(of: "R$", with: "").components(separatedBy: ",")[0])! > axMax {
                axMax = Int(pf.programaAcelera.replacingOccurrences(of: "R$", with: "").components(separatedBy: ",")[0])!
            }
        }
        
        axMax += 30
        
        var yVals1: [ChartDataEntry] = []
        var yVals2: [ChartDataEntry] = []
        
        var xMax = 0
        
        for i in 1...indiceAceleraArray.count {
            let x = 10 * (i)
            let index = indiceAceleraArray.count - i
            yVals1.append(ChartDataEntry(x: Double(x), y: Double(indiceAceleraArray[index].indiceVarejo.replacingOccurrences(of: "%", with: "").replacingOccurrences(of: ",", with: "."))!))
            yVals2.append(ChartDataEntry(x: Double(x), y: Double(indiceAceleraArray[index].programaAcelera.replacingOccurrences(of: "R$", with: "").replacingOccurrences(of: ",", with: "."))!))
            
            if i == indiceAceleraArray.count {
                xMax = x
            }
        }
        
        xMax += 5
        
        chart.delegate = self
        chart.chartDescription.enabled = false
        chart.backgroundColor = .white
        chart.borderColor = .lightGray
        chart.borderLineWidth = 1
        chart.legend.enabled = false
        
        chart.drawBordersEnabled = true
        chart.xAxis.enabled = true
        
        let l = chart.legend
        l.wordWrapEnabled = true
        l.horizontalAlignment = .center
        l.verticalAlignment = .bottom
        l.orientation = .horizontal
        l.drawInside = false
        
        let leftAxisFormatter = NumberFormatter()
        leftAxisFormatter.minimumFractionDigits = 0
        leftAxisFormatter.maximumFractionDigits = 1
        leftAxisFormatter.negativeSuffix = " %"
        leftAxisFormatter.positiveSuffix = " %"
        
        let xAxis = chart.xAxis
        xAxis.labelFont = .systemFont(ofSize: 13)
        xAxis.labelTextColor = .darkGray
        xAxis.labelPosition = .bottom
        xAxis.axisMinimum = 5
        xAxis.axisMaximum = Double(xMax)
        xAxis.drawAxisLineEnabled = false
        xAxis.drawGridLinesEnabled = false
        xAxis.granularity = 1
        xAxis.valueFormatter = self
        
        let leftAxis = chart.leftAxis
        leftAxis.labelTextColor = .darkGray
        leftAxis.axisMaximum = Double(axMax)
        leftAxis.axisMinimum = 0
        leftAxis.drawGridLinesEnabled = false
        leftAxis.granularityEnabled = false
        leftAxis.drawAxisLineEnabled = false
        
        
        
        let rightAxis = chart.rightAxis
        rightAxis.labelTextColor = .darkGray
        rightAxis.axisMaximum = Double(axMax)
        rightAxis.axisMinimum = 0
        rightAxis.valueFormatter = DefaultAxisValueFormatter(formatter: leftAxisFormatter)
        rightAxis.drawGridLinesEnabled = false
        rightAxis.granularityEnabled = false
        rightAxis.drawAxisLineEnabled = false
        
        let line1Formatter = NumberFormatter()
        line1Formatter.minimumFractionDigits = 0
        line1Formatter.maximumFractionDigits = 3
        line1Formatter.negativeSuffix = " %"
        line1Formatter.positiveSuffix = " %"
        
        let set1 = LineChartDataSet(entries: yVals1, label: "Índice Varejo")
        set1.axisDependency = .left
        set1.setColor(UIColor(named: "vwBlue")!)
        set1.setCircleColor(UIColor(named: "vwBlue")!)
        set1.lineWidth = 4
        set1.circleRadius = 5
        set1.fillAlpha = 65/255
        set1.fillColor = UIColor(named: "vwBlue")!
        set1.highlightColor = UIColor(named: "vwBlue")!
        set1.drawCircleHoleEnabled = false
        set1.valueFormatter = ChartsFormatterPercent()
        
        
        let set2 = LineChartDataSet(entries: yVals2, label: "Programa Acelera")
        set2.axisDependency = .right
        set2.setColor(.link)
        set2.setCircleColor(.link)
        set2.lineWidth = 4
        set2.circleRadius = 5
        set2.fillAlpha = 65/255
        set2.fillColor = .link
        set2.highlightColor = .link
        set2.drawCircleHoleEnabled = false
        set2.valueFormatter = ChartsFormatterMoney()
        
        let data: LineChartData = [set1, set2]
        data.setValueTextColor(.darkGray)
        data.setValueFont(.systemFont(ofSize: 13))
        
        chart.data = data
    }
    
    private func configFooter() {
        let dataCarga = defaults.string(forKey: SystemKeys.DATA_CARGA)
        
        footerInfo.text = "O índice projetado tem como base a performance atualizada até \(dataCarga!) e poderá sofrer alterações. Os valores apresentados não garantem qualquer tipo de remuneração."
        fullGraphs.isUserInteractionEnabled = true
        fullGraphs.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.selectFullGraphs)))
        
        indiceFrotaLabel.isUserInteractionEnabled = true
        indiceFrotaLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.selectVarejo)))
    }
    
    @objc func selectVarejo() {
        let vc = IndiceAceleraFrotaViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func selectFullGraphs() {
        let vc = IndiceAceleraFullTableViewController()
        vc.graphType = .varejo
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension IndiceAceleraViewController: AxisValueFormatter {
    
    
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        
        if value == 10.0 {
            return months[0]
        }
        
        if value == 20.0 {
            return months[1]
        }
        
        if value == 30.0 {
            return months[2]
        }
        
        return ""
    }
    
}

class ChartsFormatterPercent: ValueFormatter {
    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        return "\(value) %".replacingOccurrences(of: ".", with: ",")
    }
}

class ChartsFormatterMoney: ValueFormatter {
    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        return "R$\(value)".replacingOccurrences(of: ".", with: ",")
    }
}

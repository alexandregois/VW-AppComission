//
//  IndiceAceleraFullTableViewController.swift
//  App Commission
//
//  Created by Camilo Oscar Girardelli Baptista on 17/07/23.
//

import Foundation
import UIKit
import Charts

enum graphType {
    case varejo
    case frota
}

class IndiceAceleraFullTableViewController: UIViewController, ChartViewDelegate {
    @IBOutlet weak var chartView: UIView!
    @IBOutlet weak var chart: LineChartView!
    @IBOutlet weak var indicativoVarejo: UIView!
    @IBOutlet weak var indicativoAcelera: UIView!
    @IBOutlet weak var graphsIndicativoLinha: UILabel!
    @IBOutlet weak var footerInfo: UILabel!
    
    let defaults = UserDefaults.standard
    
    var graphType: graphType = .varejo
    
    
    var months: [String] = []
    
    public init() {
        super.init(nibName: "IndiceAceleraFullTableViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implementerd")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Índices e Acelera"
        graphsIndicativoLinha.text = "Índice Varejo"
        createSecondNavBar(true)
        indicativoVarejo.cornerRadius(radius: 6)
        indicativoAcelera.cornerRadius(radius: 6)
        
        chartView.dropShadow()
        chartView.cornerRadius(radius: 15)
        
        self.createSpinnerView()
        configFooter()
        
        if graphType == .varejo {
            graphsIndicativoLinha.text = "Índice Varejo"
            IndiceAceleraService.shared.getVarejo { indiceAcelera, error in
                
                if indiceAcelera != nil {
                    
                    for i in 1...indiceAcelera!.count {
                        let index = indiceAcelera!.count - i
                        self.months.append("\(indiceAcelera![index].periodo)")
                    }
                    
                    self.createChart(indiceAceleraArray: indiceAcelera!)
                    self.removeSpinnerView()
                    
                }
                
                if error != nil {
                    self.removeSpinnerView()
                }
            }
        } else {
            graphsIndicativoLinha.text = "Índice Frota"
            IndiceAceleraService.shared.getFrota { indiceAcelera, error in
                
                if indiceAcelera != nil {
                    
                    for i in 1...indiceAcelera!.count {
                        let index = indiceAcelera!.count - i
                        self.months.append("\(indiceAcelera![index].periodo)")
                    }
                    
                    self.createChart(indiceAceleraArray: indiceAcelera!)
                    self.removeSpinnerView()
                    
                }
                
                if error != nil {
                    self.removeSpinnerView()
                }
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
        chart.isUserInteractionEnabled = false
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
        xAxis.labelFont = .systemFont(ofSize: 11)
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
        data.setValueFont(.systemFont(ofSize: 12))
        
        chart.data = data
    }
    
    private func configFooter() {
        let dataCarga = defaults.string(forKey: SystemKeys.DATA_CARGA)
        
        footerInfo.text = "O índice projetado tem como base a performance atualizada até \(dataCarga!) e poderá sofrer alterações. Os valores apresentados não garantem qualquer tipo de remuneração."

    }
    
}

extension IndiceAceleraFullTableViewController: AxisValueFormatter {
    
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
        
        if value == 40.0 {
            return months[3]
        }
        
        if value == 50.0 {
            return months[4]
        }
        
        if value == 60.0 {
            return months[5]
        }
        
        if value == 70.0 {
            return months[6]
        }
        
        if value == 80.0 {
            return months[7]
        }
        
        if value == 90.0 {
            return months[8]
        }
        
        if value == 100.0 {
            return months[9]
        }
        
        
        return ""
    }
    
}


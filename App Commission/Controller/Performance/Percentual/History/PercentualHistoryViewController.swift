//
//  PercentualHistoryViewController.swift
//  App Commission
//
//  Created by Camilo Oscar Girardelli Baptista on 18/07/23.
//

import Foundation

import UIKit
import Charts

class PercentualHistoryViewController: UIViewController, ChartViewDelegate {
    @IBOutlet weak var chartView: UIView!
    @IBOutlet weak var chart: LineChartView!
    @IBOutlet weak var indicativoVarejo: UIView!
    @IBOutlet weak var indicativoAcelera: UIView!
    @IBOutlet weak var indiceFrotaLabel: UnderlinedLabel!
    @IBOutlet weak var fullGraphs: UnderlinedLabel!
    @IBOutlet weak var screenTitle: UILabel!
    @IBOutlet weak var footerInfo: UILabel!
    
    let defaults = UserDefaults.standard
    
    var months: [String] = []
    
    public init() {
        super.init(nibName: "PercentualHistoryViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implementerd")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Performance por Período"
        screenTitle.text = "Performance por Período"
        createSecondNavBar(true)
        indicativoVarejo.cornerRadius(radius: 6)
        indicativoAcelera.cornerRadius(radius: 6)
        chartView.dropShadow()
        chartView.cornerRadius(radius: 15)
        chart.isUserInteractionEnabled = false
        let attributedString = NSMutableAttributedString.init(string: "Visualizar Índice Frota")
        
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range:
                                        NSRange.init(location: 0, length: attributedString.length));
        indiceFrotaLabel.attributedText = attributedString
        
        let attString = NSMutableAttributedString.init(string: "Visualizar gráfico completo")
        
        attString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range:
                                        NSRange.init(location: 0, length: attString.length));
        fullGraphs.attributedText = attString
        
        self.createSpinnerView()
        configFooter()
        HistoryIndexService.shared.getVarejo { performanceHistory, error in
            
            if performanceHistory != nil {
                
                let simpleData = performanceHistory![0..<3]
                
                self.months.append("\(simpleData[2].periodo)")
                self.months.append("\(simpleData[1].periodo)")
                self.months.append("\(simpleData[0].periodo)")
                
                self.createChart(performanceHistoryArray: Array(simpleData))
                self.removeSpinnerView()
                
            }
            
            if error != nil {
                self.removeSpinnerView()
            }
        }
        
    }
    
    private func createChart(performanceHistoryArray: [PerformanceHistory]) {
        var axMax = 0
        
        for pf in performanceHistoryArray {
            if Int(pf.penetration.components(separatedBy: ",")[0])! > axMax {
                axMax = Int(pf.penetration.components(separatedBy: ",")[0])!
            }
        }
        
        for pf in performanceHistoryArray {
            if Int(pf.isr.components(separatedBy: ",")[0])! > axMax {
                axMax = Int(pf.isr.components(separatedBy: ",")[0])!
            }
        }
        
        axMax += 5
        
        var yVals1: [ChartDataEntry] = []
        var yVals2: [ChartDataEntry] = []
        
        var xMax = 0
        
        for i in 1...performanceHistoryArray.count {
            let x = 10 * (i)
            let index = performanceHistoryArray.count - i
            yVals1.append(ChartDataEntry(x: Double(x), y: Double(performanceHistoryArray[index].penetration.replacingOccurrences(of: ",", with: "."))!))
            yVals2.append(ChartDataEntry(x: Double(x), y: Double(performanceHistoryArray[index].isr.replacingOccurrences(of: ",", with: "."))!))
            
            if i == performanceHistoryArray.count {
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
        leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: leftAxisFormatter)
        leftAxis.drawGridLinesEnabled = false
        leftAxis.granularityEnabled = false
        leftAxis.drawAxisLineEnabled = false
        
        
        
        let rightAxis = chart.rightAxis
        rightAxis.labelTextColor = .white
        rightAxis.axisMaximum = 150
        rightAxis.axisMinimum = 0
        rightAxis.drawGridLinesEnabled = false
        rightAxis.granularityEnabled = false
        rightAxis.drawAxisLineEnabled = false
        
        
        
        let line1Formatter = NumberFormatter()
        line1Formatter.minimumFractionDigits = 0
        line1Formatter.maximumFractionDigits = 3
        line1Formatter.negativeSuffix = " %"
        line1Formatter.positiveSuffix = " %"
        
        let set1 = LineChartDataSet(entries: yVals1, label: "Penetration")
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
        
        
        let set2 = LineChartDataSet(entries: yVals2, label: "ISR")
        set2.axisDependency = .right
        set2.setColor(.link)
        set2.setCircleColor(.link)
        set2.lineWidth = 4
        set2.circleRadius = 5
        set2.fillAlpha = 65/255
        set2.fillColor = .link
        set2.highlightColor = .link
        set2.drawCircleHoleEnabled = false
        set2.valueFormatter = ChartsFormatterPercent()
        
        let data: LineChartData = [set1, set2]
        data.setValueTextColor(.darkGray)
        data.setValueFont(.systemFont(ofSize: 13))
        
        chart.data = data
    }
    
    private func configFooter() {
        let dataCarga = defaults.string(forKey: SystemKeys.DATA_CARGA)
        
        
        fullGraphs.isUserInteractionEnabled = true
        fullGraphs.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.selectFullGraphs)))
        
        indiceFrotaLabel.isUserInteractionEnabled = true
        indiceFrotaLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.selectVarejo)))
        
        footerInfo.text = "O índice projetado tem como base a performance atualizada até \(dataCarga!) e poderá sofrer alterações. Os valores apresentados não garantem qualquer tipo de remuneração."
    }
    
    @objc func selectVarejo() {
        let vc = PercentualHistoryFrotaViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func selectFullGraphs() {
        let vc = PercentualHistoryFullTableViewController()
        vc.graphType = .varejo
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension PercentualHistoryViewController: AxisValueFormatter {
    
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


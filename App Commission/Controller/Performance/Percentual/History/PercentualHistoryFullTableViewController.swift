//
//  IndiceAceleraFullTableViewController.swift
//  App Commission
//
//  Created by Camilo Oscar Girardelli Baptista on 18/07/23.
//

import Foundation
import UIKit
import Charts


class PercentualHistoryFullTableViewController: UIViewController, ChartViewDelegate {
    @IBOutlet weak var chartView: UIView!
    @IBOutlet weak var chart: LineChartView!
    @IBOutlet weak var screenTitle: UILabel!
    @IBOutlet weak var indicativoVarejo: UIView!
    @IBOutlet weak var indicativoAcelera: UIView!
    @IBOutlet weak var footerInfo: UILabel!
    
    let defaults = UserDefaults.standard
    
    var graphType: graphType = .varejo
    
    
    var months: [String] = []
    
    public init() {
        super.init(nibName: "PercentualHistoryFullTableViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implementerd")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Performance por Período"
        
        if graphType == .varejo {
            screenTitle.text = "Performance por Período Varejo"
        } else {
            screenTitle.text = "Performance por Período Frota"
        }
        createSecondNavBar(true)
        indicativoVarejo.cornerRadius(radius: 6)
        indicativoAcelera.cornerRadius(radius: 6)
        configFooter()
        chart.isUserInteractionEnabled = false
        chartView.dropShadow()
        chartView.cornerRadius(radius: 15)
        
        self.createSpinnerView()
        
        if graphType == .varejo {
            HistoryIndexService.shared.getVarejo { performanceHistory, error in
                
                if performanceHistory != nil {
                    
                    for i in 1...performanceHistory!.count {
                        let index = performanceHistory!.count - i
                        self.months.append("\(performanceHistory![index].periodo)")
                    }
                    
                    self.createChart(performanceHistoryArray: performanceHistory!)
                    self.removeSpinnerView()
                }
                
                if error != nil {
                    self.removeSpinnerView()
                }
            }
        } else {
            HistoryIndexService.shared.getFrota { performanceHistory, error in
                
                if performanceHistory != nil {
                    
                    for i in 1...performanceHistory!.count {
                        let index = performanceHistory!.count - i
                        self.months.append("\(performanceHistory![index].periodo)")
                    }
                    
                    self.createChart(performanceHistoryArray: performanceHistory!)
                    self.removeSpinnerView()
                }
                
                if error != nil {
                    self.removeSpinnerView()
                }
            }
        }
        
        
    }
    
    private func configFooter() {
        let dataCarga = defaults.string(forKey: SystemKeys.DATA_CARGA)
        
        footerInfo.text = "O índice projetado tem como base a performance atualizada até \(dataCarga!) e poderá sofrer alterações. Os valores apresentados não garantem qualquer tipo de remuneração."
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
}

extension PercentualHistoryFullTableViewController: AxisValueFormatter {
    
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


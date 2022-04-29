//
//  GraphicTableViewCell.swift
//  ExamenJD
//
//  Created by YEiK on 29/04/22.
//

import UIKit
import Charts

class GraphicTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var pieChartView: PieChartView!
    
    var iosDataEntry = PieChartDataEntry(value: 0)
    var macDataEntry = PieChartDataEntry(value: 0)
    
    var numberOfDownloadsDataEntries = [PieChartDataEntry]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLbl.text = "¿Estaba limpia la sucursal?"
        
        iosDataEntry.value = 60
        iosDataEntry.label = "\("SI") \(60)%"
        
        macDataEntry.value = 40
        macDataEntry.label = "\("NO") \(40)%"
        
        numberOfDownloadsDataEntries = [iosDataEntry, macDataEntry]
        updateChartData()
    }
    
    func updateChartData() {
        
        let chartDataSet = PieChartDataSet(entries: numberOfDownloadsDataEntries, label: "")
        let chartData = PieChartData(dataSet: chartDataSet)
        
        let colors = [UIColor.systemGreen, UIColor.systemRed]
        chartDataSet.colors = colors
        
        pieChartView.data = chartData
        
        
    }
    
}

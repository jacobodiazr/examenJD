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
    
    var numberOfDownloadsDataEntries = [PieChartDataEntry]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func config(itemGraphic : Graphics){
        titleLbl.text = itemGraphic.title
        var colors = [UIColor]()
        for item in itemGraphic.itemsData {
            let dataEntry = PieChartDataEntry(value: 0)
            dataEntry.label = item.title
            dataEntry.value = item.value
            numberOfDownloadsDataEntries.append(dataEntry)
            colors.append(UIColor(item.color))
        }
        let chartDataSet = PieChartDataSet(entries: numberOfDownloadsDataEntries, label: "")
        let chartData = PieChartData(dataSet: chartDataSet)
        chartDataSet.colors = colors
        pieChartView.data = chartData
    }
    
}

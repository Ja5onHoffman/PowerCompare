//
//  ChartsGraph.swift
//  PowerCompare
//
//  Created by Jason Hoffman on 12/15/21.
//

import Foundation
import SwiftUI
import Charts

struct ChartsPowerGraph: UIViewRepresentable {
    
    var powerData1: [ChartDataEntry]
    var powerData2: [ChartDataEntry]
    let chart = LineChartView()

    func makeUIView(context: Context) -> LineChartView {
        chart.delegate = context.coordinator
        return chart
    }
    
    func updateUIView(_ uiView: LineChartView, context: Context) {
        let powerData = LineChartDataSet(entries: powerData1)
        let powerData2 = LineChartDataSet(entries: powerData2)
        powerData.label = "Watts"
        powerData2.label = "Watts2"
        
//        uiView.data = LineChartData(dataSet: powerData)
        uiView.data = LineChartData(dataSets: [powerData, powerData2])
        chart.noDataText = "This updated"
        formatDataSet(dataSet: powerData)
        formatDataSet2(dataSet: powerData2)
        uiView.rightAxis.enabled = false
        if uiView.scaleX == 1.0 {
            uiView.zoom(scaleX: 1.5, scaleY: 1, x: 0, y: 0)
        }
        uiView.setScaleEnabled(true)
        formatLeftAxis(leftAxis: uiView.leftAxis)
//        formatXAxis(xAxis: uiView.xAxis)
        uiView.notifyDataSetChanged()
    }
    
    func formatDataSet(dataSet: LineChartDataSet) {
        dataSet.drawValuesEnabled = false
        dataSet.mode = .horizontalBezier
        dataSet.colors = [.blue]
        dataSet.drawCirclesEnabled = false
        dataSet.lineWidth = 3.0
    }
    
    func formatDataSet2(dataSet: LineChartDataSet) {
        dataSet.drawValuesEnabled = false
        dataSet.colors = [.red]
        dataSet.mode = .horizontalBezier
        dataSet.drawCirclesEnabled = false
        dataSet.lineWidth = 3.0
    }
    
    func formatLeftAxis(leftAxis: YAxis) {
        leftAxis.labelTextColor = .red
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: formatter)
    }
    
    class Coordinator: NSObject, ChartViewDelegate {
        let parent: ChartsPowerGraph
        init(parent: ChartsPowerGraph) {
            self.parent = parent
        }
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
//    func formatXAxis(xAxis: XAxis) {
//        xAxis.valueFormatter = IndexAxisValueFormatter(
////        xAxis.valueFormatter = IndexAxisValueFormatter(values: PowerData.powerSample)
//        xAxis.labelPosition = .bottom
//        xAxis.labelTextColor = .red
//    }
}

struct ChartsPowerGraph_Previews: PreviewProvider {
    static var previews: some View {
//        TestChartView(powerData1: PowerData.chartPowerData(PowerData.powerSample))
        ChartsPowerGraph(
            powerData1: ChartsPowerData.chartPowerData(ChartsPowerData.powerSample),
            powerData2: ChartsPowerData.chartPowerData(ChartsPowerData.powerSample2)
            )
    }
}

    

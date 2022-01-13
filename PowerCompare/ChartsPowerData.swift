//
//  ChartsPowerData.swift
//  ChartsTest
//
//  Created by Jason Hoffman on 12/14/21.
//

import Foundation
import Charts


struct ChartsPowerData {
    var watts: Double
    var time: String {
        let d = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter.string(from: d)
    }
    
    static func chartPowerData(_ powerArray: [ChartsPowerData]) -> [ChartDataEntry] {
        return powerArray.enumerated().map { (index, element) in
            ChartDataEntry(x: Double(index), y: element.watts)
        }
    }
    
    static func powerDataTwo(_ powerArray: [ChartsPowerData]) -> [ChartDataEntry] {
        return powerArray.enumerated().map { (index, element) in
            ChartDataEntry(x: Double(index), y: element.watts)
        }
    }
    
    static var powerSample: [ChartsPowerData] = [
        ChartsPowerData(watts: 200.0),
        ChartsPowerData(watts:205.0),
        ChartsPowerData(watts: 210.0),
        ChartsPowerData(watts: 210.0),
        ChartsPowerData(watts: 215.0),
        ChartsPowerData(watts: 220.0),
        ChartsPowerData(watts: 225.0),
        ChartsPowerData(watts: 220.0),
        ChartsPowerData(watts: 220.0),
        ChartsPowerData(watts: 215.0),
        ChartsPowerData(watts: 210.0),
        ChartsPowerData(watts: 210.0),
        ChartsPowerData(watts: 205.0),
        ChartsPowerData(watts: 200.0),
        ChartsPowerData(watts: 190.0),
        ChartsPowerData(watts: 180.0),
        ChartsPowerData(watts: 180.0),
        ChartsPowerData(watts: 190.0),
        ChartsPowerData(watts: 195.0),
        ChartsPowerData(watts: 190.0)
    ]
    
    static var powerSample2: [ChartsPowerData] = [
        ChartsPowerData(watts: 210.0),
        ChartsPowerData(watts:215.0),
        ChartsPowerData(watts: 220.0),
        ChartsPowerData(watts: 205.0),
        ChartsPowerData(watts: 210.0),
        ChartsPowerData(watts: 215.0),
        ChartsPowerData(watts: 230.0),
        ChartsPowerData(watts: 225.0),
        ChartsPowerData(watts: 215.0),
        ChartsPowerData(watts: 210.0),
        ChartsPowerData(watts: 215.0),
        ChartsPowerData(watts: 205.0),
        ChartsPowerData(watts: 200.0),
        ChartsPowerData(watts: 190.0),
        ChartsPowerData(watts: 185.0),
        ChartsPowerData(watts: 175.0),
        ChartsPowerData(watts: 185.0),
        ChartsPowerData(watts: 185.0),
        ChartsPowerData(watts: 200.0),
        ChartsPowerData(watts: 200.0)
    ]
}

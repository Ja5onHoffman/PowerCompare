//
//  ChartsPowerData.swift
//  ChartsTest
//
//  Created by Jason Hoffman on 12/14/21.
//

import Charts
import SwiftUI

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

// Only for export
struct ChartsPowerArray: Identifiable {
    var id = UUID()
    var values = [ChartsPowerData(watts: 0.0)]
    var average: Double {
        get {
            let sum = values.reduce(0.0) { a, b in
                return a + b.watts
            }
            return Double(sum) / Double(values.count)
        }
    }
    
    var chartsPower: [ChartDataEntry] {
        return self.values.enumerated().map { (index, element) in
            ChartDataEntry(x: Double(index), y: element.watts)
        }
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

    mutating func addValue(_ val: ChartsPowerData) {
        values.append(val)
    }
    
    func zero() -> ChartsPowerData {
        return ChartsPowerData(watts: 0)
    }
}


extension ChartsPowerData  {
    static func + (left: ChartsPowerData, right: ChartsPowerData) -> Double {
        // Double instead of ChartsPowerData is easier
        return left.watts + right.watts
    }
}

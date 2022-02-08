//
//  PowerData.swift
//  ChartsTest
//
//  Created by Jason Hoffman on 12/14/21.
//

import Charts
import SwiftUI

struct PowerData {
    var watts: Double
    var time: String {
        let d = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter.string(from: d)
    }
    
    static func chartPowerData(_ powerArray: [PowerData]) -> [ChartDataEntry] {
        return powerArray.enumerated().map { (index, element) in
            ChartDataEntry(x: Double(index), y: element.watts)
        }
    }
    
    static var powerSample: [PowerData] = [
        PowerData(watts: 200.0),
        PowerData(watts:205.0),
        PowerData(watts: 210.0),
        PowerData(watts: 210.0),
        PowerData(watts: 215.0),
        PowerData(watts: 220.0),
        PowerData(watts: 225.0),
        PowerData(watts: 220.0),
        PowerData(watts: 220.0),
        PowerData(watts: 215.0),
        PowerData(watts: 210.0),
        PowerData(watts: 210.0),
        PowerData(watts: 205.0),
        PowerData(watts: 200.0),
        PowerData(watts: 190.0),
        PowerData(watts: 180.0),
        PowerData(watts: 180.0),
        PowerData(watts: 190.0),
        PowerData(watts: 195.0),
        PowerData(watts: 190.0)
    ]
    
    static var powerSample2: [PowerData] = [
        PowerData(watts: 210.0),
        PowerData(watts:215.0),
        PowerData(watts: 220.0),
        PowerData(watts: 205.0),
        PowerData(watts: 210.0),
        PowerData(watts: 215.0),
        PowerData(watts: 230.0),
        PowerData(watts: 225.0),
        PowerData(watts: 215.0),
        PowerData(watts: 210.0),
        PowerData(watts: 215.0),
        PowerData(watts: 205.0),
        PowerData(watts: 200.0),
        PowerData(watts: 190.0),
        PowerData(watts: 185.0),
        PowerData(watts: 175.0),
        PowerData(watts: 185.0),
        PowerData(watts: 185.0),
        PowerData(watts: 200.0),
        PowerData(watts: 200.0)
    ]
}

// Only for export
struct PowerArray: Identifiable {
    var id = UUID()
    var values = [PowerData(watts: 0.0)]
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
    
    static func chartPowerData(_ powerArray: [PowerData]) -> [ChartDataEntry] {
        return powerArray.enumerated().map { (index, element) in
            ChartDataEntry(x: Double(index), y: element.watts)
        }
    }
    
    static func powerDataTwo(_ powerArray: [PowerData]) -> [ChartDataEntry] {
        return powerArray.enumerated().map { (index, element) in
            ChartDataEntry(x: Double(index), y: element.watts)
        }
    }

    mutating func addValue(_ val: PowerData) {
        values.append(val)
    }
    
    func zero() -> PowerData {
        return PowerData(watts: 0)
    }
}


extension PowerData  {
    static func + (left: PowerData, right: PowerData) -> Double {
        // Double instead of PowerData is easier
        return left.watts + right.watts
    }
}


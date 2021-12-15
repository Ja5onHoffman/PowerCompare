//
//  ChartsPowerData.swift
//  PowerCompare
//
//  Created by Jason Hoffman on 12/15/21.
//

import Foundation
import Charts

struct ChartsPowerData: Identifiable, Hashable {
    let id = UUID()
    var watts: Double
    
    // Use time instead of index?
//    var time: String {
//        let d = Date()
//        let formatter = DateFormatter()
//        formatter.dateStyle = .none
//        formatter.timeStyle = .short
//        return formatter.string(from: d)
//    }
    
    static func powerDataOne(_ powerArray: [ChartsPowerData]) -> [ChartDataEntry] {
        return powerArray.enumerated().map { (index, element) in
            ChartDataEntry(x: Double(index), y: element.watts)
        }
    }
    
    static func powerDataTwo(_ powerArray: [ChartsPowerData]) -> [ChartDataEntry] {
        return powerArray.enumerated().map { (index, element) in
            ChartDataEntry(x: Double(index), y: element.watts)
        }
    }
    
}

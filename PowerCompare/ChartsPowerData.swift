//
//  ChartsPowerData.swift
//  PowerCompare
//
//  Created by Jason Hoffman on 12/15/21.
//

import Foundation
import Charts

struct ChartsPower: Identifiable, Hashable {
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
    

    
}

struct ChartsPowerData {
    
    // Or use init
    static var powerData1 = [ChartsPower]()
    static var powerData2 = [ChartsPower]()
    
    static func powerData(_ powerArray: [ChartsPower]) -> [ChartDataEntry] {
        return powerArray.enumerated().map { (index, element) in
            ChartDataEntry(x: Double(index), y: element.watts)
        }
    }
    
    static var powerSample: [ChartsPower] = [
        ChartsPower(watts: 200.0),
        ChartsPower(watts: 205.0),
        ChartsPower(watts: 210.0),
        ChartsPower(watts: 210.0),
        ChartsPower(watts: 215.0),
        ChartsPower(watts: 220.0),
        ChartsPower(watts: 225.0),
        ChartsPower(watts: 220.0),
        ChartsPower(watts: 220.0),
        ChartsPower(watts: 215.0),
        ChartsPower(watts: 210.0),
        ChartsPower(watts: 210.0),
        ChartsPower(watts: 205.0),
        ChartsPower(watts: 200.0),
        ChartsPower(watts: 190.0),
        ChartsPower(watts: 180.0),
        ChartsPower(watts: 180.0),
        ChartsPower(watts: 190.0),
        ChartsPower(watts: 195.0),
        ChartsPower(watts: 190.0)
    ]
    
    static var powerSample2: [ChartsPower] = [
        ChartsPower(watts: 210.0),
        ChartsPower(watts: 215.0),
        ChartsPower(watts: 220.0),
        ChartsPower(watts: 205.0),
        ChartsPower(watts: 210.0),
        ChartsPower(watts: 215.0),
        ChartsPower(watts: 230.0),
        ChartsPower(watts: 225.0),
        ChartsPower(watts: 215.0),
        ChartsPower(watts: 210.0),
        ChartsPower(watts: 215.0),
        ChartsPower(watts: 205.0),
        ChartsPower(watts: 200.0),
        ChartsPower(watts: 190.0),
        ChartsPower(watts: 185.0),
        ChartsPower(watts: 175.0),
        ChartsPower(watts: 185.0),
        ChartsPower(watts: 185.0),
        ChartsPower(watts: 200.0),
        ChartsPower(watts: 200.0)
    ]
    
}

//
//  LineChartView.swift
//  PowerCompare
//
//  Created by Jason Hoffman on 7/28/21.
//

import SwiftUI

public struct LineChartView: View {
    public var data: [Double]
    public var style: LineChartStyle
    
    @State var showingIndicators = false
    @State var indexPosition = Int()
    
    public init(data: [Double], style: LineChartStyle) {
        self.data = data
        self.style = style
    }

    
    public var body: some View {
        VStack {
            LineView(data: data, style: style, indexPosition: $indexPosition)
        }
    }
}

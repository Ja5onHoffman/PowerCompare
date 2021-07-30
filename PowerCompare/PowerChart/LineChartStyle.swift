//
//  LineChartStyle.swift
//  PowerCompare
//
//  Created by Jason Hoffman on 7/28/21.
//

import SwiftUI

public class LineChartStyle {
    public var labelColor: Color

    public var flatTrendLineColor: Color
    public var uptrendLineColor: Color
    public var downtrendLineColor: Color
    
    public init(labelColor: Color, indicatorPointColor: Color, showingIndicatorLineColor: Color, flatTrendLineColor: Color, uptrendLineColor: Color, downtrendLineColor: Color) {
        self.labelColor = labelColor
        self.flatTrendLineColor = flatTrendLineColor
        self.uptrendLineColor = uptrendLineColor
        self.downtrendLineColor = downtrendLineColor
    }
}

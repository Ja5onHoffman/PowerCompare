//
//  LineView.swift
//  PowerCompare
//
//  Created by Jason Hoffman on 7/28/21.
//

import SwiftUI

public struct LineView: View {
    public var data: [Double]
    public var style: LineChartStyle
    
    
    @Binding var indexPosition: Int
    @State var IndicatorPointPosition: CGPoint = .zero
    @State var pathPoints = [CGPoint]()
    
    public var body: some View {
        ZStack {
            GeometryReader { proxy in
                LinePath(data: data, width: proxy.size.width, height: proxy.size.height, pathPoints: $pathPoints)
                    .stroke(Color.blue, lineWidth: 2)
            }
        }
        .rotationEffect(.degrees(180), anchor: .center)
        .rotation3DEffect(.degrees(180), axis: (x: 0.0, y: 1.0, z: 0.0))
    }
}

//
//  LineView.swift
//  PowerCompare
//
//  Created by Jason Hoffman on 7/28/21.
//

import SwiftUI

struct LineView: View {
    @State var on = true
    
    var sampleData: [CGFloat] =  [292.63,60.22,380.29,316.34,310.03,231.59,131.73,363.84,534.23,313.73,270.08,105.34,242.46,326.5,262,306.39,515.98,97.89,420.8,106.59,400.37,155.4,336.36,292.94,242.91,371.93,324.57,190.68,500.27,61.12,298.28,242.45,590.78,518.66,397.8,307.95,103.7,208.8,303.23,277.45,58.18,148.89,372.31,597.21,273.47,180.7,278.59,453.3,317.3,347.85,104,367.12,476.37,477.24,156.92,299.34,283.2,190.66,454.62,317.96,442.87,406.4,320.93,175.33,224.67,421.54,300.58,398.83,320.72,346.89,444.28,293.32,215.52,239.9,339.09,504.43,218.18,61.56,93.72,573.34,554.43,358.77,324.34,181.97,326.92,316.58,247.99,411.5,374.12,277.1,383.52,89.94,409.06,317.99,332.24,366.6,547.62,343.62,218.51,432.47]
    
    var body: some View {

        // Round up to max value to create graph?
        GeometryReader { r in
            ZStack {
                ForEach(0..<10) { line in
                    Group {
                        Path { path in
                            let lf = CGFloat(line)
                            let y = CGFloat(r.size.height) * (lf / 10.0)
                            print(r.size.height)
                            print(line)
                            print(y)
                            path.move(to: CGPoint(x: 0, y: y))
                            path.addLine(to: CGPoint(x: r.size.width, y: y))
                        }.stroke(Color.gray)
                    }
                }
            
                
                VStack {
                    LineGraph(dataPoints: normalize(sampleData))
                        .trim(to: on ? 1 : 0)
                        .stroke(Color.red, lineWidth: 2)
                        .aspectRatio(16/9, contentMode: .fill)
                        .border(Color.gray, width: 1)
                    Button("Animate") {
                        withAnimation(.easeInOut(duration: 2)) {
                            self.on.toggle()
                        }
                    }
                }
            }
        }
    }
    
    public func normalize(_ data: [CGFloat]) -> [CGFloat] {
        var normalData = [CGFloat]()
        let min = data.min()!
        let max = data.max()!
        
        for value in data {
            let normal = (value - min) / (max - min)
            normalData.append(normal)
        }
        
        return normalData
    }
}

struct LineView_Previews: PreviewProvider {
    static var previews: some View {
        LineView() 
    }
}

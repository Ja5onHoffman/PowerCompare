//
//  AverageGauge.swift
//  PowerCompare
//
//  Created by Jason Hoffman on 1/26/22.
//

import SwiftUI
import GaugeProgressViewStyle

struct AverageGauge: View {
    
    @State var value: Double = 0.5
    var averageGradient: Gradient = Gradient(colors: [.red, .yellow, .green, .yellow, .red])
    
    var body: some View {
        ProgressView(value: value)
            .progressViewStyle(.gauge(shape: .angularGradient(averageGradient, center: .center, startAngle: .angularGradientGaugeStart, endAngle: .angularGradientGaugeEnd), thickness: 10.0))
    }
}

//struct AverageGauge: View {
//
//    @State private var endAngle = Angle(degrees: 271.0)
//    @State private var clockwise: Bool = false
//
////    static func rightAnimation() -> Animation {
////
////    }
////
////    static func rotate(_ start: Angle, _end: Angle) -> Animation {
////
////    }
//
//
//    var body: some View {
//        VStack {
//            Arc(startAngle: .degrees(270), endAngle: endAngle,
//                clockwise: clockwise)
//                .stroke(.red, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
//                .frame(width: 100, height: 100)
////                .onTapGesture {
////                    withAnimation(Animation.easeIn(duration: 0.5)) {
////                        endAngle = Angle(degrees: Double.random(in: 180...360))
////                    }
////                }
//
//            Button {
//                let index = Double.random(in: 0.6666666...1.33333333)
//                let newAngle = Angle(degrees: 270 * index)
//                if newAngle.degrees < 270 && endAngle.degrees > 270 {
//                    withAnimation {
//                    }
//                } else if newAngle.degrees > 270 && endAngle.degrees < 270 {
//                    withAnimation {
//                        endAngle = Angle(degrees: 0)
//                        clockwise = true
//                        endAngle = newAngle
//                    }
//                } else {
//                    withAnimation {
//                        endAngle = newAngle
//                    }
//                }
//            } label: {
//                Text("New Data")
//            }
//            Text("\(endAngle.degrees)")
//        }
//    }
//}


//struct AverageGauge: View {
//
//    @State var gaugeValue: Double = 1.0 // now in values -1 (-45°) to +1 (+45°)
//
//    var body: some View {
//        VStack {
//            let fraction: CGFloat = abs(gaugeValue) * 0.25
//            let rotation = gaugeValue < 0 ? (gaugeValue * 90) - 90 : -90
//            Circle()
//                .trim(from: 0, to: fraction )
//                .rotation(Angle(degrees: rotation), anchor: .center)
//
//                .stroke(.red, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
//                .frame(width: 100, height: 100)
//
//
//            // Tap gesture simulates changing data
//            Button {
//                let newGaugeValue = CGFloat.random(in: -1 ... 1)
//
//                if newGaugeValue * gaugeValue < 0 { // if change of +/-
//                    withAnimation(Animation.easeOut(duration: 1.0)) {
//                        gaugeValue = 0
//                    }
//                    // delay for reaching 0 point
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//                        withAnimation(Animation.easeIn(duration: 1.0)) {
//                            gaugeValue = newGaugeValue
//                        }
//                    }
//                } else { // no change of +/-
//                    withAnimation(Animation.easeIn(duration: 1.0)) {
//                        gaugeValue = newGaugeValue
//                    }
//                }
//            } label: {
//                Text("New Data")
//            }
//
//            Text("\(gaugeValue)")
//        }
//    }
//}


struct Arc: Shape {
    
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool
    
//    var startAngleAnimatable: Angle {
//        get { startAngle }
//        set {startAngle = Angle(degrees: 270.0) }
//    }
    
    var animatableData: Angle {
        get { endAngle }
        set { endAngle = newValue }
    }
    
//    var clockwiseAnimatable: Bool {
//        get { clockwise }
//        set { clockwise = newValue }
//    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)

        return path
    }
}

extension Angle: VectorArithmetic {
    
    public static var zero = Angle(degrees: 0.0)
    
    public static func + (lhs: Angle, rhs: Angle) -> Angle {
        Angle(degrees: lhs.degrees + rhs.degrees)
    }
    
    public static func - (lhs: Angle, rhs: Angle) -> Angle {
        Angle(degrees: lhs.degrees - rhs.degrees)
    }
    
    public static func += (lhs: inout Angle, rhs: Angle) {
        lhs = Angle(degrees: lhs.degrees + rhs.degrees)
    }
    
    public static func -= (lhs: inout Angle, rhs: Angle) {
        lhs = Angle(degrees: lhs.degrees - rhs.degrees)
    }
    
    public mutating func scale(by rhs: Double) {
        self.degrees = self.degrees * rhs
    }
    
    public var magnitudeSquared: Double {
        get { 0.0 }
    }
}


struct AverageGauge_Previews: PreviewProvider {
    static var previews: some View {
        AverageGauge(value: 0.5)
    }
}



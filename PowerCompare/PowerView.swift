//
//  PowerView.swift
//  PowerCompare
//
//  Created by Jason Hoffman on 7/28/21.
//

import SwiftUI
import CoreBluetooth

let powerMeterCBUUID = CBUUID(string: "0x1818")
let powerMeasurementCharacteristicCBUUID = CBUUID(string: "0x2A63")


struct PowerView: View {
    
    let style = LineChartStyle(
        labelColor: .blue,
        indicatorPointColor: .blue,
        showingIndicatorLineColor: .blue,
        flatTrendLineColor: .blue,
        uptrendLineColor: .blue,
        downtrendLineColor: .blue)
    
    let sampleData: [Double] = [500.0, 200.0, 200.0, 600.0, 800.0, 100.0, 200.0, 300.0, 200.0]
    
    @EnvironmentObject var bt: Bluetooth
//    @State var data: PowerData
    @State var showModal = true
    @State var showList = false 
    
    // placeholder
    @State var deviceConnected = false
    
    var body: some View {
            VStack {
                
                if deviceConnected {
                    HStack {
                        Spacer()
                        Button(action: {}, label: {
                            Text("Disconnect")
                                .bold()
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20.0))
                        })
                    }
                } else {
                    Spacer()
                }
                
                VStack {
                    RoundedRectangle(cornerRadius: 50)
                                        .fill(Color.blue)
                        .padding()
                    RoundedRectangle(cornerRadius: 50)
                                        .fill(Color.green)
                        .padding()
                }
                
                Spacer()
                LineChartView(data: sampleData, style: style)
                LineChartView(data: sampleData.reversed(), style: style)
            }.fullScreenCover(isPresented: $showModal, content: {
                WelcomeModal(showingModal: $showModal)
            })
        

    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PowerView()
            .environmentObject(Bluetooth())
//            .environmentObject(PowerData())
    }
}


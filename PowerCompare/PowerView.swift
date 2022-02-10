//
//  PowerView.swift
//  PowerCompare
//
//  Created by Jason Hoffman on 12/16/21.
//

import SwiftUI
import CoreBluetooth

struct PowerView: View {
    
    @EnvironmentObject var bt: Bluetooth
    @State var showModal = false
    @State var showList = false
    
    // placeholder
    @State var deviceConnected = false
    
    let sampleData1: [Double] = [500.0, 200.0, 200.0, 600.0, 800.0, 100.0, 200.0, 300.0, 200.0]
    
    private var columns: [GridItem] = [
        GridItem(.adaptive(minimum: 100.0, maximum: 300.0), spacing: 16, alignment: .center),
        GridItem(.adaptive(minimum: 100.0, maximum: 300.0), spacing: 16, alignment: .center),
        GridItem(.adaptive(minimum: 100.0, maximum: 300.0), spacing: 16, alignment: .center)

    ]
    
    func normalizeAverage(averageDif: Double, leftAverage: Double, rightAverage: Double) -> Double {
        
        let data = [leftAverage, rightAverage]
        var normalized: Double
        let min = data.min()!
        let max = data.max()!
        let dif = max - min
        
        normalized = (averageDif - min) / dif
        return normalized
        
        
    }
    
    var body: some View {

        VStack {
            HStack(alignment: .lastTextBaseline) {
                Text("WattBae")
                    .frameSize()
                    .modifier(AvenirHeading())
                Spacer()
                // If not connected, show connect devices button
                if !deviceConnected {
                    Button("Connect Devices") {
                        self.showList.toggle()
                    }.sheet(isPresented: $showList, onDismiss: {
                        self.$showList.wrappedValue = false
                    }, content: {
                        DeviceListView(isPresented: $showList)
                    }).buttonStyle(ConnectDevices(connected: $deviceConnected.wrappedValue))
                } else {
                    Button("Stop") {
                        self.showList.toggle()
//                        bt.disconnectAll()
                    }
                    .sheet(isPresented: $showList, onDismiss: {
                        self.$showList.wrappedValue = false
                    }, content: {
                        DeviceListView(isPresented: $showList)
                    }).buttonStyle(ConnectDevices(connected: deviceConnected))
                }
            }.padding(EdgeInsets(top: 16.0, leading: 8.0, bottom: 0.0, trailing: 16.0))
            
                VStack {
                    VStack {
                        HStack(alignment: .center) {
                            Text("Device 1")
                                .modifier(AvenirTitle())
                            Spacer()
                            Text("Device 2")
                                .modifier(AvenirTitle())
                        }
                        HStack(alignment: .center, spacing: 8.0) {
                            VStack(alignment: .center, spacing: 16.0) {
                                DataView(title: "Current", data: bt.p1Power.watts)
                                DataView(title: "Average", data: bt.p1Values.average)
                            }
                            VStack {
                                DataView(title: "Difference", data: bt.instantDifference)
                                // Need to unwrap
                                AverageGauge(value: bt.normalizedAvgs.last!)
                            }
                            VStack(alignment: .center, spacing: 16.0) {
                                DataView(title: "Current", data: bt.p2Power.watts)
                                DataView(title: "Average", data: bt.p2Values.average)
                            }
                        }.frameSize()
                    }
                    
                    ChartsPowerGraph(
                        powerData1: bt.p1Values.chartsPower,
                        powerData2: bt.p2Values.chartsPower
                    ).aspectRatio(1.0, contentMode: .fill)
                        .padding(EdgeInsets(top: 0.0, leading: 8.0, bottom: 8.0, trailing: 8.0))
                        .frameSize()
                }
        }.fullScreenCover(isPresented: $showModal, content: {
            WelcomeModal(showingModal: $showModal)
        })
        
    }
}

struct ConnectDevices: ButtonStyle {
    @State var connected: Bool
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(8.0)
            .background($connected.wrappedValue ? Color.red : Color.blue)
            .clipShape(Capsule())
            .foregroundColor(.white)
    }
}


struct PowerView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PowerView()
                .environmentObject(Bluetooth())
                .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro"))
                .previewDisplayName("iPhone 12 Pro")
//            PowerView()
//                .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
//                .previewDisplayName("iPhone 12 Pro Max")
//
//            PowerView()
//                .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro Max"))
//                .previewDisplayName("iPhone 13 Pro Max")
        }
    }
}

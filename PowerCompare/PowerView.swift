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
    
    let sampleData: [Double] = [500.0, 200.0, 200.0, 600.0, 800.0, 100.0, 200.0, 300.0, 200.0]
    
    @EnvironmentObject var bt: Bluetooth
//    @State var data: PowerData
    @State var showModal = true
    @State var showList = false
    var deviceOne = ""
    var deviceTwo = ""
    
    // placeholder
    @State var deviceConnected = false
    
    var body: some View {
        
        
            VStack {
                if deviceConnected {
                    HStack {
                        Spacer()
                        Button("Disconnect") {
                            self.showList.toggle()
                            bt.disconnectAll()
                        }
                        .sheet(isPresented: $showList, onDismiss: {
                            self.$showList.wrappedValue = false
                        }, content: {
                            DeviceListView(isPresented: $showList)
                        }).padding()
                        .font(.bold(.body)())
                    }
                } else {
                    Spacer()
                    HStack {
                        Spacer()
                        Button("Connect Devices") {
                            self.showList.toggle()
                        }
                        .sheet(isPresented: $showList, onDismiss: {
                            self.$showList.wrappedValue = false
                        }, content: {
                            DeviceListView(isPresented: $showList)
                        }).padding()
                    }
                }
                
                HStack {
                    Text(bt.p1Name!)
                        .padding()
                    Spacer()
                }
                
                Text(String(describing: bt.$p1Power))
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .background(RoundedRectangle(cornerRadius: 50)
                                .fill(Color.blue))
                    .padding()
//                RoundedRectangle(cornerRadius: 50)
//                    .fill(Color.blue)
//                    .padding()
                LineView()
//                LineChartView(data: sampleData, style: style)
                HStack {
                    Text(bt.p2Name!)
                        .padding()
                    Spacer()
                }
                Text(String(describing: bt.$p2Power))
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .background(RoundedRectangle(cornerRadius: 50)
                                    .fill(Color.green))
                    .padding()
                LineView()
//                LineChartView(data: sampleData.reversed(), style: style)
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


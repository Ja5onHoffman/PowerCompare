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
    @State var showModal = false
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
                        })
                        .font(.bold(.body)())
                    }
                } else {
                    HStack {
                        Spacer()
                        if bt.deviceConnected {
                            Button("Disconnect") {
                                self.showList.toggle()
                                bt.disconnectAll()
                            }
                            .sheet(isPresented: $showList, onDismiss: {
                                self.$showList.wrappedValue = false
                            }, content: {
                                DeviceListView(isPresented: $showList)
                            }).padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10.0))
                        } else {
                            Button("Connect Devices") {
                                self.showList.toggle()
                            }
                            .sheet(isPresented: $showList, onDismiss: {
                                self.$showList.wrappedValue = false
                            }, content: {
                                DeviceListView(isPresented: $showList)
                            }).padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10.0))
                        }
                    }
                }
            
            VStack {
                VStack {
                    HStack {
                        Text(bt.p1Name!)
                            .font(.title2)
                            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                        Spacer()
                    }
//                    Text(String(describing: bt.hrInstant1))
                    Text(String(describing: bt.p1Power.value))
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(RoundedRectangle(cornerRadius: 50)
                                    .fill(Color.blue))

                }
                
                VStack {
                    HStack {
                        Text(bt.p2Name!)
                            .font(.title2)
                            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                        Spacer()
                    }
                    Text(String(describing: bt.p2Power.value))
//                    Text(String(describing: bt.hrInstant2))
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity, minHeight: 60)
                        .background(RoundedRectangle(cornerRadius: 50)
                                        .fill(Color.green))
//                    ChartsPowerView()
//                        .aspectRatio(1.5, contentMode: .fill)
//                    LineView()
//                        .aspectRatio(1.5, contentMode: .fit)
                }.padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                
                HStack {
                    Text("Difference")
                        .font(.title)
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                }
                Text(String(describing: bt.powerDif().0))
                    .foregroundColor(.white)
                    .font(.system(size: 50))
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity, minHeight: 200
                    )
                    .background(RoundedRectangle(cornerRadius: 50)
                                    .fill(bt.powerDif().1))
            }
    
            }.fullScreenCover(isPresented: $showModal, content: {
                WelcomeModal(showingModal: $showModal)
            })
        

    }
    
    func connectButtonAction() {
        self.showList.toggle()
        self.sheet(isPresented: $showList, onDismiss: {
                    self.$showList.wrappedValue = false
                }, content: {
                    DeviceListView(isPresented: $showList)
                })
    }
    
//    Button("Connect Devices") {
//        self.showList.toggle()
//    }
//    .sheet(isPresented: $showList, onDismiss: {
//        self.$showList.wrappedValue = false
//    }, content: {
//        DeviceListView(isPresented: $showList)
//    }).padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10.0))
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PowerView()
            .environmentObject(Bluetooth())
//            .environmentObject(PowerData())
    }
}


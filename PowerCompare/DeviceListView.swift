//
//  DeviceList.swift
//  WahooCompare
//
//  Created by Jason Hoffman on 7/20/20.
//  Copyright © 2020 Jason Hoffman. All rights reserved.
//

import SwiftUI
import Combine
import class CoreBluetooth.CBPeripheral

extension View {
    func print(_ value: Any) -> Self {
        Swift.print(value)
        return self
    }
}

struct DeviceListView: View {
    
//    @State var selected: UUID?
    @Binding var isPresented: Bool
    @EnvironmentObject var bt: Bluetooth
    
//    func connectToPeripheralWithName(_ name: String) {
//        for i in bt.peripherals {
//            if i.name == name {
//                if bt.deviceNumber == 1 {
//                    bt.p1Name = name
//                } else if bt.deviceNumber == 2 {
//                    bt.p2Name = name
//                }
//                bt.connectTo(i)
//                bt.addPeripheral(i)
////                self.isPresented = false
//            }
//        }
//    }
    
    // This ends up connecting both
    func connectToPeripheralWithName(_ device: Device) {
        for i in bt.peripherals {
            if i.name == device.name {
                bt.connectTo(i)
//                bt.addPeripheral(i)
            }
        }
    }
    
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Connect Two Devices")) {
                    // Infinite loop here
                    ForEach(Array(self.bt.deviceList)) { d in
                        DeviceRow(device: d, connectToPeripheralWithName: connectToPeripheralWithName(_:))
                    }
                }
            }
            .navigationTitle(Text("Devices"))
            .toolbar {
                Button(action: {
                    self.isPresented = false
                }, label: {
                    listButtonText
                })
            }
        }.onAppear(perform: {
            self.bt.scan()
        })
    }
    
    private var listButtonText: Text {
        if bt.twoConnected() {
            return Text("Done").fontWeight(.bold)
        } else {
            return Text("Cancel")
        }
    }
}

struct ConnectionButton: ButtonStyle {
    @State var device: Device
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            // I want the button to change based on the connection status of the device
            .background($device.connected.wrappedValue ? Color.red : Color.blue)
            .clipShape(Capsule())
            .foregroundColor(.white)
    }
}

struct DeviceRow: View {
    @State var device: Device
    let connectToPeripheralWithName: (_ name: Device) -> Void
    @EnvironmentObject var bt: Bluetooth
    
    var body: some View {
        HStack {
            Text(device.name)
            Spacer()
            Button(action: {
                buttonAction
            }, label: {
                buttonText
            }).buttonStyle(ConnectionButton(device: device))
        }

    }
    
    // Computed properties for the purpose of changing the button
    private var buttonText: Text {
        if $device.connected.wrappedValue {
            return Text("Disconnect").fontWeight(.heavy)
        } else {
            return Text("Connect").fontWeight(.heavy)
        }
    }
    
    private var buttonAction: Void {
        if $device.connected.wrappedValue {
            return disconnect(device.name)
        } else {
            return connectToPeripheralWithName(device)
        }
    }
    
    func disconnect(_ name: String) {
        for i in bt.peripherals {
            if name == i.name {
                bt.disconnect(i)
            }
        }
    }
}


struct DeviceList_Previews: PreviewProvider {
    static var previews: some View {
        return DeviceListView(isPresented: .constant(true))
            .environmentObject(Bluetooth())
    }
}

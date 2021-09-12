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
    
    func connectToPeripheralWithName(_ device: Device) {
        for i in bt.peripherals {
            if i.name == device.name {
                bt.connectTo(i)
                bt.addPeripheral(i)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Device List")) {
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
                    Text("Cancel")
                        .fontWeight(.heavy)
                })
            }
        }.onAppear(perform: {
            self.bt.scan()
        })
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
    
    // Not used
    private var isConnected: Bool {
        if $device.connected.wrappedValue {
            return true
        } else { return false }
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
        print(name)
        return
    }
    
//    private var title: String {
//        switch state {
//        case .loggedIn(let user):
//            return "Welcome back, \(user.name)!"
//        case .loggedOut:
//            return "Not logged in"
//        }
//    }
//
//    private var buttonText: String {
//        switch state {
//        case .loggedIn:
//            return "Log out"
//        case .loggedOut:
//            return "Log in"
//        }
//    }
}


struct DeviceList_Previews: PreviewProvider {
    static var previews: some View {
        return DeviceListView(isPresented: .constant(true))
            .environmentObject(Bluetooth())
    }
}

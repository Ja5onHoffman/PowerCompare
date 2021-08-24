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


struct DeviceListView: View {
    
//    @State var selected: UUID?
    @Binding var isPresented: Bool
//    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var bt: Bluetooth
    
    
    func connectToPeripheralWithName(_ name: String) {
        for i in bt.peripherals {
            if i.name == name {
                if bt.deviceNumber == 1 {
                    bt.p1Name = name
                } else if bt.deviceNumber == 2 {
                    bt.p2Name = name
                }
                bt.connectTo(i)
                bt.addPeripheral(i)
                self.isPresented = false 
            }
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Device List")) {
                    ForEach(self.bt.deviceList) { d in
                        DeviceRow(device: d, connectToPeripheralWithName: connectToPeripheralWithName(_:))
                    }
                }
            }
            .navigationTitle(Text("Devices"))
            .toolbar {
                // Each row will have a disconnect button instead
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
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.blue)
            .clipShape(Capsule())
            .foregroundColor(.white)
    }
}

struct DeviceRow: View {
    let device: Bluetooth.Device
    let connectToPeripheralWithName: (_ name: String) -> Void
    
    var body: some View {
        HStack {
            Text(device.name)
            Spacer()
            Button(action: {
                connectToPeripheralWithName(device.name)
                
            }, label: {
                Text("Connect")
                    .fontWeight(.heavy)
            }).buttonStyle(ConnectionButton())
        }

    }
}


struct DeviceList_Previews: PreviewProvider {
    static var previews: some View {
        return DeviceListView(isPresented: .constant(true))
            .environmentObject(Bluetooth())
    }
}

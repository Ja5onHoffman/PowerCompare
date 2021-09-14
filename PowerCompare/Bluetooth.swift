//
//  Bluetooth.swift
//  WahooCompare
//
//  Created by Jason Hoffman on 7/13/20.
//  Copyright © 2020 Jason Hoffman. All rights reserved.
//

import SwiftUI
import CoreBluetooth


open class Bluetooth: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate, ObservableObject {
    
    @EnvironmentObject var bt: Bluetooth
    
    @Published var names = [String]()
    @Published var peripherals = [CBPeripheral]()
    @Published var deviceList = Set<Device>()
    @Published var deviceNames = Set<Device>()
    
//    @Published var deviceList = [Device(name: "Wahoo Kickr"), Device(name: "Favero Assioma")]
    
    var centralManager: CBCentralManager!
    let powerMeterServiceCBUUID = CBUUID(string: "0x1818")
    let powerMeasurementCharacteristicCBUUID = CBUUID(string: "0x2A63")
    let wattUnitCBUUID = CBUUID(string: "0x2762")
    var deviceNumber = 0
    
    // HR for testing
    let heartRateCharacteristicCBUUID = CBUUID(string: "0x2A37")
    let heartRateServcieSCBUUID = CBUUID(string: "0x180D")
    
    @Published var p1: CBPeripheral? = nil
    @Published var p2: CBPeripheral? = nil 

    @Published var p1Values = PowerArray(size: 100)
    @Published var p2Values = PowerArray(size: 100)
    
    @Published var hrValues = [Int]()
    @Published var hrInstant = 0
    
    @Published var p1Power = PowerData(value: 0)
    @Published var p2Power = PowerData(value: 0)
    
    @Published var p1Name: String? = "Awaiting Connection"
    @Published var p2Name: String? = "Awaiting Connection"
    
    var devicesConnected = 0
    var deviceConnected = false

    public override init() {
        super.init()
        self.createCentralManager()
    }
    
    func createCentralManager() {
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    func scan() {
        if centralManager.state == .poweredOn && !centralManager.isScanning {
//                centralManager.scanForPeripherals(withServices: [powerMeterServiceCBUUID], options: nil)
            centralManager.scanForPeripherals(withServices: [heartRateServcieSCBUUID], options: nil)
        } else {
            print("Bluetooth is off")
        }
    }

    func stopScan() {
//        deviceList.removeAll()
//        peripherals.removeAll()
        centralManager.stopScan()
    }
    
    func powerDif() -> (Double, Color) {
        let d = p1Power.value - p2Power.value
        if d > 0 {
            return (d, .green)
        } else {
            return (d, .red)
        }
    }
    
    func twoConnected() -> Bool {
        if p1?.state == .connected && p2?.state == .connected {
            return true
        } else {
            return false
        }
    }
    
    func connectTo(_ peripheral: CBPeripheral) {
        for i in deviceList {
            if i.name == peripheral.name {
                i.connected = true
            }
        }
        peripheral.delegate = self
        centralManager.connect(peripheral, options: nil)
        if p1 == nil {
            p1 = peripheral
            p1Name = peripheral.name
        } else {
            p2 = peripheral
            p2Name = peripheral.name
        }
    }
    
    func disconnect(_ peripheral: CBPeripheral) {
        centralManager.cancelPeripheralConnection(peripheral)
    }
    
    func disconnectAll() {
        for p in peripherals {
            centralManager.cancelPeripheralConnection(p)
        }
        deviceConnected = false
    }
    
    func setDeviceNumber(_ number: Int) {
        self.deviceNumber = number
    }
    
//MARK: CBCentralManagerDelegate
        
    public func centralManagerDidUpdateState(_ central: CBCentralManager) {
            print("Update state")
            switch central.state {
              case .unknown:
                print("central.state is .unknown")
              case .resetting:
                print("central.state is .resetting")
              case .unsupported:
                print("central.state is .unsupported")
              case .unauthorized:
                print("central.state is .unauthorized")
              case .poweredOff:
                print("central.state is .poweredOff")
              case .poweredOn:
                print("central.state is .poweredOn")
            @unknown default:
                print("error")
            }
        }
    
    public func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        peripherals.append(peripheral) // Device list uses this
        if let name = peripheral.name {
            deviceList.insert(Device(name: name))
        }
    }
    
    public func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("Connected!")
        deviceConnected = true
        peripheral.discoverServices(nil)
    }

    
//MARK: CBPeripheralDelegate
    
    public func centralManager(_ central: CBCentralManager, connectionEventDidOccur event: CBConnectionEvent, for peripheral: CBPeripheral) {
        if p1 == nil {
            p1 = peripheral
            p1Name = peripheral.name
            p1!.delegate = self
            print("P1")
        } else {
            p2 = peripheral
            p2Name = peripheral.name
            p2!.delegate = self
            print("P2")
        }
    }
    
    public func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
      guard let services = peripheral.services else { return }

      for service in services {
        print(service)
        peripheral.discoverCharacteristics(nil, for: service)
      }
    }
    
    public func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let characteristics = service.characteristics else { return }
        
        for characteristic in characteristics {
          print(characteristic)
          if characteristic.properties.contains(.read) {
            print("\(characteristic.uuid): properties contains .read")
            peripheral.readValue(for: characteristic)

          }
          if characteristic.properties.contains(.notify) {
            print("\(characteristic.uuid): properties contains .notify")
                  peripheral.setNotifyValue(true, for: characteristic)
          }
        }
    }
    
    public func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {

        switch characteristic.uuid {
        case powerMeasurementCharacteristicCBUUID:
            if peripheral.name == p1Name {
                p1Power = powerMeasurement(from: characteristic)
                p1Values.addValue(p1Power)
            } else if peripheral.name == p2Name {
                p2Power = powerMeasurement(from: characteristic)
                p2Values.addValue(p2Power)
            }
        // For testing w HR
        case heartRateCharacteristicCBUUID:
            let char = [UInt8](characteristic.value!)
            hrValues.append(Int(char[1]))
            hrInstant = Int(char[1])
        default:
            print("Unhandled Characteristic UUID: \(characteristic.uuid)")
        }
        
    }
    
    
    func powerMeasurement(from characteristic: CBCharacteristic) -> PowerData {

        guard let characteristicData = characteristic.value else { return PowerData(value: 0) }
        let byteArray = [UInt8](characteristicData)
        
        // Power comes through in two bytes
        // Above 256 combine to get power
        let msb = byteArray[3]
        let lsb = byteArray[2]
        let pRaw = (Int16(msb) << 8 ) | Int16(lsb)
        let p = PowerData(value: Double(pRaw))
        return p
    }
    
    public func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        if let p = peripherals.firstIndex(of: peripheral) {
            // Don't necessarily want to remove
//            peripherals.remove(at: p)
            for i in deviceList {
                if i.name == peripheral.name {
                    i.connected = false
//                    deviceList.remove(i)
                }
            }
        }

    }

}

// Changed to class for Observable
class Device: Identifiable, Hashable, ObservableObject {
    
    let id = UUID()
    let name: String
    @Published var connected: Bool
    
    init(name: String, connected: Bool = false) {
        self.name = name
        self.connected = connected
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Device, rhs: Device) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }
}

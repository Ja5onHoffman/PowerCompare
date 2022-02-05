//
//  PowerCompareApp.swift
//  PowerCompare
//
//  Created by Jason Hoffman on 7/28/21.
//

import SwiftUI

@main
struct PowerCompareApp: App {
    @StateObject var bt = Bluetooth()
    
    var body: some Scene {
        WindowGroup {
            PowerView()
                .environmentObject(bt)
        }
    }
}

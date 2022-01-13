//
//  ConnectButton.swift
//  PowerCompare
//
//  Created by Jason Hoffman on 12/27/21.
//

import SwiftUI


struct Connectbutton: View {
    var function: () -> Void

    var body: some View {
        Button {
            self.function()
        } label: {
            Text("Connect Devices")
        }
    }
}


//struct ChildView: View {
//    var function: () -> Void
//
//    var body: some View {
//        Button(action: {
//            self.function()
//        }, label: {
//            Text("Button")
//        })
//    }
//}
//
//struct ParentView: View {
//    var body: some View {
//        ChildView(function: self.passedFunction)
//    }
//
//    func passedFunction() {
//        print("I am the parent")
//    }
//}

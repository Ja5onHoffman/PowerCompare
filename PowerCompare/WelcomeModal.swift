//
//  WelcomeModal.swift
//  PowerCompare
//
//  Created by Jason Hoffman on 7/29/21.
//

import SwiftUI


// Maybe make this a connection modal 
struct WelcomeModal: View {
    @EnvironmentObject var bt: Bluetooth
    @Binding var showingModal: Bool
    @State private var showingList = false
    
    var body: some View {
        ZStack {
            if $showingModal.wrappedValue {
                ZStack {
                    BackgroundBlurView().edgesIgnoringSafeArea(.vertical)
                    VStack(spacing: 10) {
                        Text("Welcome to WattBae")
                            .bold().padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.orange)
                            .foregroundColor(Color.white)
                        Spacer()
                        Text("To use the app, activate your devices and select two from the list.")
                        Button("View Available Devices") {
                            self.showingList.toggle()
                        }
                        .sheet(isPresented: $showingList, onDismiss: {
                            self.$showingModal.wrappedValue = false
                        }, content: {
                            DeviceListView(isPresented: $showingList).environmentObject(bt)
                        }).padding()
                    }
                    .frame(width: 300, height: 200)
                    .background(Color.white)
                    .cornerRadius(20).shadow(radius: 20)
    
                }
            }
        }
    }
}

// For transparent background effect
struct BackgroundBlurView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}

struct WelcomeModal_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeModal(showingModal: .constant(true))
    }
}

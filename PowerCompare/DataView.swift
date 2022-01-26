//
//  DataView.swift
//  ChartsTest
//
//  Created by Jason Hoffman on 12/19/21.
//

import SwiftUI

struct DataView: View {
    var title = ""
    var data: Double = 0.0
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Text(title).font(.title2)
//            Text(String(describing: data)).modifier(Data())
            Text(String(format: "%.1f W", data)).modifier(Data())
        }.frame(minWidth: 50, idealWidth: 250, maxWidth: 300, minHeight: 50, idealHeight: 250, maxHeight: 300, alignment: .center)
            .frameSize()
    }
}

class DataViewModel: ObservableObject {
    @Published var dataView: DataView
    init (_ dataView: DataView) {
        self.dataView = dataView
    }
}

struct DataView_Previews: PreviewProvider {
    static var previews: some View {
        DataView(title: "Average", data: 200.0)
    }
}

//
//  Modifiers.swift
//  ChartsTest
//
//  Created by Jason Hoffman on 1/7/22.
//

import SwiftUI

struct AvenirHeading: ViewModifier {
    var size: CGFloat = 36
    func body(content: Content) -> some View {
        content
            .font(.custom("AvenirNext-Bold", size: size))
            .padding(EdgeInsets(top: 0.0, leading: 0.0, bottom: 1.0, trailing: 0.0))
    }
}

struct AvenirTitle: ViewModifier {
    var size: CGFloat = 24
    func body(content: Content) -> some View {
        content
            .lineLimit(1)
            .font(.custom("AvenirNext-Regular", size: size))
            .padding(EdgeInsets(top: 0.0, leading: 16.0, bottom: 0.0, trailing: 16.0))
    }
}

struct AvenirDevice: ViewModifier {
    var size: CGFloat = 18
    func body(content: Content) -> some View {
            content
                .lineLimit(1)
                .font(.custom("AvenirNext-Bold", size: size))
                .padding(EdgeInsets(top: 0.0, leading: 8.0, bottom: 0.0, trailing: 8.0))
    }
}

struct DataBlockTitle: ViewModifier {
    var size: CGFloat = 24
    func body(content: Content) -> some View {
        content
            .font(.custom("AvenirNextCondensed-Heavy", size: size))
    }
}

struct Data: ViewModifier {
    var size: CGFloat = 24
    func body(content: Content) -> some View {
        content
            .font(.custom("digital-7", size: 24))
    }
}


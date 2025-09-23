//
//  ContentView.swift
//  Calculator
//
//  Created by Shaquille O Neil on 2025-09-18.
//

import SwiftUI

//M - V - C

struct ContentView: View {
    var body: some View {
        ZStack {
            //gradient
            LinearGradient(gradient: Gradient(colors:[.pink.opacity(0.5),.blue.opacity(0.5)]),
                           startPoint: .top,
                           endPoint: UnitPoint.bottom)
            .ignoresSafeArea()
         KeysView()
        }
       
    }
}

#Preview {
    ContentView()
}

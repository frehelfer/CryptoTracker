//
//  ContentView.swift
//  CryptoTracker
//
//  Created by Frédéric Helfer on 16/11/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            
            VStack(spacing: 40) {
                Text("AccentColor")
                    .foregroundColor(.theme.accent)
                
                Text("SecondaryColor")
                    .foregroundColor(.theme.secondaryText)
                
                Text("Red")
                    .foregroundColor(.theme.red)
                
                Text("Green")
                    .foregroundColor(.theme.green)
            }
            .font(.headline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

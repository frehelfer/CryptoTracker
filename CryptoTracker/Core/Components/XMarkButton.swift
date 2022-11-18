//
//  XMarkButton.swift
//  CryptoTracker
//
//  Created by Frédéric Helfer on 18/11/22.
//

import SwiftUI

struct XMarkLabel: View {
    
    var body: some View {
        Label("Back", systemImage: "xmark")
            .font(.headline)
    }
}

struct XMarkLabel_Previews: PreviewProvider {
    static var previews: some View {
        XMarkLabel()
    }
}

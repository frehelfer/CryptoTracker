//
//  DetailView.swift
//  CryptoTracker
//
//  Created by Frédéric Helfer on 24/11/22.
//

import SwiftUI

struct DetailView: View {
    
    @StateObject var vm: DetailViewModel
    
    init(coin: Coin) {
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
    }
    
    var body: some View {
        Text("")
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(coin: dev.coin)
    }
}

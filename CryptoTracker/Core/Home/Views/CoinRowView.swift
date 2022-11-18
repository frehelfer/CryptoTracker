//
//  CoinCoreView.swift
//  CryptoTracker
//
//  Created by Frédéric Helfer on 16/11/22.
//

import SwiftUI

struct CoinRowView: View {
    
    let coin: Coin
    let showHoldingsColumn: Bool
    
    var body: some View {
        HStack(spacing: 0) {
            
            // Left Column
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundColor(.theme.secondaryText)
                .frame(minWidth: 30)
            CoinImageView(coin: coin)
                .frame(width: 30, height: 30)
            VStack(alignment: .leading) {
                Text(coin.symbol.uppercased())
                    .font(.headline)
                    .foregroundColor(.theme.accent)
                Text(coin.name)
                    .font(.caption)
                    .foregroundColor(.theme.secondaryText)
            }
            .padding(.leading, 15)
            
            Spacer()
            
            // Center Column
            if showHoldingsColumn {
                VStack(alignment: .trailing) {
                    Text(coin.currentHoldingsValue.asCurrencyWithDecimals(2))
                        .bold()
                    Text((coin.currentHoldings ?? 0).asNumberString())
                }
                .foregroundColor(.theme.accent)
            }
        
            // Right Column
            VStack(alignment: .trailing) {
                Text(coin.currentPrice.asCurrencyWithDecimals(6))
                    .bold()
                    .foregroundColor(.theme.accent)
                
                Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
                    .foregroundColor(
                        (coin.priceChangePercentage24H ?? 0) >= 0
                        ? .theme.green
                        : .theme.red
                    )
            }
            .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
            
        }
        .font(.subheadline)
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        CoinRowView(coin: dev.coin, showHoldingsColumn: true)
            .previewLayout(.sizeThatFits)
    }
}

//extension CoinRowView {
//    private var leftColumn: some View {
//        ...
//
//    }
//}

//
//  DetailViewModel.swift
//  CryptoTracker
//
//  Created by Frédéric Helfer on 24/11/22.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    
    private let coinDetailService: CoinDetailDataService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: Coin) {
        self.coinDetailService = CoinDetailDataService(coin: coin)
    }
    
    private func addSubscribers() {
        
        coinDetailService.$coinDetails
            .sink { returnedCoinDetails in
                print("Received coni detial data")
                print(returnedCoinDetails)
            }
            .store(in: &cancellables)
    }
}

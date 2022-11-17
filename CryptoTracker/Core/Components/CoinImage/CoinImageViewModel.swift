//
//  CoinImageViewModel.swift
//  CryptoTracker
//
//  Created by Frédéric Helfer on 16/11/22.
//

import Foundation
import SwiftUI
import Combine

class CoinImageViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    private let coin: Coin
    private let dataService: CoinImageService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: Coin) {
        self.coin = coin
        self.dataService = CoinImageService(coin: coin)
        self.addSubscribers()
        self.isLoading = true
    }
    
    private func addSubscribers() {
        dataService.$image
            .sink { [weak self] returnedImage in
                self?.image = returnedImage
                self?.isLoading = false
            }
            .store(in: &cancellables)

    }
}

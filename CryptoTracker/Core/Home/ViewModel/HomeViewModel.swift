//
//  HomeViewModel.swift
//  CryptoTracker
//
//  Created by Frédéric Helfer on 16/11/22.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var statistics: [Statistic] = []
    
    @Published var allCoins: [Coin] = []
    @Published var portfolioCoins: [Coin] = []
    
    @Published var searchText: String = ""
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        
        // Updates allCoins
        $searchText
            .combineLatest(coinDataService.$allCoins)
            .debounce(for: .seconds(0.3), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
        
        // Updates marketData
        marketDataService.$marketData
            .map(mapGlobalMarketData)
            .sink { [weak self] returnedStats in
                self?.statistics = returnedStats
            }
            .store(in: &cancellables)
    }
    
    private func filterCoins(text: String, coins: [Coin]) -> [Coin] {
        if text.isEmpty {
            return coins
        } else {
            let lowercasedText = text.lowercased()
            
            return coins.filter { coin -> Bool in
                return coin.name.lowercased().contains(lowercasedText)
                || coin.symbol.lowercased().contains(lowercasedText)
                || coin.id.lowercased().contains(lowercasedText)
            }
        }
    }
    
    private func mapGlobalMarketData(data: MarketData?) -> [Statistic] {
        var stats: [Statistic] = []
        
        guard let data = data else {
            return stats
        }
        
        let marketCap = Statistic(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = Statistic(title: "24h Volume", value: data.volume)
        let btcDominance = Statistic(title: "BTC Dominance", value: data.btcDominance)
        let portfolio = Statistic(title: "Portfolio Value", value: "0.00", percentageChange: 0)
        
        stats.append(contentsOf: [marketCap, volume, btcDominance, portfolio])
        return stats
    }
}

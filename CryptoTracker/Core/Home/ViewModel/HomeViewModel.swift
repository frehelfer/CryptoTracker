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
    @Published var sortOptions: SortOption = .holdings
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    private var cancellables = Set<AnyCancellable>()
    
    enum SortOption {
        case rank, rankReversed, holdings, holdingsReversed, price, priceReversed
    }
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        
        // Updates allCoins
        $searchText
            .combineLatest(coinDataService.$allCoins, $sortOptions)
            .debounce(for: .seconds(0.3), scheduler: DispatchQueue.main)
            .map(filterAndSortCoins)
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
        
        // Updates portfolioCoins
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map(mapAllCoinsToPortfolioCoins)
            .sink { [weak self] returnedCoins in
                guard let self = self else { return }
                self.portfolioCoins = self.sortPortfolioIfNeeded(coins: returnedCoins)
            }
            .store(in: &cancellables)
        
        // Updates marketData
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map(mapGlobalMarketData)
            .sink { [weak self] returnedStats in
                self?.statistics = returnedStats
            }
            .store(in: &cancellables)
    }
    
    func updatePortfolio(coin: Coin, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    func reloadData() {
        coinDataService.getCoins()
        marketDataService.getData()
    }

    private func filterAndSortCoins(text: String, coins: [Coin], sort: SortOption) -> [Coin] {
        var updatedCoins = filterCoins(text: text, coins: coins)
        sortCoins(sort: sort, coins: &updatedCoins)
        return updatedCoins
    }
    
    private func sortCoins(sort: SortOption, coins: inout [Coin]) {
        switch sort {
        case .rank, .holdings:
            coins.sort { $0.rank < $1.rank }
            
        case .rankReversed, .holdingsReversed:
            coins.sort { $0.rank > $1.rank }
            
        case .price:
            coins.sort { $0.currentPrice < $1.currentPrice }
            
        case .priceReversed:
            coins.sort { $0.currentPrice > $1.currentPrice }
        }
    }
    
    private func sortPortfolioIfNeeded(coins: [Coin]) -> [Coin] {
        // will only sort by holdings or reversedHoldings if needed
        switch sortOptions {
        case .holdings:
            return coins.sorted { $0.currentHoldingsValue > $1.currentHoldingsValue }
        case .holdingsReversed:
            return coins.sorted { $0.currentHoldingsValue < $1.currentHoldingsValue }
        default:
            return coins
        }
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
    
    private func mapAllCoinsToPortfolioCoins(allCoins: [Coin], portfoliosEntities: [Portfolio]) -> [Coin] {
        allCoins
            .compactMap { coinModel -> Coin? in
                guard let entity = portfoliosEntities.first(where: { $0.coinID == coinModel.id }) else {
                    return nil
                }
                return coinModel.updateHoldings(amount: entity.amount)
            }
    }
    
    private func mapGlobalMarketData(data: MarketData?, portfolioCoins: [Coin]) -> [Statistic] {
        var stats: [Statistic] = []
        
        guard let data = data else {
            return stats
        }
        
        let marketCap = Statistic(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = Statistic(title: "24h Volume", value: data.volume)
        let btcDominance = Statistic(title: "BTC Dominance", value: data.btcDominance)
        
        let portfolioValue =
                    portfolioCoins
                        .map({ $0.currentHoldingsValue })
                        .reduce(0, +)
        
        let previousValue =
                    portfolioCoins
                        .map { (coin) -> Double in
                            let currentValue = coin.currentHoldingsValue
                            let percentChange = coin.priceChangePercentage24H ?? 0 / 100
                            let previousValue = currentValue / (1 + percentChange)
                            return previousValue
                        }
                        .reduce(0, +)
        
        let percentageChange = ((portfolioValue - previousValue) / previousValue)
        
        let portfolio = Statistic(
                    title: "Portfolio Value",
                    value: portfolioValue.asCurrencyWithDecimals(2),
                    percentageChange: percentageChange)
        
        stats.append(contentsOf: [marketCap, volume, btcDominance, portfolio])
        return stats
    }
}

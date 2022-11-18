//
//  PortfolioDataService.swift
//  CryptoTracker
//
//  Created by Frédéric Helfer on 18/11/22.
//

import Foundation
import CoreData

class PortfolioDataService{
    
    private let container: NSPersistentContainer
    private let moc: NSManagedObjectContext
    private let containerName: String = "PortfolioContainer"
    private let entityName: String = "Portfolio"
    
    @Published var savedEntities: [Portfolio] = []
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { (_, error) in
            if let error {
                print("Error loading Core Data! \(error.localizedDescription)")
            }
        }
        moc = container.viewContext
        getPortfolio()
    }
    
    // MARK: PUBLIC
    
    func updatePortfolio(coin: Coin, amount: Double) {
        
        // check if coin is already in portfolio
        if let entity = savedEntities.first(where: { $0.coinID == coin.id }) {
            if amount > 0 {
                update(entity: entity, amount: amount)
            } else {
                delete(entity: entity)
            }
        } else {
            add(coin: coin, amount: amount)
        }
    }
    
    // MARK: PRIVATE
    
    private func getPortfolio() {
        let request = NSFetchRequest<Portfolio>(entityName: entityName)
        
        do {
            savedEntities = try moc.fetch(request)
        } catch let error {
            print("Error fetching Portfolio Entities. \(error.localizedDescription)")
        }
    }
    
    private func add(coin: Coin, amount: Double) {
        let newPortfolio = Portfolio(context: moc)
        newPortfolio.coinID = coin.id
        newPortfolio.amount = amount
        applyChanges()
    }
    
    private func update(entity: Portfolio, amount: Double) {
        entity.amount = amount
        applyChanges()
    }
    
    private func delete(entity: Portfolio) {
        moc.delete(entity)
        applyChanges()
    }
    
    private func save() {
        guard moc.hasChanges else { return }
        do {
            try moc.save()
        } catch let error {
            print("Error saving to Core Data. \(error.localizedDescription)")
        }
    }
    
    private func applyChanges() {
        save()
        getPortfolio()
    }
}


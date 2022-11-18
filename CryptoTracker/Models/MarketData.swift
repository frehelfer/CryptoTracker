//
//  MarketData.swift
//  CryptoTracker
//
//  Created by Frédéric Helfer on 17/11/22.
//

import Foundation

// JSON Data
/*
 URL: https://api.coingecko.com/api/v3/global
 
 JSON Response:
 {
   "data": {
     "active_cryptocurrencies": 13261,
     "upcoming_icos": 0,
     "ongoing_icos": 49,
     "ended_icos": 3376,
     "markets": 606,
     "total_market_cap": {
       "btc": 51892779.99949626,
       "eth": 718340685.6933305,
       "ltc": 13950194471.573774,
       "bch": 8343005016.119846,
       "bnb": 3228209429.9629664,
       "eos": 960297653925.9424,
       "xrp": 2252117557220.9966,
       "xlm": 9531916302021.68,
       "link": 137998886997.98868,
       "dot": 152110378297.4898,
       "yfi": 143065217.14887848,
       "usd": 868233423867.2395,
       "aed": 3189025707031.489,
       "ars": 141335812020940.34,
       "aud": 1298621073245.35,
       "bdt": 89404738404995.45,
       "bhd": 327225890421.0526,
       "bmd": 868233423867.2395,
       "brl": 4709037621028.747,
       "cad": 1157081660486.5112,
       "chf": 826696268636.0073,
       "clp": 800469041498799.4,
       "cny": 6214293907987.4,
       "czk": 20440038956258.387,
       "dkk": 6231042130733.774,
       "eur": 837739329554.1738,
       "gbp": 731753207269.2742,
       "hkd": 6795445950252.903,
       "huf": 344502215279285.25,
       "idr": 13643075689087988,
       "ils": 3017328206294.622,
       "inr": 70780375231731.12,
       "jpy": 121794048233248.44,
       "krw": 1165820429897735.2,
       "kwd": 267243116099.7601,
       "lkr": 318988205433978.75,
       "mmk": 1822788972857338.2,
       "mxn": 16856284814800.441,
       "myr": 3953752683272.399,
       "ngn": 383301730678220.5,
       "nok": 8794102795560.255,
       "nzd": 1417905058650.2007,
       "php": 49861338841392.63,
       "pkr": 193197802908048.72,
       "pln": 3943500583003.3735,
       "rub": 52506423254238.625,
       "sar": 3262527743995.8174,
       "sek": 9202957387793.053,
       "sgd": 1193478873848.4492,
       "thb": 31118015533790.44,
       "try": 16152961910995.654,
       "twd": 26954306643958.45,
       "uah": 32045515439404.273,
       "vef": 86936212731.82654,
       "vnd": 21545784941145210,
       "zar": 15084687506269.396,
       "xdr": 645957853256.409,
       "xag": 41383946761.25698,
       "xau": 493286819.7701723,
       "bits": 51892779999496.26,
       "sats": 5189277999949626
     },
     "total_volume": {
       "btc": 2891940.1943967976,
       "eth": 40032511.30980582,
       "ltc": 777432392.5676715,
       "bch": 464948525.563774,
       "bnb": 179905347.26663905,
       "eos": 53516565965.44523,
       "xrp": 125508583010.91893,
       "xlm": 531205533480.9615,
       "link": 7690559806.111354,
       "dot": 8476981132.783468,
       "yfi": 7972902.047201248,
       "usd": 48385905257.43265,
       "aed": 177721671940.07632,
       "ars": 7876523780283.792,
       "aud": 72371040423.06833,
       "bdt": 4982449515432.537,
       "bhd": 18236018674.758038,
       "bmd": 48385905257.43265,
       "brl": 262430634344.7375,
       "cad": 64483170148.00158,
       "chf": 46071075164.01184,
       "clp": 44609454253619.24,
       "cny": 346317278289.54956,
       "czk": 1139105868546.9116,
       "dkk": 347250642401.96405,
       "eur": 46686495492.98107,
       "gbp": 40779979652.3009,
       "hkd": 378704383973.6102,
       "huf": 19198813465660.83,
       "idr": 760316925800744.2,
       "ils": 168153117245.8927,
       "inr": 3944529703537.1357,
       "jpy": 6787478017702.127,
       "krw": 64970174284417.66,
       "kwd": 14893230024.14302,
       "lkr": 17776939544229.1,
       "mmk": 101582468631677.88,
       "mxn": 939386318956.028,
       "myr": 220339251502.24432,
       "ngn": 21361077235425.86,
       "nok": 490087818544.02136,
       "nzd": 79018634788.67136,
       "php": 2778729718146.944,
       "pkr": 10766748123811.447,
       "pln": 219767910732.9645,
       "rub": 2926138007530.477,
       "sar": 181817877521.4548,
       "sek": 512872934873.36847,
       "sgd": 66511555682.298386,
       "thb": 1734180359828.5942,
       "try": 900190735771.379,
       "twd": 1502140428716.9966,
       "uah": 1785869135364.804,
       "vef": 4844880693.426723,
       "vnd": 1200728145451677.8,
       "zar": 840656717942.6335,
       "xdr": 35998678038.38244,
       "xag": 2306291916.5791078,
       "xau": 27490452.072010368,
       "bits": 2891940194396.7974,
       "sats": 289194019439679.75
     },
     "market_cap_percentage": {
       "btc": 37.0190627364087,
       "eth": 16.776793660324405,
       "usdt": 7.605054489552603,
       "usdc": 5.093481352727964,
       "bnb": 5.0580878161998415,
       "busd": 2.6428735355889863,
       "xrp": 2.230470414539317,
       "doge": 1.3471611130158314,
       "ada": 1.3190830101091793,
       "matic": 0.9042917313420779
     },
     "market_cap_change_percentage_24h_usd": 0.48438361512056294,
     "updated_at": 1668726224
   }
 }
 
 */

struct GlobalData: Codable {
    let data: MarketData?
}

struct MarketData: Codable {
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double

    enum CodingKeys: String, CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
    }
    
    var marketCap: String {
        if let item = totalMarketCap.first(where: { $0.key == "usd" }) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var volume: String {
        if let item = totalVolume.first(where: { $0.key == "usd" }) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var btcDominance: String {
        if let item = marketCapPercentage.first(where: { $0.key == "btc" }) {
            return item.value.asPercentString()
        }
        return ""
    }
}

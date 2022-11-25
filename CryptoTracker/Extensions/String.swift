//
//  String.swift
//  CryptoTracker
//
//  Created by Frédéric Helfer on 18/11/22.
//

import Foundation

extension String {
    
    var replaceCommaWithDot: String {
        self.replacingOccurrences(of: ",", with: ".", options: .regularExpression)
    }
    
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}

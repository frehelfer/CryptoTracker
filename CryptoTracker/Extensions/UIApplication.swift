//
//  UIApplication.swift
//  CryptoTracker
//
//  Created by Frédéric Helfer on 18/11/22.
//

import Foundation
import SwiftUI

extension UIApplication {

    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

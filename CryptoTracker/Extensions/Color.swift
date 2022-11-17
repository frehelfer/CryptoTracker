//
//  Color.swift
//  CryptoTracker
//
//  Created by Frédéric Helfer on 16/11/22.
//

import Foundation
import SwiftUI

extension Color {
    static let theme = ColorTheme()
}

// TODO: Add on settings page the option for the user to choose the ColorTheme.
/*
    Make the struct Observabled and run it on the settings page
    Create function like change to theme1, theme2, theme3...
    OR. let the user chose one by one.
*/

struct ColorTheme {
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let green = Color("GreenColor")
    let red = Color("RedColor")
    let secondaryText = Color("SecondaryTextColor")
}

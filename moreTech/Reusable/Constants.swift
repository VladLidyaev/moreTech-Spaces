//
//  Constants.swift
//  moreTech
//
//  Created by Vlad on 09.10.2021.
//

import Foundation
import UIKit

class Constants {
    static var shared = Constants()
    private init() {}
    
    let spacingL : CGFloat = 60
    let spacingM : CGFloat = 30
    let spacingS : CGFloat = 10
    
    let cornerRadius : CGFloat = 10
    
    let borderImageName = "border"
    let egorksImageName = "egorka"
    let downImageName = "exchange"
    let upImageName = "profit"
    let additionalImageName = "additional"
    let coinsImageName = "coins"
    
    let leftImageName = "left"
    let rightImageName = "right"
    
    let errorImageName = "error"
    let helpImageName = "help"
    let lowImageName = "low"
    let stonksImageName = "stonks"
    
    let settingsImageName = "settings"
    
    let settingsScreenImageName = "SettingsScreen"
    let additionsScreemImageName = "Additions"
    
    let defaultText = "Default"
    let defaultIcon = "defaultIcon"
}

extension Constants: NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}

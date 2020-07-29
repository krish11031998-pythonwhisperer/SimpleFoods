//
//  Color.swift
//  SimpleFood
//
//  Created by Krishna Venkatramani on 7/25/20.
//  Copyright © 2020 Team Krish. All rights reserved.
//

import SwiftUI
import ChameleonFramework
extension Color{
    static var mainColor = Color(UIColor.flatWatermelon())
    static var secondaryColor = Color(UIColor.flatWatermelonDark())
    
    static func convertColor(_ color:UIColor) -> Color{
        return Color(color)
    }
}


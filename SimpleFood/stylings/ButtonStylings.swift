//
//  BUttonStylings.swift
//  SimpleFood
//
//  Created by Krishna Venkatramani on 6/20/20.
//  Copyright © 2020 Team Krish. All rights reserved.
//

import SwiftUI

struct ClearButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white);
    }
}

struct SearchTextFieldStyle: TextFieldStyle{
    var color:Color = .mainColor
    func _body(configuration: TextField<Self._Label>) -> some View{
        configuration
            .padding(.all)
            .background(
                RoundedRectangle(cornerRadius: 15)
                .strokeBorder(self.color, lineWidth: 1.5))
    }
}

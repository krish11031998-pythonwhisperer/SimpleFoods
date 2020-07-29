//
//  WaveCircle.swift
//  SimpleFood
//
//  Created by Krishna Venkatramani on 7/29/20.
//  Copyright © 2020 Team Krish. All rights reserved.
//

import SwiftUI

struct WaveCircle: View {
    var body: some View {
        RoundedRectangle(cornerRadius:20)
            .fill(Color.clear)
        .overlay(
            Circle()
                .fill(Color.black)
                .frame(width: 100,height: 100)
                .opacity(0.15)
            
        )
    }
}

struct WaveCircle_Previews: PreviewProvider {
    static var previews: some View {
        WaveCircle()
    }
}

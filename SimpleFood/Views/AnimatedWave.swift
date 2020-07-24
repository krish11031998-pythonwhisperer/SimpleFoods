//
//  TestView.swift
//  SimpleFood
//
//  Created by Krishna Venkatramani on 7/24/20.
//  Copyright © 2020 Team Krish. All rights reserved.
//

import SwiftUI

struct AnimatedWaves: View {
    @State var animate:Bool = false
    var body: some View {
        VStack{
            ZStack(alignment: .top){
                Wave(yOffset: self.animate ? 0.1 :  -0.1)
                    .frame(height:180)
                    .opacity(0.8)
                    .foregroundColor(Color(UIColor.flatWatermelon()))
                    .animation(Animation.easeOut(duration: 2.5).repeatForever(autoreverses: true))
                Wave(yOffset: self.animate ? -0.25 : 0.25)
                    .frame(height:170)
                    .opacity(0.8)
                    .foregroundColor(Color(UIColor.flatWatermelon()))
                    .animation(Animation.easeOut(duration: 2.5).repeatForever(autoreverses: true))
                
            }
            
            Spacer()
        }.edgesIgnoringSafeArea(.all)
            .onAppear {
                self.animate.toggle()
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedWaves()
    }
}

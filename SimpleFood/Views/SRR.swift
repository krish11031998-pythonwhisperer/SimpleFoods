//
//  SRR.swift
//  SimpleFood
//
//  Created by Krishna Venkatramani on 6/20/20.
//  Copyright © 2020 Team Krish. All rights reserved.
//

import SwiftUI
import ChameleonFramework
struct SRR: View {
    var key:String;
    var value:Int;
    var color:UIColor = FlatGreenDark();
    var unit:String;
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width:UIScreen.main.bounds.size.width/3.5, height: 100)
            .foregroundColor(Color(self.color))
            .overlay(
                VStack(spacing:1){
                    HStack{
                        Text("\(key)")
                            .font(.custom("Avenir", size: 12.5))
                            .fontWeight(.bold)
                            .fixedSize(horizontal: true, vertical: true)
                            .foregroundColor(Color(ContrastColorOf(self.color, returnFlat: true))).padding(.leading)
                        Spacer()
                        Circle()
                            .frame(width:25,height: 25)
                            .foregroundColor(.white)
                            .opacity(0.5)
                            .overlay(Text("\(unit.trimmingCharacters(in: .whitespacesAndNewlines))")
                                .font(.system(size: 10, weight: .medium, design: .serif))
                            ).offset(x: 10, y: -2).padding(.trailing)
                        
                        }.frame(width: UIScreen.main.bounds.size.width/3.75).padding(.bottom)
                    
                    Text("\(value)")
                        .font(.system(size: 25, weight: .semibold, design: .rounded))
                        .padding(.bottom)
                        .foregroundColor(Color(ContrastColorOf(self.color, returnFlat: true)))
                }
                .padding(.all)
        ).padding(.all,2)
            .shadow(radius: 2)
    }
}

struct SRR_Previews: PreviewProvider {
    static var previews: some View {
        SRR(key: "Calories", value: 50, unit: "kcal")
    }
}

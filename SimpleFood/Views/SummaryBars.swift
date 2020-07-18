//
//  SummaryBars.swift
//  SimpleFood
//
//  Created by Krishna Venkatramani on 7/10/20.
//  Copyright © 2020 Team Krish. All rights reserved.
//

import Foundation
import SwiftUI

struct SummaryBars:View{
    var yeilds:Int;
    var time:Int;
    var weight:Float;
    
    var body : some View{
        HStack(alignment: .center, spacing: 5) {
            InfoBars(icon: "person.fill", title: "Yields", value: self.yeilds,color:Color(UIColor.flatLime()))
            InfoBars(icon: "clock.fill", title: "Time", value: self.time,color:Color(UIColor.flatOrange()))
            InfoBars(icon: "gauge", title: "Weight", value: self.weight,color:Color(UIColor.flatMint()))
        }.frame(width: width, height: 100, alignment: .center)
//            .padding(.all,5)
    }
    
}

struct InfoBars : View{
    var icon:String;
    var title:String;
    var value:Any?;
    var color: Color
    var body: some View{
        RoundedRectangle(cornerRadius: 20)
            .frame(width:100,height: 100)
            .foregroundColor(color)
            .overlay(
                VStack(alignment: .center, spacing: 2.5, content: {
                    HStack{
                        Text(self.title)
                            .font(.system(size: 12, weight: .medium, design: .serif))
                        .foregroundColor(.black)
                        Image(uiImage:UIImage(systemName: self.icon)!)
                        .resizable()
                        .frame(width:10,height:10)
                    }
                    
                    Spacer().frame(height:10)
                    HStack(alignment: .center, spacing: 7.5) {
                        
                        Text(self.getValue())
                        .foregroundColor(.black)
                    }
                    })
        ).opacity(0.75)
    }
    
    func getValue() -> String{
        if let safeValue = value as? Int{
            print("value : \(safeValue)")
            return "\(safeValue)"
        }
        else if let safeValue = value as? Float{
            return String(format: "%.1f",safeValue)
        }
        return ""
    }
}


struct SummaryBars_Previews: PreviewProvider {
    static var previews: some View {
        SummaryBars(yeilds: 4, time: 60, weight: 1.5)
    }
}

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
        HStack(alignment: .center, spacing: 20) {
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
        HStack{
           RoundedRectangle(cornerRadius: 5)
            .frame(width:40,height: 40)
            .foregroundColor(self.color.opacity(0.95))
            .shadow(radius: 2.5, x: 2.5, y: 2.5)
            .overlay(Image(uiImage:UIImage(systemName: self.icon)!)
                    .resizable()
                    .foregroundColor(Color.white)
                    .frame(width:20,height:20))
            Spacer().frame(width:7.5)
            VStack{
                VStack(spacing:10){
                    
                    Text(self.title)
                        .font(.custom("Avenir Next", size: 15))
//                    .foregroundColor(.black)
                    Text(self.getValue())
//                    .foregroundColor(.black)
                        .font(.custom("Avenir Next", size: 12.5))
                    
                }
            }
        }.frame(width:width/3.25)
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

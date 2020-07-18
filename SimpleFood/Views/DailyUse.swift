//
//  DailyUse.swift
//  SimpleFood
//
//  Created by Krishna Venkatramani on 7/1/20.
//  Copyright © 2020 Team Krish. All rights reserved.
//

import Foundation
import SwiftUI

//struct barValue{
//    var value:CGFloat?;
//    var color:Color?;
//}

var barData = ["protein":["value":12,"max":100],"carbs":["value":89,"max":100],"fats":["value": 198,"max":300],"fiber":["value":54,"max":100]]

var width = UIScreen.main.bounds.width/1.15
struct DailyUseBars: View{
    var barData:[String:[String:Int]] = [:]
    func getPercent(value:Int,max:Int) -> CGFloat{
        var value = CGFloat(CGFloat(value)*200/CGFloat(max));
        return value < 200 ? value : 195;
    }
    
    func getColor(value:Int, max:Int) -> Color{
        var color:Color = .clear;
        var value = Float(Float(value)/Float(max));
        print("Value: \(value)");
        if value < 0.5{
            color = .green;
        }else if value >= 0.5 && value < 1.0{
            color = .orange
        }else if value >= 1.0{
            color = .red
        }
        return color;
    }
    
    var body: some View{
        VStack(alignment: .center) {
            RoundedRectangle(cornerRadius: 20.0)
                    .frame(width: width, height: 300)
                    .foregroundColor(.yellow)

                    .overlay(
                        VStack(alignment: .center, spacing: 5, content: {
                            Text("Nutrient Requirements (per Day)")
                                .font(.custom("Avenir Next",size:15.0))
                                .foregroundColor(Color.black)
                            HStack(alignment:.center){
                                ForEach(Array(barData.keys),id:\.self){(key) in
                                    VStack(alignment: .center) {
                                        ZStack(alignment: .bottom) {
                                            RoundedRectangle(cornerRadius: 20)
                                                .frame(width: 25, height: 200, alignment: .center)
                                                .foregroundColor(.black)
                                            RoundedRectangle(cornerRadius: 20)
                                                .frame(width: 18.5, height: self.getPercent(value: self.barData[key]?["value"] ?? 0, max: self.barData[key]?["max"] ?? 1), alignment: .center)
                                                .padding(.vertical,2.5)
                                                .foregroundColor(self.getColor(value: self.barData[key]?["value"] ?? 0, max: self.barData[key]?["max"] ?? 1))
                                                .opacity(5)
                                        }.padding(.horizontal,7.5)
                                        Text("\(key.capitalized)")
                                            .font(.subheadline).foregroundColor(.black)
                                        
                                    }
                                }
                            }.frame(width: width)
                                .padding(.all)
                        })
                )
                
                
            }.padding(.horizontal, 25.0)
        }
        
}

struct DailyUseBarsPreview:PreviewProvider{
    static var previews: some View {
        DailyUseBars(barData: barData)
    }
}

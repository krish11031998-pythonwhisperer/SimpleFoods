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
    @Environment(\.colorScheme) var colorScheme
    var key:String;
    var value:Int;
    var color:UIColor = UIColor.flatWatermelon()
    var unit:String;
    var max:Int = 100;
    var body: some View {
        ZStack(alignment: .center){
            RoundedRectangle(cornerRadius: 10)
                .frame(width:UIScreen.main.bounds.size.width/2.25, height: 200)
                .foregroundColor(Color(self.colorScheme == .dark ? .black : .white).opacity(0.15))
                .blur(radius: 5)
                .shadow(radius: 0.5, x: 2.5, y: 2.5)
//                .shadow(radius: 2.5, x: -1, y: -1)
            
            RoundedRectangle(cornerRadius: 10)
                .frame(width:UIScreen.main.bounds.size.width/2, height: 200)
                .foregroundColor(Color.clear)
            RoundedRectangle(cornerRadius: 10)
                .frame(width:UIScreen.main.bounds.size.width/2, height: 200)
                .foregroundColor(.clear)
                .overlay(VStack(alignment:.leading,spacing:1){
                    HStack{
                        Text("\(key)")
                            .font(.custom("Avenir", size: 20))
                            .fontWeight(.bold)
                            .fixedSize(horizontal: true, vertical: true)
                            .foregroundColor(Color(self.color))
                            .padding(.leading)
                        Spacer()
                        Circle()
                            .fill(Color.white)
                            .frame(width:25,height: 25)
                            .opacity(0.5)
                            .overlay(
                                Circle()
                                    .fill(Color(self.color))
                                    .frame(width:15,height: 15)
                        ).padding(.trailing)
                        
                    }.frame(width: UIScreen.main.bounds.size.width/2.25).padding(.bottom).padding(.leading)
                    HStack{
                        Spacer()
                        ZStack(alignment: .center){
                            Outline()
                            Label(value:"\(self.value)",unit:self.unit,color:self.color)
                            ProgressOutline(percent:self.value)
                        }
                        Spacer()
                    }
                    Spacer()
                    VStack(alignment:.center){
                        HStack(alignment: .center,spacing : 2.5){
                            Spacer()
                            Text("Daily Max : ")
                                .font(.custom("Avenir", size: 15))
                                .foregroundColor(Color(self.color))
                                .fontWeight(.medium)
                            Text("\(self.max) \(self.unit)")
                                .font(.custom("Avenir", size: 12.5))
                                .foregroundColor(Color(self.color))
                                .fontWeight(.medium)
                            Spacer()
                        }

                    }
                }.padding(.vertical))
            
        }
    }
}

struct Label:View{
    var value:String;
    var unit:String;
    var color:UIColor;
    var body: some View{
        ZStack{
            HStack{
                Text("\(value)")
                    .font(.system(size: 25, weight: .semibold, design: .rounded))
                    .foregroundColor(Color(self.color))
                Text("\(unit.trimmingCharacters(in: .whitespacesAndNewlines))")
                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                    .foregroundColor(Color(self.color))
            }
        }
    }
}


struct ProgressOutline: View{
    var dim:CGFloat = 100;
    var percent:Int;
    var body: some View{
        ZStack{
            Circle()
                .frame(width: self.dim, height: self.dim, alignment: .center)
                .foregroundColor(.clear)
                .opacity(0.5)
                .overlay(
                    Circle()
                        .trim(from:0 , to : CGFloat(Double(percent)*0.01))
                        .stroke(style: StrokeStyle(lineWidth: 7.5, lineCap: .round, lineJoin: .round))
                        .fill(AngularGradient(gradient: .init(colors: [Color(UIColor.flatMint()),Color(UIColor.flatRed())]) , center: .center, startAngle: .zero , endAngle: .init(degrees: 360)))
                    
            ).animation(.spring(response: 2.0, dampingFraction: 1.0, blendDuration: 1.0))
        }
        
    }
}


struct Outline: View{
    var dim:CGFloat = 100;
    var body: some View{
        ZStack{
            Circle()
                .frame(width: self.dim, height: self.dim, alignment: .center)
                .foregroundColor(.clear)
                .opacity(0.5)
                .overlay(
                    Circle()
                        .stroke(style: StrokeStyle(lineWidth: 7.5, lineCap: .round, lineJoin: .round))
                        .fill(AngularGradient(gradient: .init(colors: [Color.gray.opacity(0.5)]) , center: .center))
            )
        }
        
    }
}

struct SRR_Previews: PreviewProvider {
    static var previews: some View {
        SRR(key: "Calories", value: 50, unit: "kcal")
    }
}

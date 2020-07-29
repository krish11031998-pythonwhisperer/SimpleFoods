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
    var colorMain:UIColor = UIColor.flatWatermelon()
    var colorSecondary:UIColor = UIColor.flatWatermelonDark()
    var unit:String;
    var max:Int = 100;
    var cardColor: LinearGradient{
        get{
            return LinearGradient(gradient: Gradient(colors:[Color(colorMain), Color(colorSecondary)]), startPoint: .top, endPoint: .bottom)
        }
    }
    var body: some View {
        ZStack(alignment: .center){
            RoundedRectangle(cornerRadius: 10)
                .fill(self.cardColor)
                .frame(width:UIScreen.main.bounds.size.width/2.25, height: 200)
                .shadow(radius: 0.5, x: 2.5, y: 2.5)
            
            RoundedRectangle(cornerRadius: 10)
                .frame(width:UIScreen.main.bounds.size.width/2, height: 200)
                .foregroundColor(Color.clear)
                .overlay(
                    ZStack{
                        GeometryReader{g in
                            TopArc(center: CGPoint(x: g.frame(in: .local).width, y: g.frame(in: .local).height/10),color: self.colorSecondary)
                        }.padding(.top,-20).padding(.trailing,10).clipShape(Corners(corner: [.topRight], size: CGSize(width: 30,height: 30)))
                        GeometryReader{g in
                            TopArc(center: CGPoint(x: g.frame(in: .local).width, y: g.frame(in: .local).height/10),color: self.colorSecondary, radius: 50,opacity: 0.4)
                        }.padding(.top,-20).padding(.trailing,10).clipShape(Corners(corner: [.topRight], size: CGSize(width: 30,height: 30)))
                    }.padding(.trailing,1))
            RoundedRectangle(cornerRadius: 10)
                .frame(width:UIScreen.main.bounds.size.width/2, height: 200)
                .foregroundColor(.clear)
                .overlay(VStack(alignment:.leading,spacing:1){
                    HStack{
                        Text("\(key)")
                            .font(.custom("Avenir", size: 20))
                            .fontWeight(.bold)
                            .fixedSize(horizontal: true, vertical: true)
                            .foregroundColor(Color.white)
                            .padding(.leading)
                        Spacer()
                        
                        
                        
                    }.frame(width: UIScreen.main.bounds.size.width/2.25).padding(.bottom).padding(.leading)
                    HStack{
                        Spacer()
                        ZStack(alignment: .center){
                            Outline()
                            Label(value:"\(self.value)",unit:self.unit,color:self.colorMain)
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
                                .foregroundColor(Color.white)
                                .fontWeight(.medium)
                            Text("\(self.max) \(self.unit)")
                                .font(.custom("Avenir", size: 12.5))
                                .foregroundColor(Color.white)
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
                    .foregroundColor(Color.white)
                Text("\(unit.trimmingCharacters(in: .whitespacesAndNewlines))")
                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                    .foregroundColor(Color.white)
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
                        .fill(AngularGradient(gradient: .init(colors: [Color(UIColor.flatMint())]) , center: .center, startAngle: .zero , endAngle: .init(degrees: 360)))
                    
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

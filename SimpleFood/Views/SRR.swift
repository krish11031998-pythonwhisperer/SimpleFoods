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
    @State var animate:Bool = false
    @Binding var showDetails:String
    var width:CGFloat = 75.0
    var height:CGFloat = 150.0
    var key:String;
    var value:Int;
    var colorMain:UIColor = UIColor.flatWatermelon()
    var colorSecondary:UIColor = UIColor.flatWatermelonDark()
    var unit:String;
    var max:Int = 100;
    var percentTotal:Int = 35
    var cardColor: LinearGradient{
        get{
            return LinearGradient(gradient: Gradient(colors:[Color(colorMain), Color(colorSecondary)]), startPoint: .top, endPoint: .bottom)
        }
    }
    
    var body: some View{
        self.V2.onAppear {
            self.animate.toggle()
        }
    }
    
    var detailCardWidth:CGFloat{
        get{
            return self.isActive ? 200 : 0
        }
    }
    
    var detailCardHeight:CGFloat{
        get{
            return self.isActive ? 200 : 0
        }
    }
    
    var isActive:Bool{
        get{
            return self.showDetails == self.key
        }
    }
    
    func changeTitle(){
        if self.showDetails == self.key{
            self.showDetails = ""
        }else{
            self.showDetails = self.key
        }
        
    }
    
    var TotalPercent:Int{
        get{
            return self.max != 0 ? Int(self.value)*100/Int(self.max) : 0
        }
    }
    
    var V2: some View{
        ZStack(alignment: .bottom){
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.gray.opacity(0.25))
                .frame(width: self.width, height: self.height, alignment: .center)
            //            AnimatedWaves().frame(width: self.width, height: 50, alignment: .bottom).rotationEffect(.degrees(180)).clipShape(Corners(corner: [.bottomRight,.bottomLeft], size: CGSize(width: 10, height: 10)))
            //            self.WavePercent.padding(.bottom,5)
            RoundedRectangle(cornerRadius: 30)
                .fill(Color(self.colorMain))
                .frame(width: self.width, height: 0.95*self.height, alignment: .center).onTapGesture {
                    self.changeTitle()
            }
            
            VStack{
                Circle()
                    .fill(Color.white)
                    .frame(width: 50, height: 50)
                    .overlay(
                        Text("\(self.value)")
                            .font(.custom("Avenir Next",size: 10))
                ).padding(.top)
                Spacer()
                Text(self.key)
                    .font(.custom("Avenir Next",size: 15))
                    .foregroundColor(.white)
                    .italic()
                .frame(width: 100)
                    .fixedSize(horizontal: false, vertical: true)
                Text(self.unit)
                    .font(.custom("Avenir Next",size: 7.5))
                    .foregroundColor(.white)
                    .padding(.bottom)
                    .frame(width: 50)
            }.frame(width: self.width, height: self.height, alignment: .center).onTapGesture {
                self.changeTitle()
            }
            self.cardDetails
        }
    }
    
    var cardDetails: some View{
        RoundedRectangle(cornerRadius: 20)
            .fill(Color(self.colorMain))
            .frame(width:self.detailCardWidth,height: self.detailCardHeight)
            .animation(.easeInOut(duration: 0.25))
            .onTapGesture {
                self.changeTitle()
                
        }
        .overlay(
            VStack{
                HStack {
                    Text("\(key)")
                        .font(.custom("Avenir Next",size: 22.5))
                        .italic()
                        .foregroundColor(.white).padding(.leading)
                    Spacer()
                    Text("\(self.value) \(self.unit)")
                        .font(.custom("Avenir Next",size: 17.5))
                        .foregroundColor(.white)
                        .padding(.trailing)
                }.opacity(self.isActive ? 1 : 0).padding(.top).animation(.linear)
                HStack(spacing: 5){
                    ZStack(alignment: .center){
                        Outline()
                        Label(value:"\(self.TotalPercent)",unit:"%",description: "of your Daily Needs",color:self.colorMain)
                        ProgressOutline(percent:self.TotalPercent)
                    }.opacity(self.isActive ? 1 : 0).padding(.leading)
                    VStack {
                        Text("\(self.percentTotal)%")
                            .font(.custom("Avenir Next",size: 27.5))
                            .fontWeight(.bold)
                            .italic()
                            .foregroundColor(.white).padding(.leading)
                        Text("of your Recipe")
                            .font(.custom("Avenir Next",size: 15))
                            .fontWeight(.light)
                            .foregroundColor(.white).padding(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }.opacity(self.isActive ? 1 : 0).animation(.easeInOut(duration: 0.25))
                HStack(alignment: .center,spacing : 2.5){
                    Spacer()
                    Text("Daily Max : \(self.max) \(self.unit)")
                        .font(.custom("Avenir", size: 15))
                        .foregroundColor(Color.white)
                        .fontWeight(.semibold)
                        .italic()
                    Spacer()
                }.padding(.all).animation(.linear)
            }.animation(.easeInOut(duration: 0.35))
        )
    }
    
    var WavePercent: some View{
        Wave(yOffset: self.animate ? 0.5 :  -0.5)
            .frame(width:self.width - 10, height: self.percent*self.height)
            .opacity(0.8)
            .rotationEffect(.degrees(180))
            .foregroundColor(Color(self.colorMain))
            .animation(Animation.easeOut(duration: 2.5).repeatForever(autoreverses: true))
            .clipShape(Corners(corner: [.bottomRight,.bottomLeft], size: CGSize(width: self.percent * 0.3, height: self.percent * 0.3)))
    }
    
    var percent:CGFloat{
        get{
            return (CGFloat(self.value)/CGFloat(self.max))
        }
    }
}

struct Label:View{
    var value:String;
    var unit:String;
    var description:String = ""
    var color:UIColor;
    var body: some View{
        ZStack{
            VStack(alignment: .center) {
                    Text("\(value)\(unit)")
                        .font(.custom("Avenir Next",size: 15))
                        .foregroundColor(Color.white)
                Text(self.description)
                    .font(.custom("Avenir Next",size: 9))
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .padding(.horizontal)
                .fixedSize(horizontal: false, vertical: true)
            }
        }
    }
}


struct ProgressOutline: View{
    var dim:CGFloat = 75;
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
                    .rotationEffect(.init(degrees: 270))
                    
            ).animation(.spring(response: 2.0, dampingFraction: 1.0, blendDuration: 1.0))
        }
        
    }
}


struct Outline: View{
    var dim:CGFloat = 75;
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

//struct SRR_Previews: PreviewProvider {
//    static var previews: some View {
//        SRR(key: "Calories", value: 95, unit: "kcal")
//    }
//}

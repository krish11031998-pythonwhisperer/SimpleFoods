//
//  Stylings.swift
//  SimpleFood
//
//  Created by Krishna Venkatramani on 7/24/20.
//  Copyright © 2020 Team Krish. All rights reserved.
//

import SwiftUI
import ChameleonFramework
struct Corners : Shape{
    
    var corner : UIRectCorner
    var size : CGSize
    
    func path(in rect: CGRect) -> Path {
        return Path(UIBezierPath(roundedRect: rect, byRoundingCorners: self.corner, cornerRadii: self.size).cgPath)
    }
    
    
}


struct Wave : Shape{
    var yOffset:CGFloat = 0.5
    var animatableData: CGFloat{
        get{
            return self.yOffset
        }
        set{
            self.yOffset = newValue
        }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to:.zero)
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX , y: rect.maxY))
        path.addCurve(to: CGPoint(x:rect.minX, y:rect.maxY), control1: CGPoint(x: rect.maxX * 0.75, y: rect.maxY * (1-self.yOffset)), control2: CGPoint(x: rect.maxX * 0.25, y: rect.maxY * (1+self.yOffset)))
        path.closeSubpath()
        
        return path
    }
    
}

struct Stylings_Previews: PreviewProvider {
    
    @State static var animate:Bool = false
    static var previews: some View {
        VStack{
            ZStack(alignment: .top){
                Wave(yOffset: Stylings_Previews.animate ? 0.5 :  -0.5)
                    .frame(height:150)
                    .opacity(0.8)
                    .foregroundColor(Color(UIColor.flatWatermelon()))
                    .animation(Animation.easeOut(duration: 2).repeatForever(autoreverses: true))
                Wave(yOffset: Stylings_Previews.animate ? -0.5 : 0.5)
                    .frame(height:180)
                    .opacity(0.8)
                    .foregroundColor(Color(UIColor.flatWatermelon()))
                    .animation(Animation.easeOut(duration: 2).repeatForever(autoreverses: true))
            }
            
            Spacer()
        }.edgesIgnoringSafeArea(.all)
            .onAppear {
                Stylings_Previews.animate.toggle()
        }
        
        
    }
}

//
//  BottomBar.swift
//  SimpleFood
//
//  Created by Krishna Venkatramani on 6/23/20.
//  Copyright © 2020 Team Krish. All rights reserved.
//

import SwiftUI
struct BottomBar: View {
    @State var window : Int = 0;
    var body: some View {
        VStack{
            Spacer()
            if self.window == 0{
                Text("window 1")
            }
            else if self.window == 1{
                Text("window 2")
            }
            else if self.window == 2{
                Text("window 3")
            }else if self.window == 3{
                Text("window 4")
            }
            Spacer()
            Tabs(windowIndex: self.$window)
        }.background(window == 0 ? Color.red : window == 1 ? Color.blue : window == 2 ? Color.yellow : Color.white)
        .edgesIgnoringSafeArea(.all)
    }
}

struct Tabs : View{
    
    var color:Color = .white;
    func isActive(_ i:Int) ->  Color{
        return self.windowIndex == i ? Color.mainColor : self.color
    }
    @Binding var windowIndex : Int;
    var body : some View {
        ZStack(alignment:.bottom){
            Color(.clear)
            HStack(alignment: .bottom){
                Button(action: {
                    if self.windowIndex != 0{
                        self.windowIndex = 0;
                    }
                }) {
                    Image(systemName: "house.fill")
                        .foregroundColor(self.isActive(0))
                        .frame(width: 50,height:50)
                        
//                        .opacity(self.windowIndex == 0 ? 1 : 0.5)
                }
                Spacer()
                Button(action: {
                    if self.windowIndex != 1{
                        self.windowIndex = 1;
                    }
                }) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(self.isActive(1))
                        .frame(width: 50,height:50)
//                        .opacity(self.windowIndex == 1 ? 1 : 0.5)
                }
                Spacer()
                Button(action: {
                    if self.windowIndex != 2{
                        self.windowIndex = 2;
                    }
                }) {
                    Image(systemName: "list.dash")
                        .foregroundColor(self.isActive(2))
                        .frame(width: 50,height:50)
//                        .opacity(self.windowIndex == 2 ? 1 : 0.5)
                }
                Spacer()
                Button(action: {
                    if self.windowIndex != 3{
                        self.windowIndex = 3;
                    }
                }) {
                    Image(systemName: "heart")
                        .foregroundColor(self.isActive(3))
                        .frame(width: 50,height:50)
//                        .opacity(self.windowIndex == 3 ? 1 : 0.5)
                }
                
            }.frame(width:width)
        }.frame(height:50)
        
        
            

    }
    
    
}

struct BarShape: Shape{
    func path(in rect: CGRect) -> Path {
        
        return Path{path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
        }
    }
}



struct BottomBar_Previews: PreviewProvider {
    static var previews: some View {
        BottomBar()
    }
}

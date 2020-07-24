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
            }
            Spacer()
            Tabs(windowIndex: self.$window)
        }.background(window == 0 ? Color.red : window == 1 ? Color.blue : window == 2 ? Color.yellow : Color.white)
        .edgesIgnoringSafeArea(.all)
    }
}

struct Tabs : View{
    
    @Binding var windowIndex : Int;
    var body : some View {
        ZStack(alignment:.bottom){
            Color(.clear)
            RoundedRectangle(cornerRadius:20)
            .fill(Color.gray)
            .frame(width:width - 100,height:50)
            .overlay(
                HStack(alignment: .bottom){
                    Button(action: {
                        if self.windowIndex != 0{
                            self.windowIndex = 0;
                        }
                    }) {
                        Image(systemName: "house.fill")
                            .renderingMode(.original)
                            .frame(width: 50,height:50)
                            .opacity(self.windowIndex == 0 ? 1 : 0.5)
                    }
                    Spacer()
                    Button(action: {
                        if self.windowIndex != 1{
                            self.windowIndex = 1;
                        }
                    }) {
                        Image(systemName: "magnifyingglass")
                            .renderingMode(.original)
                            .frame(width: 50,height:50)
                            .opacity(self.windowIndex == 1 ? 1 : 0.5)
                    }
                    Spacer()
                    Button(action: {
                        if self.windowIndex != 2{
                            self.windowIndex = 2;
                        }
                    }) {
                        Image(systemName: "list.dash")
                            .renderingMode(.original)
                            .frame(width: 50,height:50)
                            .opacity(self.windowIndex == 2 ? 1 : 0.5)
                    }
                    Spacer()
                    Button(action: {
                        if self.windowIndex != 3{
                            self.windowIndex = 3;
                        }
                    }) {
                        Image(systemName: "heart")
                            .renderingMode(.original)
                            .frame(width: 50,height:50)
                            .opacity(self.windowIndex == 2 ? 1 : 0.5)
                    }
                    
                }.frame(width:width - 100))
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

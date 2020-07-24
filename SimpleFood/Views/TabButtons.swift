//
//  TabButtons.swift
//  SimpleFood
//
//  Created by Krishna Venkatramani on 7/10/20.
//  Copyright © 2020 Team Krish. All rights reserved.
//

import Foundation
import SwiftUI
import ChameleonFramework

struct TabButtons : View{
    @Binding var buttonOne:Bool;
    @Binding var buttonTwo:Bool;
    var body: some View{
        VStack{
            Spacer().frame(height:20)
            HStack(alignment: .center, content: {
                Buttons(main: self.$buttonOne, other: self.$buttonTwo,title: "Overview")
                Spacer().frame(width:100)
                Buttons(main: self.$buttonTwo, other: self.$buttonOne,title: "Recipe")
            }).padding(.horizontal,10)
            Spacer().frame(height:20)
        }.padding(.horizontal,10)
        
    }
}

struct Buttons:View{
    @Binding var main:Bool;
    @Binding var other:Bool;
    var title:String;
    var body: some View{
        Button(action: {
            if !self.main{
                self.main = true;
                self.other = false;
            }
        }) {
            RoundedRectangle(cornerRadius: 20)
            .frame(width: width/3, height: 45)
                .foregroundColor(self.main ? Color(UIColor.flatMint()) : .clear)
                .padding(.horizontal,2.5)
                .overlay(Text(self.title)
                .foregroundColor(self.main ? .white : Color(UIColor.flatMint())))
        }
    }
}

struct TabButtons_Previews: PreviewProvider {
    @State static var B1:Bool = true;
    @State static var B2:Bool = false;
    static var previews: some View {
        TabButtons(buttonOne: TabButtons_Previews.$B1, buttonTwo: TabButtons_Previews.$B2)
    }
}

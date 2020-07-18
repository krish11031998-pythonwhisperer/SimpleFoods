//
//  TabButtons.swift
//  SimpleFood
//
//  Created by Krishna Venkatramani on 7/10/20.
//  Copyright © 2020 Team Krish. All rights reserved.
//

import Foundation
import SwiftUI

struct TabButtons : View{
    @Binding var buttonOne:Bool;
    @Binding var buttonTwo:Bool;
    var body: some View{
        VStack{
            Spacer().frame(height:20)
            HStack(alignment: .center, content: {
                Buttons(main: self.$buttonOne, other: self.$buttonTwo,title: "Overview")
                Spacer()
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
            .foregroundColor(self.main ? .red : .clear)
                .padding(.horizontal,2.5)
                .overlay(Text(self.title)
                .foregroundColor(self.main ? .white : .red))
        }
    }
}

//
//  Titles.swift
//  SimpleFood
//
//  Created by Krishna Venkatramani on 7/25/20.
//  Copyright © 2020 Team Krish. All rights reserved.
//

import SwiftUI
import ChameleonFramework
struct Titles: View {
    var title:String;
    var color:Color = .init(UIColor.flatWatermelon())
    var height:CGFloat = 50;
    var imageStr:String? = nil
    var body: some View {
        
        RoundedRectangle(cornerRadius: 20)
            .fill(self.color)
            .frame(height:self.height)
            .frame(minWidth: 100, idealWidth: 200, maxWidth: 300,alignment: .center)
        .overlay(
            HStack{
                if self.imageStr != nil {
                    Image(uiImage: UIImage(named: self.imageStr!)!)
                    .resizable()
                        .renderingMode(.original)
                        .frame(width: 25, height: 25).padding(.trailing,5)
                }
                
                Text(self.title.capitalized)
                    .font(.custom("Avenir Next", size: 20.0))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            })
    }
}

struct Titles_Previews: PreviewProvider {
    static var previews: some View {
        Titles(title: "Ingredients",imageStr: "salad")
    }
}

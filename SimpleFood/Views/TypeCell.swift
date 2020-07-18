//
//  TypeCell.swift
//  SimpleFood
//
//  Created by Krishna Venkatramani on 6/13/20.
//  Copyright © 2020 Team Krish. All rights reserved.
//

import SwiftUI
import ChameleonFramework

struct TypeCell: View {
    var type:String;
    var cardColor: UIColor = UIColor.randomFlat();
    init(type:String,color:UIColor?=nil){
        self.type = type;
        if let safeColor = color{
            self.cardColor = safeColor;
        }
    }
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: 150, height: 50)
            .foregroundColor(Color(self.cardColor))
            .overlay(
                VStack{
                    Text(self.type.capitalized)
                        .font(.custom("Avenir Next", size: 15))
                        .fontWeight(.semibold)
                        .foregroundColor(Color(ContrastColorOf(cardColor, returnFlat: true)))
                    
                }
                
        ).padding(.trailing, 15)
        
    }
}

struct TypeCell_Previews: PreviewProvider {
    static var previews: some View {
        TypeCell(type: "Pizza")
    }
}

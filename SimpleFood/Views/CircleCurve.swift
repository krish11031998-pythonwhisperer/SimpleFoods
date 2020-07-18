//
//  CircleCurve.swift
//  SimpleFood
//
//  Created by Krishna Venkatramani on 7/10/20.
//  Copyright © 2020 Team Krish. All rights reserved.
//

import Foundation
import SwiftUI
import ChameleonFramework
struct CircleView:View{
    var food:EdamamRecipe;
    var body: some View{
        ScrollView(.vertical,showsIndicators: false){
            VStack{
                ZStack(alignment: .top){
                    Circle()
                        .frame(width:width+200,height:width+300)
                        .foregroundColor(Color(FlatWatermelon()))
                        .padding(.horizontal,-100)
                        .offset(y: -width)
                    FoodDetailView(food: self.food).zIndex(1)
                    
                }
            }
            
        }
        
    }
}

struct CircleView_Previews : PreviewProvider{
    static var previews: some View {
        CircleView(food: edamamExample!)
    }
}

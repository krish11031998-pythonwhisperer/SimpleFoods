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
var height:CGFloat = UIScreen.main.bounds.height/1.25
struct CircleView:View{
    var food:EdamamRecipe;
    var body: some View{
        ScrollView(.vertical,showsIndicators: false){
            VStack{
                FoodDetailView(food: self.food)
                    
                    .animation(.spring())
                
            }
        }.edgesIgnoringSafeArea(.all)
        .statusBar(hidden: true)
            .navigationBarHidden(true)
        
    }
}

struct CircleView_Previews : PreviewProvider{
    static var previews: some View {
        CircleView(food: edamamExample!)
    }
}

//
//  MultipleMenu.swift
//  SimpleFood
//
//  Created by Krishna Venkatramani on 7/26/20.
//  Copyright © 2020 Team Krish. All rights reserved.
//

import SwiftUI

struct MultipleMenu: View {
    @State var meal: SMeal = .Breakfast
    var body: some View {

        VStack{
            FoodTabs(value: self.$meal, query: SQuery(diet: "vegetarian", type: self.meal.rawValue, instructionsRequired: true, addRecipeInformation: true, addRecipeNutrition: true))
        }.padding(.top)
        
    }
}

struct MultipleMenu_Previews: PreviewProvider {
    static var previews: some View {
        MultipleMenu()
    }
}

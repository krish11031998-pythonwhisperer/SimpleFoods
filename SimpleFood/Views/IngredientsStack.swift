//
//  IngredientsStack.swift
//  SimpleFood
//
//  Created by Krishna Venkatramani on 6/18/20.
//  Copyright © 2020 Team Krish. All rights reserved.
//

import SwiftUI

struct IngredientsStack: View {
    var recipe:Recipe;
    var body: some View {
        VStack(alignment: .leading, spacing: 5){
            ForEach(self.recipe.ingredients ?? [], id:\.self){ (ingredient) in
                Text(ingredient)
                    .font(.system(size: 15, weight: .light, design: .serif))
                    .frame(alignment: .leading)
            }
            
        }
        
    }
}

struct IngredientsStack_Previews: PreviewProvider {
    static var previews: some View {
        IngredientsStack(recipe: Recipe(ingredients: [
        "4 1/2 cups (20.25 ounces) unbleached high-gluten, bread, or all-purpose flour, chilled",
        "1 3/4 (.44 ounce) teaspoons salt",
        "1 teaspoon (.11 ounce) instant yeast",
        "1/4 cup (2 ounces) olive oil (optional)",
        "1 3/4 cups (14 ounces) water, ice cold (40F)",
        "Semolina flour OR cornmeal for dusting","4 1/2 cups (20.25 ounces) unbleached high-gluten, bread, or all-purpose flour, chilled",
        "1 3/4 (.44 ounce) teaspoons salt",
        "1 teaspoon (.11 ounce) instant yeast",
        "1/4 cup (2 ounces) olive oil (optional)",
        "1 3/4 cups (14 ounces) water, ice cold (40F)",
        "Semolina flour OR cornmeal for dusting"]))
    }
}

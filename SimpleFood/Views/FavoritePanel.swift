//
//  FavoritePanel.swift
//  SimpleFood
//
//  Created by Krishna Venkatramani on 7/11/20.
//  Copyright © 2020 Team Krish. All rights reserved.
//

import SwiftUI

struct FavoritePanel: View {
    @ObservedObject var recipeManager = FavoriteRecipeManager()
    @ObservedObject var foodManager = EdamamAPIManager()
    var body: some View {
        
        VStack(alignment: .leading, spacing: 7.5){
            
            ForEach(self.recipeManager.finalData, id:\.self){(recipe) in
                NavigationLink(destination : CircleView(food:self.foodManager.getRecipe(recipe.uri)!)){
                    LargeFoodCard(recipe:recipe)
                }
            }
        }.frame(width:UIScreen.main.bounds.size.width)
    }
}

struct FavoritePanel_Previews: PreviewProvider {
    static var previews: some View {
        FavoritePanel()
    }
}

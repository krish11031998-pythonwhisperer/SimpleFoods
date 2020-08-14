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
    var body: some View {
        VStack{
            Text("Favorites");
            VStack(alignment: .leading, spacing: 7.5){
                
                ForEach(0..<self.recipeManager.finalData.count, id:\.self){(i) in
                    NavigationLink(destination : MainFoodView(food:self.recipeManager.finalData[i])){
                        LargeFoodCard(recipe:self.recipeManager.finalData[i])
                    }
                }
            }.frame(width:UIScreen.main.bounds.size.width)
        }.onAppear {
            self.recipeManager.readData()
        }
        
    }
}

struct FavoritePanel_Previews: PreviewProvider {
    static var previews: some View {
        FavoritePanel()
    }
}

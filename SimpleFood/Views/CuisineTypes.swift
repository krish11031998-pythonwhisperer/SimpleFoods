//
//  CuisineTypes.swift
//  SimpleFood
//
//  Created by Krishna Venkatramani on 7/16/20.
//  Copyright © 2020 Team Krish. All rights reserved.
//

import SwiftUI

struct CuisineTypes: View {
    @ObservedObject var EFDM = EdamamAPIManager();
    var cuisine : Cuisine;
    
    init(_ cuisine:Cuisine) {
        self.cuisine = cuisine;
        var q = queryParams();
        q.q = self.cuisine.rawValue;
        q.from = 0;
        q.to = 6;
        self.EFDM.query = q;
        self.EFDM.getResults();
    }
    var Recipes:[CoupleRecipes]{
        get{
            var finalResult:[CoupleRecipes] = []
            var count = 0
            var temp:[ERecipeID] = []
            while(count <= self.EFDM.result.count){
                if count%2 == 0 && count > 0{
                    var newR = CoupleRecipes(id: (count-2)/2,Recipes:temp)
                    finalResult.append(newR)
                    temp = []
                }
                if count<self.EFDM.result.count{
                    temp.append(self.EFDM.result[count])
                }
                
                count+=1
            }
            return finalResult
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(self.cuisine.rawValue.capitalized)
                .font(.title)
            VStack{
                ForEach(self.Recipes){(recipes) in
                    HStack{
                        ForEach(recipes.Recipes){(recipe) in
                            FoodCell(food: recipe.recipe, width: width/2, height: 200, type: "featured")
                        }
                        
                    }
                    
                }
            }
        }
    }
}

struct CuisineTypes_Previews: PreviewProvider {
    static var previews: some View {
        CuisineTypes(.Indian)
    }
}

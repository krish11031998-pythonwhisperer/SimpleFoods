//
//  CuisineTypes.swift
//  SimpleFood
//
//  Created by Krishna Venkatramani on 7/16/20.
//  Copyright © 2020 Team Krish. All rights reserved.
//

import SwiftUI

struct CuisineTypes: View {
    @ObservedObject var SFDM = SAPIManager();
    var cuisine : String;
    
    init(_ cuisine:String) {
        self.cuisine = cuisine;
        var q = SQuery(cuisine: cuisine, instructionsRequired: true, addRecipeInformation: true, addRecipeNutrition: true);
        self.SFDM.query = q;
        self.SFDM.getResults();
    }
    
    var Recipes:[CoupleRecipes]{
        get{
            var finalResult:[CoupleRecipes] = []
            var count = 0
            var temp:[SResult] = []
            while(count <= self.SFDM.result.count){
                if count%2 == 0 && count > 0{
                    var newR = CoupleRecipes(id: (count-2)/2,Recipes:temp)
                    finalResult.append(newR)
                    temp = []
                }
                if count<self.SFDM.result.count{
                    temp.append(self.SFDM.result[count])
                }
                
                count+=1
            }
            return finalResult
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(self.cuisine.capitalized)
                .font(.title)
            VStack{
                ForEach(self.Recipes){(recipes) in
                    HStack{
                        ForEach(recipes.Recipes){(recipe) in
                            FoodCell(food: recipe, width: width/2, height: 200, type: "featured")
                        }
                        
                    }
                    
                }
            }
        }
    }
}

//struct CuisineTypes_Previews: PreviewProvider {
//    static var previews: some View {
//        CuisineTypes(.Indian)
//    }
//}

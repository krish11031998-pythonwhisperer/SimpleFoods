//
//  DietRecipes.swift
//  SimpleFood
//
//  Created by Krishna Venkatramani on 7/10/20.
//  Copyright © 2020 Team Krish. All rights reserved.
//

import SwiftUI
struct CoupleRecipes:Identifiable{
    var id:Int;
    var Recipes:[ERecipeID];
}



struct DietRecipes: View {
    var q:String
    @ObservedObject var EFDM:EdamamAPIManager = EdamamAPIManager()
    
    init(_ q:String) {
        self.q = q
        EFDM.query = queryParams(q: q, from: 0, to: 10)
        EFDM.getResults()
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
        ScrollView(.vertical,showsIndicators: false){
            VStack(alignment: .center){
                ForEach(self.Recipes){(recipes) in
                    HStack(spacing: -2.5){
                        ForEach(recipes.Recipes){(recipe) in
                            FoodCell(food: recipe.recipe,width: UIScreen.main.bounds.width/2.3)
                        }
                    }
                }
            }.padding(.leading,5)
        }.padding(.leading,5)
        
    }
}

struct DietRecipes_Previews: PreviewProvider {
    static var previews: some View {
        DietRecipes("vegan")
    }
}

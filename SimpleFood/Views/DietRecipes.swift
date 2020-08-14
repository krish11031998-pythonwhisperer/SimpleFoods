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
    var Recipes:[SResult];
}

struct DietRecipes: View {
    @ObservedObject var SFDM:SAPIManager = SAPIManager()
    
    init(_ q:String? = nil,_ query:SQuery? = nil) {
        
        if let safeQuery = query{
          SFDM.query = safeQuery
        }else if let safeq = q{
            SFDM.query = SQuery(diet: safeq , instructionsRequired: true, addRecipeInformation: true, addRecipeNutrition: true,number: 10)
        }
        SFDM.getResults()
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
        ScrollView(.vertical,showsIndicators: false){
            VStack(alignment: .center){
                ForEach(self.Recipes){(recipes) in
                    HStack(spacing: -2.5){
                        ForEach(recipes.Recipes){(recipe) in
                            FoodCell(food: recipe,width: UIScreen.main.bounds.width/2.3)
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

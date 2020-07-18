//
//  FoodData.swift
//  SimpleFood
//
//  Created by Krishna Venkatramani on 6/13/20.
//  Copyright © 2020 Team Krish. All rights reserved.
//

import Foundation

struct FoodSearch: Codable{
    var recipes:[Food]?;
}


struct Food : Codable,Identifiable{
    var id:String{
        get{
            return self.recipe_id ?? "0"
        }
    }
    var publisher: String?;
    var title:String?;
    var source_url:String?;
    var recipe_id:String?;
    var image_url:String?;
    var publisher_url:String?;
}

struct FoodRecipe:Codable{
    var recipe:Recipe?;
}

struct Recipe : Codable{
    var ingredients : [String]?;
}

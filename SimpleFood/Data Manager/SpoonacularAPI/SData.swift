//
//  SData.swift
//  SimpleFood
//
//  Created by Krishna Venkatramani on 7/30/20.
//  Copyright © 2020 Team Krish. All rights reserved.
//

import Foundation

class CachedSRecipes{
    var recipes:[SResult]?;
    init(recipes:[SResult]) {
        self.recipes = recipes
    }
}


struct SRequest: Codable{
    var results:[SResult]?;
}


struct SResult: Identifiable, Codable{
    var id:String?;
    var vegetarian:Bool?;
    var vegan:Bool?;
    var glutenFree:Bool?;
    var dairyFree:Bool?;
    var veryHealthy:Bool?;
    var cheap:Bool?;
    var veryPopular:Bool?;
    var sustainable:Bool?;
    var preparationMinutes:Int?;
    var cookingMinutes:Int?;
    var aggregateLikes:Int?;
    var spoonacularScore:Int?;
    var healthScore:Int?;
    var creditsText:String?;
    var sourceName:String?;
    var pricePerServing:Float?;
    var title:String?;
    var readyInMinutes:Int?;
    var servings:Int?;
    var sourceUrl:String?;
    var image:String?;
    var nutrition:SNutrition?;
    var summary:String?;
    var cuisines:[String]?;
    var dishTypes: [String]?;
    var diets:[String]?;
    
}

struct SNutrition:Codable{
    var nutrients:[SNutrient]?;
    var ingredients:[SIngredient]?;
    var caloricBreakdown:SCaloricBreakdown?;
    var weightPerServing:SWeight?;
}

struct SNutrient:Codable{
    var title:String?;
    var amount:Float?;
    var unit:String?;
    var percentOfDailyNeeds:Float?;
}

struct SIngredient: Codable{
    var id:Int?;
    var name:String?;
    var amount:Float?;
    var unit:String?;
    var nutrients:[SNutrient]?;
    var localizedName:String?;
    var image:String?;
}

struct SCaloricBreakdown:Codable{
    var percentProtein:Float;
    var percentFat:Float;
    var percentCarbs:Float;
}

struct SWeight:Codable{
    var amount:Int;
    var unit:String;
}

struct SInstruction: Codable{
    var name:String?;
    var steps:[SStep]?;
}

struct SEquipment: Codable{
    var id:Int?;
    var name:String?;
    var localizedName:String?;
    var image:String?;
}

struct SLength: Codable{
    var number:Int?;
    var unit: String?;
}

struct SStep:Codable{
    var number:Int?;
    var step:String?;
    var ingredients: [SIngredient]?;
    var equipment: [SEquipment];
    var length: SLength?;
}

struct SQuery: Loopable{
    var query:String?;
    var cuisine:String?;
    var diet:String?;
    var intolerances:String?;
    var equipment:String?;
    var includeIngredients:String?;
    var excludeIngredients:String?;
    var type:String?;
    var instructionsRequired:Bool?;
    var fillIngredients:Bool?;
    var addRecipeInformation:Bool?;
    var addRecipeNutrition:Bool?;
}

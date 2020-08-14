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
    var id:Int?;
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
    var analyzedInstructions:[SSteps]?;
    
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
    
    var value:Int{
        get{
            return Int(self.amount ?? 0.0)
        }
    }
    
    var percent:Int{
        get{
            return Int(self.percentOfDailyNeeds ?? 0.0)
        }
    }
    var max:Int{
        get{
            var max = 0
            if let value = self.amount , let percent = self.percentOfDailyNeeds{
                if value<1 || percent<1{
                    max = 0
                }else{
                    max =  (Int(value)*100)/Int(percent)
                }
                
            }
            return max
        }
    }
}

struct SIngredient: Codable, Identifiable{
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
    var titleMatch:String?;
    var number:Int = 5;
    var minCarbs:Int?;
    var maxCarbs:Int?;
    var minProtein:Int?;
    var maxProtein:Int?;
    var minCalories:Int?;
    var maxCalories:Int?;
    var minFat:Int?;
    var maxFat:Int?;
}

struct SSteps:Codable{
    var steps:[SStep]?;
}

var SExample:SResult = Optional(SimpleFood.SResult(id: Optional(473243), vegetarian: Optional(true), vegan: Optional(true), glutenFree: Optional(true), dairyFree: Optional(true), veryHealthy: Optional(true), cheap: Optional(false), veryPopular: Optional(true), sustainable: Optional(false), preparationMinutes: nil, cookingMinutes: nil, aggregateLikes: Optional(3431), spoonacularScore: Optional(100), healthScore: Optional(100), creditsText: Optional("Elana\'s Pantry"), sourceName: Optional("Elana\'s Pantry"), pricePerServing: Optional(129.87), title: Optional("Green Lemonade"), readyInMinutes: Optional(45), servings: Optional(2), sourceUrl: Optional("http://www.elanaspantry.com/green-lemonade/"), image: Optional("https://spoonacular.com/recipeImages/473243-312x231.jpg"), nutrition: Optional(SimpleFood.SNutrition(nutrients: Optional([SimpleFood.SNutrient(title: Optional("Calories"), amount: Optional(112.83), unit: Optional("cal"), percentOfDailyNeeds: Optional(5.64)), SimpleFood.SNutrient(title: Optional("Fat"), amount: Optional(1.16), unit: Optional("g"), percentOfDailyNeeds: Optional(1.79)), SimpleFood.SNutrient(title: Optional("Saturated Fat"), amount: Optional(0.13), unit: Optional("g"), percentOfDailyNeeds: Optional(0.78)), SimpleFood.SNutrient(title: Optional("Carbohydrates"), amount: Optional(26.53), unit: Optional("g"), percentOfDailyNeeds: Optional(8.84)), SimpleFood.SNutrient(title: Optional("Net Carbohydrates"), amount: Optional(21.78), unit: Optional("g"), percentOfDailyNeeds: Optional(7.92)), SimpleFood.SNutrient(title: Optional("Sugar"), amount: Optional(12.87), unit: Optional("g"), percentOfDailyNeeds: Optional(14.31)), SimpleFood.SNutrient(title: Optional("Cholesterol"), amount: Optional(0.0), unit: Optional("mg"), percentOfDailyNeeds: Optional(0.0)), SimpleFood.SNutrient(title: Optional("Sodium"), amount: Optional(29.69), unit: Optional("mg"), percentOfDailyNeeds: Optional(1.29)), SimpleFood.SNutrient(title: Optional("Protein"), amount: Optional(4.5), unit: Optional("g"), percentOfDailyNeeds: Optional(9.0)), SimpleFood.SNutrient(title: Optional("Vitamin K"), amount: Optional(470.92), unit: Optional("µg"), percentOfDailyNeeds: Optional(448.5)), SimpleFood.SNutrient(title: Optional("Vitamin C"), amount: Optional(115.61), unit: Optional("mg"), percentOfDailyNeeds: Optional(140.13)), SimpleFood.SNutrient(title: Optional("Vitamin A"), amount: Optional(6662.52), unit: Optional("IU"), percentOfDailyNeeds: Optional(133.25)), SimpleFood.SNutrient(title: Optional("Copper"), amount: Optional(1.13), unit: Optional("mg"), percentOfDailyNeeds: Optional(56.27)), SimpleFood.SNutrient(title: Optional("Manganese"), amount: Optional(0.59), unit: Optional("mg"), percentOfDailyNeeds: Optional(29.3)), SimpleFood.SNutrient(title: Optional("Potassium"), amount: Optional(695.04), unit: Optional("mg"), percentOfDailyNeeds: Optional(19.86)), SimpleFood.SNutrient(title: Optional("Fiber"), amount: Optional(4.75), unit: Optional("g"), percentOfDailyNeeds: Optional(18.98)), SimpleFood.SNutrient(title: Optional("Vitamin B6"), amount: Optional(0.33), unit: Optional("mg"), percentOfDailyNeeds: Optional(16.66)), SimpleFood.SNutrient(title: Optional("Magnesium"), amount: Optional(57.42), unit: Optional("mg"), percentOfDailyNeeds: Optional(14.36)), SimpleFood.SNutrient(title: Optional("Calcium"), amount: Optional(138.0), unit: Optional("mg"), percentOfDailyNeeds: Optional(13.8)), SimpleFood.SNutrient(title: Optional("Folate"), amount: Optional(49.82), unit: Optional("µg"), percentOfDailyNeeds: Optional(12.45)), SimpleFood.SNutrient(title: Optional("Phosphorus"), amount: Optional(109.95), unit: Optional("mg"), percentOfDailyNeeds: Optional(11.0)), SimpleFood.SNutrient(title: Optional("Vitamin B1"), amount: Optional(0.16), unit: Optional("mg"), percentOfDailyNeeds: Optional(10.34)), SimpleFood.SNutrient(title: Optional("Iron"), amount: Optional(1.72), unit: Optional("mg"), percentOfDailyNeeds: Optional(9.55)), SimpleFood.SNutrient(title: Optional("Vitamin B2"), amount: Optional(0.16), unit: Optional("mg"), percentOfDailyNeeds: Optional(9.2)), SimpleFood.SNutrient(title: Optional("Vitamin B5"), amount: Optional(0.58), unit: Optional("mg"), percentOfDailyNeeds: Optional(5.77)), SimpleFood.SNutrient(title: Optional("Zinc"), amount: Optional(0.69), unit: Optional("mg"), percentOfDailyNeeds: Optional(4.59)), SimpleFood.SNutrient(title: Optional("Vitamin B3"), amount: Optional(0.84), unit: Optional("mg"), percentOfDailyNeeds: Optional(4.21)), SimpleFood.SNutrient(title: Optional("Vitamin E"), amount: Optional(0.29), unit: Optional("mg"), percentOfDailyNeeds: Optional(1.93)), SimpleFood.SNutrient(title: Optional("Selenium"), amount: Optional(0.95), unit: Optional("µg"), percentOfDailyNeeds: Optional(1.36))]), ingredients: Optional([SimpleFood.SIngredient(id: nil, name: Optional("cucumber"), amount: Optional(0.5), unit: Optional(""), nutrients: Optional([SimpleFood.SNutrient(title: nil, amount: Optional(0.24), unit: Optional("g"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.05), unit: Optional("mg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.0), unit: Optional("µg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.0), unit: Optional("g"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.36), unit: Optional("mg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(3.0), unit: Optional("mg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(8.55), unit: Optional("mg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.26), unit: Optional("mg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(18.0), unit: Optional("mg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.11), unit: Optional("mg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(2.19), unit: Optional("g"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(10.8), unit: Optional("µg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.02), unit: Optional("g"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(18.0), unit: Optional("cal"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(3.24), unit: Optional("g"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.06), unit: Optional("mg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(21.0), unit: Optional("mg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(1.95), unit: Optional("mg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(4.8), unit: Optional("mg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.04), unit: Optional("mg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.0), unit: Optional("µg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(1.05), unit: Optional("g"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(31.5), unit: Optional("mg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.89), unit: Optional("g"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(204.0), unit: Optional("mg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.33), unit: Optional("mg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.15), unit: Optional("µg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(2.07), unit: Optional("g"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.11), unit: Optional("mg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.08), unit: Optional("mg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.0), unit: Optional("g"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(21.0), unit: Optional("µg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.0), unit: Optional("mg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.0), unit: Optional("mg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.0), unit: Optional("g"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.0), unit: Optional("µg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(108.0), unit: Optional("IU"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.05), unit: Optional("mg"), percentOfDailyNeeds: nil)]), localizedName: nil, image: nil), SimpleFood.SIngredient(id: nil, name: Optional("granny smith apple"), amount: Optional(0.5), unit: Optional(""), nutrients: Optional([SimpleFood.SNutrient(title: nil, amount: Optional(0.15), unit: Optional("g"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.16), unit: Optional("mg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.0), unit: Optional("µg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.01), unit: Optional("g"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.06), unit: Optional("mg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.91), unit: Optional("mg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(3.09), unit: Optional("mg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.04), unit: Optional("mg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(4.55), unit: Optional("mg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.02), unit: Optional("mg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(10.38), unit: Optional("g"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(2.0), unit: Optional("µg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.03), unit: Optional("g"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(47.32), unit: Optional("cal"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(12.57), unit: Optional("g"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.08), unit: Optional("mg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(5.46), unit: Optional("mg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(3.0), unit: Optional("mg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(4.19), unit: Optional("mg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.02), unit: Optional("mg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.0), unit: Optional("µg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(2.18), unit: Optional("g"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(10.01), unit: Optional("mg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.24), unit: Optional("g"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(97.37), unit: Optional("mg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.11), unit: Optional("mg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.0), unit: Optional("µg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(9.45), unit: Optional("g"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.03), unit: Optional("mg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.04), unit: Optional("mg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.05), unit: Optional("g"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(2.73), unit: Optional("µg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.0), unit: Optional("mg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.0), unit: Optional("mg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.0), unit: Optional("g"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.0), unit: Optional("µg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(49.14), unit: Optional("IU"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.02), unit: Optional("mg"), percentOfDailyNeeds: nil)]), localizedName: nil, image: nil), SimpleFood.SIngredient(id: nil, name: Optional("kale"), amount: Optional(0.5), unit: Optional("bunch"), nutrients: Optional([SimpleFood.SNutrient(title: nil, amount: Optional(0.6), unit: Optional("g"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.0), unit: Optional("µg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.03), unit: Optional("g"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.06), unit: Optional("mg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(24.7), unit: Optional("mg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.36), unit: Optional("mg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(30.55), unit: Optional("mg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.97), unit: Optional("mg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(5.69), unit: Optional("g"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(458.12), unit: Optional("µg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.06), unit: Optional("g"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(31.85), unit: Optional("cal"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(5.69), unit: Optional("g"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.65), unit: Optional("mg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(97.5), unit: Optional("mg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(78.0), unit: Optional("mg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.08), unit: Optional("mg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.0), unit: Optional("µg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(59.8), unit: Optional("mg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(2.78), unit: Optional("g"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(319.15), unit: Optional("mg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.96), unit: Optional("mg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.59), unit: Optional("µg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.43), unit: Optional("mg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.18), unit: Optional("mg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.22), unit: Optional("g"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(20.15), unit: Optional("µg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.0), unit: Optional("mg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.0), unit: Optional("g"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.0), unit: Optional("µg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(6493.5), unit: Optional("IU"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.07), unit: Optional("mg"), percentOfDailyNeeds: nil)]), localizedName: nil, image: nil), SimpleFood.SIngredient(id: nil, name: Optional("lemon"), amount: Optional(0.5), unit: Optional(""), nutrients: Optional([SimpleFood.SNutrient(title: nil, amount: Optional(0.16), unit: Optional("g"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.08), unit: Optional("mg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.0), unit: Optional("µg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.01), unit: Optional("g"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.1), unit: Optional("mg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(1.08), unit: Optional("mg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(2.75), unit: Optional("mg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.03), unit: Optional("mg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(4.32), unit: Optional("mg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.02), unit: Optional("mg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(3.52), unit: Optional("g"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.0), unit: Optional("µg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.02), unit: Optional("g"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(15.66), unit: Optional("cal"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(5.03), unit: Optional("g"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.05), unit: Optional("mg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(14.04), unit: Optional("mg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(28.62), unit: Optional("mg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.01), unit: Optional("mg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.0), unit: Optional("µg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(1.51), unit: Optional("g"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(8.64), unit: Optional("mg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.59), unit: Optional("g"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(74.52), unit: Optional("mg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.32), unit: Optional("mg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.22), unit: Optional("µg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(1.35), unit: Optional("g"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.02), unit: Optional("mg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.04), unit: Optional("mg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.05), unit: Optional("g"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(5.94), unit: Optional("µg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.0), unit: Optional("mg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.0), unit: Optional("mg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.0), unit: Optional("g"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.0), unit: Optional("µg"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(11.88), unit: Optional("IU"), percentOfDailyNeeds: nil), SimpleFood.SNutrient(title: nil, amount: Optional(0.02), unit: Optional("mg"), percentOfDailyNeeds: nil)]), localizedName: nil, image: nil)]), caloricBreakdown: Optional(SimpleFood.SCaloricBreakdown(percentProtein: 13.37, percentFat: 7.77, percentCarbs: 78.86)), weightPerServing: Optional(SimpleFood.SWeight(amount: 360, unit: "g")))), summary: Optional("You can never have too many beverage recipes, so give Green Lemonade a try. One serving contains <b>113 calories</b>, <b>4g of protein</b>, and <b>1g of fat</b>. This caveman, gluten free, primal, and whole 30 recipe serves 2 and costs <b>$1.3 per serving</b>. Many people made this recipe, and 3431 would say it hit the spot. From preparation to the plate, this recipe takes approximately <b>45 minutes</b>. A mixture of lemon, granny smith apple, kale, and a handful of other ingredients are all it takes to make this recipe so flavorful. All things considered, we decided this recipe <b>deserves a spoonacular score of 100%</b>. This score is tremendous. Try <a href=\"https://spoonacular.com/recipes/juicing-s-green-lemonade-485633\">Juicing s | Green Lemonade</a>, <a href=\"https://spoonacular.com/recipes/berry-lemonade-green-smoothie-539728\">Berry Lemonade Green Smoothie</a>, and <a href=\"https://spoonacular.com/recipes/green-bean-slaw-with-cabbage-cherries-and-lemonade-dressing-810030\">Green Bean Slaw with Cabbage, Cherries, and Lemonade Dressing</a> for similar recipes."), cuisines: Optional([]), dishTypes: Optional(["side dish"]), diets: Optional(["gluten free", "dairy free", "paleolithic", "lacto ovo vegetarian", "primal", "vegan"]), analyzedInstructions: Optional([SimpleFood.SSteps(steps: Optional([SimpleFood.SStep(number: Optional(1), step: Optional("Juice all ingredients"), ingredients: Optional([SimpleFood.SIngredient(id: Optional(1019016), name: Optional("juice"), amount: nil, unit: nil, nutrients: nil, localizedName: Optional("juice"), image: Optional("apple-juice.jpg"))]), equipment: [], length: nil), SimpleFood.SStep(number: Optional(2), step: Optional("Place green lemonade in glasses"), ingredients: Optional([SimpleFood.SIngredient(id: Optional(99184), name: Optional("lemonade"), amount: nil, unit: nil, nutrients: nil, localizedName: Optional("lemonade"), image: Optional("lemonade.jpg"))]), equipment: [], length: nil), SimpleFood.SStep(number: Optional(3), step: Optional("Serve"), ingredients: Optional([]), equipment: [], length: nil)]))])))!

//
//  EdamamEnums.swift
//  SimpleFood
//
//  Created by Krishna Venkatramani on 6/28/20.
//  Copyright © 2020 Team Krish. All rights reserved.
//

import Foundation

struct queryParams{
    var q:String="";
    var from:Int=0;
    var to:Int=10;
    var diet:[Diet]?;
    var health:[Health]?;
    var cuisineType:[Cuisine]?;
    var calories:Range?;
    var time:Range?;
    var excluded:String?;
    
}

enum Diet:String{
    case Balanced = "balanced"
    case High_Fiber = "high-fiber"
    case High_Protein = "high-protein"
    case Low_Carb = "low-carb"
    case Low_Sodium = "low-sodium"
}

enum Health:String{
    case Alcohol_free = "alcohol-free"
    case Immune_Supportive = "immuno-supportive"
    case Celery_free = "celery-free"
    case Crustcean_free = "crustacean-free"
    case Dairy = "dairy-free"
    case Eggs = "egg-free"
    case Fish = "fish-free"
    case FODMAP_free = "fodmap-free"
    case Gluten = "gluten-free"
    case Keto = "keto-friendly"
    case Kidney_friendly = "kidney-friendly"
    case Kosher = "kosher"
    case Low_potassium = "low-potassium"
    case Lupine_free = "lupine-free"
    case Mustard_free = "mustard-free"
    case No_oil_added = "No-oil-added"
    case No_sugar = "low-sugar"
    case Paleo = "paleo"
    case Peanuts = "peanut-free"
    case Pescatarian = "pecatarian"
    case Pork_free = "pork-free"
    case Sesame_free = "sesame-free"
    case Shellfish = "shellfish-free"
    case Soy = "soy-free"
    case Sugar_conscious = "sugar-conscious"
    case Tree_Nuts = "tree-nut-free"
    case Vegan = "vegan"
    case Vegetarian = "vegetarian"
    case Wheat_free = "wheat-free"
}

enum Meal:String{
    case Breakfast = "breakfast"
    case Lunch = "lunch"
    case Dinner = "dinner"
    case Snack = "snack"
    case TeaTime = "teatime"
}

enum Dish:String{
    case Bread = "bread"
    case Cereals = "cereals"
    case Drinks = "drinks"
    case Dessert = "dessert"
    case Pancake = "pancake"
    case Preps = "preps"
    case Preserve = "preserve"
    case Salad = "salad"
    case Sandwiches = "sandwiches"
    case Side_Dish = "side dish"
    case Soup = "soup"
    case Starter = "starter"
    case Sweets = "sweets"
}

enum Cuisine:String{
    case American = "american"
    case Asian = "asian"
    case British = "british"
    case Caribbean = "caribbean"
    case Central_Europe = "central_europe"
    case French = "french"
    case Indian = "indian"
    case Italian = "italian"
    case Japanese = "japanese"
    case Kosher = "kosher"
    case Mediterranean = "mediterranean"
    case Mexican = "mexican"
    case Middle_Eastern = "middle_eastern"
    case Nordic = "nordic"
    case South_American = "south_american"
    case South_East_Asian = "south east asian"
}


struct Range{
    var min:Int?;
    var max:Int?;
}

var NutrientType:[String:String] = ["sugar" : "SUGAR", "fat":"FAT","energy": "ENERC_KCAL","carbs":"CHOCDF","protein":"PROCNT","fiber":"FIBTG"]

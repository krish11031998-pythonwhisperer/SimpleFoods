//
//  EdamamData.swift
//  SimpleFood
//
//  Created by Krishna Venkatramani on 6/28/20.
//  Copyright © 2020 Team Krish. All rights reserved.
//

import Foundation

struct EdamamRecipeResult:Codable{
    var hits:[Hit]?;
}

struct Hit:Codable{
    var recipe:EdamamRecipe?;
}

//struct EdamamSingleResult:Codable{
//    var
//}

class CachedRecipes{
    var recipes:[ERecipeID]?;
    init(recipes:[ERecipeID]) {
        self.recipes = recipes
    }
}

var edamamExamples:[ERecipeID] = [ERecipeID(id: 1, recipe: edamamExample!),ERecipeID(id: 2, recipe: edamamExample!)]
struct EdamamRecipe:Codable{
    var label:String?;
    var image:String?;
    var source:String?;
    var uri:String?;
    var url:String?;
    var yield:Int?;
    var totalTime:Int?;
    var calories:Float?;
    var totalWeight:Float?;
    var totalNutrients:[String:EdamamNutrient]?;
    var totalDaily:[String:EdamamNutrient]?;
    var ingredients:[EdamamIngredient]?;
    var dietLabels:[String]?;
    var healthLabels:[String]?;
    var digest:[EdamamDigestNutrient]?;
    
    func parseDigest() -> [String:EdamamDigestNutrient]{
        var finalDigest:[String:EdamamDigestNutrient] = [:]
        guard let safeDigest = self.digest else {return [:]}
        safeDigest.forEach { (nutrient) in
            if let nutrientTag = nutrient.tag{
                finalDigest[nutrientTag] = nutrient
            }
            if let sub = nutrient.sub{
                sub.forEach { (nutri) in
                    if let nutriTag = nutri.tag{
                        finalDigest[nutriTag] = nutri;
                    }
                }
            }
        }
        return finalDigest
    }
}

struct ERecipeID:Identifiable{
    var id:Int;
    var recipe:EdamamRecipe;
}

struct EdamamIngredient:Codable{
    var text:String?;
    var weight:Float?;
}

struct EIngredientID:Identifiable{
    var id:Int;
    var details:EdamamIngredient;
}

struct EdamamMeasure:Codable{
    var uri:String?;
    var label:String?;
}

struct EdamamNutrient:Codable{
    var label:String?;
    var quantity:Float?;
    var unit:String?;
}

struct EdamamDigestNutrient:Codable{
    var label:String?;
    var tag:String?;
    var total:Double?;
    var daily:Double?;
    var unit:String?;
    var sub:[EdamamDigestNutrient]?
}

struct EdamamSingleRecipe:Codable{
    var recipe:[EdamamRecipe]?;
}

var edamamExample = Optional(SimpleFood.EdamamRecipe(label: Optional("pasta with garlicky broccoli rabe"), image: Optional("https://www.edamam.com/web-img/02e/02e10d13b190f11c12c1722af85a220e.jpg"), source: Optional("Smitten Kitchen"), url: Optional("https://smittenkitchen.com/2012/04/pasta-with-garlicky-broccoli-rabe/"), yield: Optional(10), totalTime: Optional(0), calories: Optional(2760.9368), totalWeight: Optional(1035.4243), totalNutrients: Optional(["VITB6A": SimpleFood.EdamamNutrient(label: Optional("Vitamin B6"), quantity: Optional(1.608116), unit: Optional("mg")), "PROCNT": SimpleFood.EdamamNutrient(label: Optional("Protein"), quantity: Optional(74.5221), unit: Optional("g")), "FAPU": SimpleFood.EdamamNutrient(label: Optional("Polyunsaturated"), quantity: Optional(14.561988), unit: Optional("g")), "FASAT": SimpleFood.EdamamNutrient(label: Optional("Saturated"), quantity: Optional(16.41237), unit: Optional("g")), "VITD": SimpleFood.EdamamNutrient(label: Optional("Vitamin D"), quantity: Optional(0.0), unit: Optional("µg")), "CA": SimpleFood.EdamamNutrient(label: Optional("Calcium"), quantity: Optional(614.7026), unit: Optional("mg")), "FE": SimpleFood.EdamamNutrient(label: Optional("Iron"), quantity: Optional(16.502676), unit: Optional("mg")), "NA": SimpleFood.EdamamNutrient(label: Optional("Sodium"), quantity: Optional(2063.3396), unit: Optional("mg")), "VITA_RAE": SimpleFood.EdamamNutrient(label: Optional("Vitamin A"), quantity: Optional(599.3089), unit: Optional("µg")), "FOLFD": SimpleFood.EdamamNutrient(label: Optional("Folate (food)"), quantity: Optional(458.77484), unit: Optional("µg")), "THIA": SimpleFood.EdamamNutrient(label: Optional("Thiamin (B1)"), quantity: Optional(1.173365), unit: Optional("mg")), "NIA": SimpleFood.EdamamNutrient(label: Optional("Niacin (B3)"), quantity: Optional(13.387845), unit: Optional("mg")), "VITC": SimpleFood.EdamamNutrient(label: Optional("Vitamin C"), quantity: Optional(96.42668), unit: Optional("mg")), "FAMS": SimpleFood.EdamamNutrient(label: Optional("Monounsaturated"), quantity: Optional(79.69491), unit: Optional("g")), "WATER": SimpleFood.EdamamNutrient(label: Optional("Water"), quantity: Optional(473.52966), unit: Optional("g")), "K": SimpleFood.EdamamNutrient(label: Optional("Potassium"), quantity: Optional(1969.3777), unit: Optional("mg")), "CHOLE": SimpleFood.EdamamNutrient(label: Optional("Cholesterol"), quantity: Optional(0.0), unit: Optional("mg")), "ENERC_KCAL": SimpleFood.EdamamNutrient(label: Optional("Energy"), quantity: Optional(2760.9368), unit: Optional("kcal")), "CHOCDF": SimpleFood.EdamamNutrient(label: Optional("Carbs"), quantity: Optional(356.85306), unit: Optional("g")), "MG": SimpleFood.EdamamNutrient(label: Optional("Magnesium"), quantity: Optional(344.332), unit: Optional("mg")), "FOLDFE": SimpleFood.EdamamNutrient(label: Optional("Folate equivalent (total)"), quantity: Optional(458.77484), unit: Optional("µg")), "SUGAR": SimpleFood.EdamamNutrient(label: Optional("Sugars"), quantity: Optional(14.142819), unit: Optional("g")), "FOLAC": SimpleFood.EdamamNutrient(label: Optional("Folic acid"), quantity: Optional(0.0), unit: Optional("µg")), "VITK1": SimpleFood.EdamamNutrient(label: Optional("Vitamin K"), quantity: Optional(1082.1885), unit: Optional("µg")), "TOCPHA": SimpleFood.EdamamNutrient(label: Optional("Vitamin E"), quantity: Optional(23.36925), unit: Optional("mg")), "ZN": SimpleFood.EdamamNutrient(label: Optional("Zinc"), quantity: Optional(10.071099), unit: Optional("mg")), "VITB12": SimpleFood.EdamamNutrient(label: Optional("Vitamin B12"), quantity: Optional(0.0), unit: Optional("µg")), "RIBF": SimpleFood.EdamamNutrient(label: Optional("Riboflavin (B2)"), quantity: Optional(0.8784338), unit: Optional("mg")), "P": SimpleFood.EdamamNutrient(label: Optional("Phosphorus"), quantity: Optional(1211.9749), unit: Optional("mg")), "FATRN": SimpleFood.EdamamNutrient(label: Optional("Trans"), quantity: Optional(0.0), unit: Optional("g")), "FIBTG": SimpleFood.EdamamNutrient(label: Optional("Fiber"), quantity: Optional(27.187565), unit: Optional("g")), "FAT": SimpleFood.EdamamNutrient(label: Optional("Fat"), quantity: Optional(117.16924), unit: Optional("g"))]), totalDaily: Optional(["VITD": SimpleFood.EdamamNutrient(label: Optional("Vitamin D"), quantity: Optional(0.0), unit: Optional("%")), "ZN": SimpleFood.EdamamNutrient(label: Optional("Zinc"), quantity: Optional(91.55544), unit: Optional("%")), "P": SimpleFood.EdamamNutrient(label: Optional("Phosphorus"), quantity: Optional(173.13927), unit: Optional("%")), "VITA_RAE": SimpleFood.EdamamNutrient(label: Optional("Vitamin A"), quantity: Optional(66.58988), unit: Optional("%")), "CA": SimpleFood.EdamamNutrient(label: Optional("Calcium"), quantity: Optional(61.47026), unit: Optional("%")), "VITK1": SimpleFood.EdamamNutrient(label: Optional("Vitamin K"), quantity: Optional(901.8238), unit: Optional("%")), "VITB12": SimpleFood.EdamamNutrient(label: Optional("Vitamin B12"), quantity: Optional(0.0), unit: Optional("%")), "RIBF": SimpleFood.EdamamNutrient(label: Optional("Riboflavin (B2)"), quantity: Optional(67.57184), unit: Optional("%")), "VITB6A": SimpleFood.EdamamNutrient(label: Optional("Vitamin B6"), quantity: Optional(123.70123), unit: Optional("%")), "PROCNT": SimpleFood.EdamamNutrient(label: Optional("Protein"), quantity: Optional(149.0442), unit: Optional("%")), "FASAT": SimpleFood.EdamamNutrient(label: Optional("Saturated"), quantity: Optional(82.06185), unit: Optional("%")), "MG": SimpleFood.EdamamNutrient(label: Optional("Magnesium"), quantity: Optional(81.9838), unit: Optional("%")), "CHOLE": SimpleFood.EdamamNutrient(label: Optional("Cholesterol"), quantity: Optional(0.0), unit: Optional("%")), "FOLDFE": SimpleFood.EdamamNutrient(label: Optional("Folate equivalent (total)"), quantity: Optional(114.69371), unit: Optional("%")), "THIA": SimpleFood.EdamamNutrient(label: Optional("Thiamin (B1)"), quantity: Optional(97.78041), unit: Optional("%")), "ENERC_KCAL": SimpleFood.EdamamNutrient(label: Optional("Energy"), quantity: Optional(138.04684), unit: Optional("%")), "K": SimpleFood.EdamamNutrient(label: Optional("Potassium"), quantity: Optional(41.901653), unit: Optional("%")), "TOCPHA": SimpleFood.EdamamNutrient(label: Optional("Vitamin E"), quantity: Optional(155.795), unit: Optional("%")), "VITC": SimpleFood.EdamamNutrient(label: Optional("Vitamin C"), quantity: Optional(107.140755), unit: Optional("%")), "CHOCDF": SimpleFood.EdamamNutrient(label: Optional("Carbs"), quantity: Optional(118.95102), unit: Optional("%")), "FIBTG": SimpleFood.EdamamNutrient(label: Optional("Fiber"), quantity: Optional(108.75026), unit: Optional("%")), "FE": SimpleFood.EdamamNutrient(label: Optional("Iron"), quantity: Optional(91.68153), unit: Optional("%")), "NA": SimpleFood.EdamamNutrient(label: Optional("Sodium"), quantity: Optional(85.97249), unit: Optional("%")), "NIA": SimpleFood.EdamamNutrient(label: Optional("Niacin (B3)"), quantity: Optional(83.674034), unit: Optional("%")), "FAT": SimpleFood.EdamamNutrient(label: Optional("Fat"), quantity: Optional(180.26038), unit: Optional("%"))]), ingredients: Optional([SimpleFood.EdamamIngredient(text: Optional("1 pound pasta, whatever shape you like (but chunky ones will match up better with the rabe)"), weight: Optional(453.59238)), SimpleFood.EdamamIngredient(text: Optional("1 pound broccoli rabe, heavy stems removed, remaining stems and leaves cut into 1- to 2-inch sections (I attempt to match my pasta in length)"), weight: Optional(453.59238)), SimpleFood.EdamamIngredient(text: Optional("1/2 cup olive oil"), weight: Optional(108.0)), SimpleFood.EdamamIngredient(text: Optional("5 garlic cloves, peeled and minced or pressed"), weight: Optional(15.0)), SimpleFood.EdamamIngredient(text: Optional("1/2 teaspoon red pepper flakes, or more or less to taste"), weight: Optional(0.38541666)), SimpleFood.EdamamIngredient(text: Optional("About 1 heaping teaspoon Kosher salt (or more to taste)"), weight: Optional(4.8541665))]), dietLabels: Optional(["Balanced"]), healthLabels: Optional(["Sugar-Conscious", "Vegan", "Vegetarian", "Peanut-Free", "Tree-Nut-Free", "Alcohol-Free"]), digest: Optional([SimpleFood.EdamamDigestNutrient(label: Optional("Fat"), tag: Optional("FAT"), total: Optional(117.16924010833446), daily: Optional(180.26036939743764), unit: Optional("g"), sub: Optional([SimpleFood.EdamamDigestNutrient(label: Optional("Saturated"), tag: Optional("FASAT"), total: Optional(16.41237048740016), daily: Optional(82.0618524370008), unit: Optional("g"), sub: nil), SimpleFood.EdamamDigestNutrient(label: Optional("Trans"), tag: Optional("FATRN"), total: Optional(0.0), daily: Optional(0.0), unit: Optional("g"), sub: nil), SimpleFood.EdamamDigestNutrient(label: Optional("Monounsaturated"), tag: Optional("FAMS"), total: Optional(79.6949107189001), daily: Optional(0.0), unit: Optional("g"), sub: nil), SimpleFood.EdamamDigestNutrient(label: Optional("Polyunsaturated"), tag: Optional("FAPU"), total: Optional(14.56198802696727), daily: Optional(0.0), unit: Optional("g"), sub: nil)])), SimpleFood.EdamamDigestNutrient(label: Optional("Carbs"), tag: Optional("CHOCDF"), total: Optional(356.85305730734706), daily: Optional(118.95101910244901), unit: Optional("g"), sub: Optional([SimpleFood.EdamamDigestNutrient(label: Optional("Carbs (net)"), tag: Optional("CHOCDF.net"), total: Optional(329.6654928940081), daily: Optional(0.0), unit: Optional("g"), sub: nil), SimpleFood.EdamamDigestNutrient(label: Optional("Fiber"), tag: Optional("FIBTG"), total: Optional(27.18756441333895), daily: Optional(108.7502576533558), unit: Optional("g"), sub: nil), SimpleFood.EdamamDigestNutrient(label: Optional("Sugars"), tag: Optional("SUGAR"), total: Optional(14.142819368341362), daily: Optional(0.0), unit: Optional("g"), sub: nil), SimpleFood.EdamamDigestNutrient(label: Optional("Sugars, added"), tag: Optional("SUGAR.added"), total: Optional(0.0), daily: Optional(0.0), unit: Optional("g"), sub: nil)])), SimpleFood.EdamamDigestNutrient(label: Optional("Protein"), tag: Optional("PROCNT"), total: Optional(74.5221002603354), daily: Optional(149.0442005206708), unit: Optional("g"), sub: nil), SimpleFood.EdamamDigestNutrient(label: Optional("Cholesterol"), tag: Optional("CHOLE"), total: Optional(0.0), daily: Optional(0.0), unit: Optional("mg"), sub: nil), SimpleFood.EdamamDigestNutrient(label: Optional("Sodium"), tag: Optional("NA"), total: Optional(2063.339670228777), daily: Optional(85.97248625953237), unit: Optional("mg"), sub: nil), SimpleFood.EdamamDigestNutrient(label: Optional("Calcium"), tag: Optional("CA"), total: Optional(614.702594800068), daily: Optional(61.4702594800068), unit: Optional("mg"), sub: nil), SimpleFood.EdamamDigestNutrient(label: Optional("Magnesium"), tag: Optional("MG"), total: Optional(344.331985833353), daily: Optional(81.98380615079833), unit: Optional("mg"), sub: nil), SimpleFood.EdamamDigestNutrient(label: Optional("Potassium"), tag: Optional("K"), total: Optional(1969.3776553003856), daily: Optional(41.90165224043374), unit: Optional("mg"), sub: nil), SimpleFood.EdamamDigestNutrient(label: Optional("Iron"), tag: Optional("FE"), total: Optional(16.502675444668665), daily: Optional(91.68153024815925), unit: Optional("mg"), sub: nil), SimpleFood.EdamamDigestNutrient(label: Optional("Zinc"), tag: Optional("ZN"), total: Optional(10.071099082667114), daily: Optional(91.55544620606467), unit: Optional("mg"), sub: nil), SimpleFood.EdamamDigestNutrient(label: Optional("Phosphorus"), tag: Optional("P"), total: Optional(1211.9748219000314), daily: Optional(173.13926027143305), unit: Optional("mg"), sub: nil), SimpleFood.EdamamDigestNutrient(label: Optional("Vitamin A"), tag: Optional("VITA_RAE"), total: Optional(599.3089213669256), daily: Optional(66.58988015188062), unit: Optional("µg"), sub: nil), SimpleFood.EdamamDigestNutrient(label: Optional("Vitamin C"), tag: Optional("VITC"), total: Optional(96.42667957333948), daily: Optional(107.14075508148831), unit: Optional("mg"), sub: nil), SimpleFood.EdamamDigestNutrient(label: Optional("Thiamin (B1)"), tag: Optional("THIA"), total: Optional(1.173364959900016), daily: Optional(97.78041332500133), unit: Optional("mg"), sub: nil), SimpleFood.EdamamDigestNutrient(label: Optional("Riboflavin (B2)"), tag: Optional("RIBF"), total: Optional(0.878433850133569), daily: Optional(67.57183462565915), unit: Optional("mg"), sub: nil), SimpleFood.EdamamDigestNutrient(label: Optional("Niacin (B3)"), tag: Optional("NIA"), total: Optional(13.38784489853503), daily: Optional(83.67403061584395), unit: Optional("mg"), sub: nil), SimpleFood.EdamamDigestNutrient(label: Optional("Vitamin B6"), tag: Optional("VITB6A"), total: Optional(1.6081159931001583), daily: Optional(123.7012302384737), unit: Optional("mg"), sub: nil), SimpleFood.EdamamDigestNutrient(label: Optional("Folate equivalent (total)"), tag: Optional("FOLDFE"), total: Optional(458.77485620001), daily: Optional(114.69371405000248), unit: Optional("µg"), sub: nil), SimpleFood.EdamamDigestNutrient(label: Optional("Folate (food)"), tag: Optional("FOLFD"), total: Optional(458.77485620001), daily: Optional(0.0), unit: Optional("µg"), sub: nil), SimpleFood.EdamamDigestNutrient(label: Optional("Folic acid"), tag: Optional("FOLAC"), total: Optional(0.0), daily: Optional(0.0), unit: Optional("µg"), sub: nil), SimpleFood.EdamamDigestNutrient(label: Optional("Vitamin B12"), tag: Optional("VITB12"), total: Optional(0.0), daily: Optional(0.0), unit: Optional("µg"), sub: nil), SimpleFood.EdamamDigestNutrient(label: Optional("Vitamin D"), tag: Optional("VITD"), total: Optional(0.0), daily: Optional(0.0), unit: Optional("µg"), sub: nil), SimpleFood.EdamamDigestNutrient(label: Optional("Vitamin E"), tag: Optional("TOCPHA"), total: Optional(23.36925008433395), daily: Optional(155.79500056222633), unit: Optional("mg"), sub: nil), SimpleFood.EdamamDigestNutrient(label: Optional("Vitamin K"), tag: Optional("VITK1"), total: Optional(1082.1885220033546), daily: Optional(901.8237683361289), unit: Optional("µg"), sub: nil), SimpleFood.EdamamDigestNutrient(label: Optional("Sugar alcohols"), tag: Optional("Sugar.alcohol"), total: Optional(0.0), daily: Optional(0.0), unit: Optional("g"), sub: nil), SimpleFood.EdamamDigestNutrient(label: Optional("Water"), tag: Optional("WATER"), total: Optional(473.5296486900019), daily: Optional(0.0), unit: Optional("g"), sub: nil)])))

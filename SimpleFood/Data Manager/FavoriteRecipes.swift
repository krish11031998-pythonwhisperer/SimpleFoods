//
//  FavoriteRecipes.swift
//  SimpleFood
//
//  Created by Krishna Venkatramani on 7/10/20.
//  Copyright © 2020 Team Krish. All rights reserved.
//

import Foundation
import RealmSwift



class RealmRecipe : Object{
    @objc dynamic var id:Int = 0;
    @objc dynamic var vegetarian:Bool = false;
    @objc dynamic var vegan:Bool = false;
    @objc dynamic var glutenFree:Bool = false;
    @objc dynamic var dairyFree:Bool = false;
    @objc dynamic var veryHealthy:Bool = false;
    @objc dynamic var cheap:Bool = false;
    @objc dynamic var veryPopular:Bool = false;
    @objc dynamic var sustainable:Bool = false;
    @objc dynamic var preparationMinutes:Int = 0;
    @objc dynamic var cookingMinutes:Int = 0;
    @objc dynamic var aggregateLikes:Int = 0;
    @objc dynamic var spoonacularScore:Int = 0;
    @objc dynamic var healthScore:Int = 0;
    @objc dynamic var creditsText:String = "";
    @objc dynamic var sourceName:String = "";
    @objc dynamic var pricePerServing:Float = 0;
    @objc dynamic var title:String = "";
    @objc dynamic var readyInMinutes:Int = 0;
    @objc dynamic var servings:Int = 0;
    @objc dynamic var sourceUrl:String = "";
    @objc dynamic var image:String = "";
    @objc dynamic var nutrition:RealmSNutrition?;
    @objc dynamic var summary:String = "";
    var cuisines:[String] = [];
    var dishTypes: [String] = [];
    var diets:[String] = [];
    var analyzedInstructions:[RealmSSteps] = [];
    
    static func parseData(_ recipe:SResult) -> RealmRecipe{
        var newRecipe = RealmRecipe()
        if let id =  recipe.id, let vegetarian = recipe.vegetarian , let vegan =  recipe.vegan, let glutenFree = recipe.glutenFree, let dairyFree = recipe.dairyFree, let veryHealthy =  recipe.veryHealthy,let cheap = recipe.cheap, let veryPopular = recipe.veryPopular,let sustainable = recipe.sustainable,let preparationMinutes = recipe.preparationMinutes,let cookingMinutes = recipe.cookingMinutes,let aggregateLikes = recipe.aggregateLikes,let spoonacularScore = recipe.spoonacularScore,let healthScore = recipe.healthScore,let creditsText = recipe.creditsText,let sourceName = recipe.sourceName, let pricePerServing =  recipe.pricePerServing,let readyInMinutes = recipe.readyInMinutes,let servings = recipe.servings,let sourceUrl =  recipe.sourceUrl,let image =  recipe.image ,let title = recipe.title, let summary = recipe.summary, let cuisines = recipe.cuisines, let dishTypes = recipe.dishTypes, let diets = recipe.diets, let nutrition = recipe.nutrition, let analyzedInstructions = recipe.analyzedInstructions{
            newRecipe.id = id;
            newRecipe.vegetarian = vegetarian;
            newRecipe.vegan = vegan;
            newRecipe.glutenFree = glutenFree;
            newRecipe.dairyFree = dairyFree;
            newRecipe.veryHealthy = veryHealthy;
            newRecipe.cheap = cheap;
            newRecipe.veryPopular = veryPopular;
            newRecipe.sustainable = sustainable;
            newRecipe.preparationMinutes = preparationMinutes;
            newRecipe.cookingMinutes = cookingMinutes;
            newRecipe.aggregateLikes = aggregateLikes;
            newRecipe.spoonacularScore = spoonacularScore;
            newRecipe.healthScore = healthScore;
            newRecipe.creditsText = creditsText;
            newRecipe.sourceName = sourceName;
            newRecipe.pricePerServing = pricePerServing;
            newRecipe.readyInMinutes = readyInMinutes;
            newRecipe.servings = servings;
            newRecipe.sourceUrl = sourceUrl;
            newRecipe.image = image;
            newRecipe.title = title;
            newRecipe.image = image;
            newRecipe.summary = summary;
//            newRecipe.cuisines = cuisines;
//            newRecipe.dishTypes = dishTypes;
//            newRecipe.diets = diets;
            newRecipe.nutrition = RealmSNutrition.parseData(nutrition)
            newRecipe.analyzedInstructions = RealmSSteps.parseArrayData(analyzedInstructions)
        }
        return newRecipe
    }
    
    static func parseArrayBack(_ ARR:[RealmRecipe]) -> [SResult]{
        return ARR.map({(rr) -> SResult in return RealmRecipe.parseBack(rr)})
    }
    
    static func parseBack(_ RR:RealmRecipe) -> SResult{
        return SResult(id: RR.id, vegetarian: RR.vegetarian, vegan: RR.vegan, glutenFree: RR.glutenFree, dairyFree: RR.dairyFree, veryHealthy: RR.veryHealthy, cheap: RR.cheap, veryPopular: RR.veryPopular, sustainable: RR.sustainable, preparationMinutes: RR.preparationMinutes, cookingMinutes: RR.cookingMinutes, aggregateLikes: RR.aggregateLikes, spoonacularScore: RR.spoonacularScore, healthScore: RR.healthScore, creditsText: RR.creditsText, sourceName: RR.sourceName, pricePerServing: RR.pricePerServing, title: RR.title, readyInMinutes: RR.readyInMinutes, servings: RR.servings, sourceUrl: RR.sourceUrl, image: RR.image, nutrition: RealmSNutrition.parseBack(RR.nutrition!), summary: RR.summary, analyzedInstructions: RealmSSteps.parseArrayBack(RR.analyzedInstructions))
    }
}

class RealmSNutrition:Object{
    var nutrients:[RealmSNutrient] = [];
    var ingredients:[RealmSIngredient] = [];
    @objc dynamic var caloricBreakdown:RealmSCaloricBreakdown?;
    @objc dynamic var weightPerServing:RealmSWeight?;
    
    static func parseData(_ SN:SNutrition) -> RealmSNutrition{
        var newNutrition = RealmSNutrition()
        if let nutrients = SN.nutrients, let ingredients = SN.ingredients, let caloricBreakdown = SN.caloricBreakdown, let weightPerServing = SN.weightPerServing{
            newNutrition.nutrients = RealmSNutrient.parseArrayData(nutrients)
            newNutrition.caloricBreakdown = RealmSCaloricBreakdown.parseData(caloricBreakdown)
            newNutrition.weightPerServing = RealmSWeight.parseData(weightPerServing)
            newNutrition.ingredients = RealmSIngredient.parseArrayData(ingredients)
        }
        return newNutrition
    }
    
    static func parseBack(_ RN:RealmSNutrition) -> SNutrition{
        return SNutrition(nutrients: RealmSNutrient.parseArrayBack(RN.nutrients), ingredients: RealmSIngredient.parseArrayBack(RN.ingredients), caloricBreakdown: RealmSCaloricBreakdown.parseBack(RN.caloricBreakdown!), weightPerServing: RealmSWeight.parseBack(RN.weightPerServing!))
    }
}

class RealmSIngredient: Object{
    @objc dynamic var id:Int = 0;
    @objc dynamic var name:String = "";
    @objc dynamic var amount:Float = 0;
    @objc dynamic var unit:String = "";
    var nutrients:[RealmSNutrient] = [];
    @objc dynamic var localizedName:String = "";
    @objc dynamic var image:String = "";
    
    static func parseArrayData(_ ASI:[SIngredient]) -> [RealmSIngredient]{
        return ASI.map({(ingredient) -> RealmSIngredient in return RealmSIngredient.parseData(ingredient)})
    }
    
    static func parseData(_ SI:SIngredient) -> RealmSIngredient{
        var newSI = RealmSIngredient()
        if let id = SI.id, let name = SI.name, let amount = SI.amount, let unit = SI.unit, let nutrients = SI.nutrients, let localizedName = SI.localizedName, let image = SI.image{
            newSI.id = id;
            newSI.name = name;
            newSI.amount = amount;
            newSI.unit = unit;
            newSI.nutrients = RealmSNutrient.parseArrayData(nutrients);
            newSI.localizedName = localizedName;
            newSI.image = image
        }
        return newSI
    }
    
    static func parseBack(_ RI:RealmSIngredient) -> SIngredient{
        return SIngredient(id: RI.id, name: RI.name, amount: RI.amount, unit: RI.unit, nutrients: RealmSNutrient.parseArrayBack(RI.nutrients), localizedName: RI.localizedName, image: RI.image)
    }
    
    static func parseArrayBack(_ ARI:[RealmSIngredient]) -> [SIngredient]{
        return ARI.map({(ing) -> SIngredient in return RealmSIngredient.parseBack(ing)})
    }
}

class RealmSNutrient:Object{
    @objc dynamic var title:String = "";
    @objc dynamic var amount:Float = 0;
    @objc dynamic var unit:String = "";
    @objc dynamic var percentOfDailyNeeds:Float = 0;
    
    static func parseArrayData(_ ASN:[SNutrient]) -> [RealmSNutrient]{
        return ASN.map({(nutrient) -> RealmSNutrient in return RealmSNutrient.parseData(nutrient)})
    }
    
    static func parseData(_ SN:SNutrient) -> RealmSNutrient{
        var newNutrient = RealmSNutrient()
        newNutrient.title = SN.title ?? ""
        newNutrient.amount = SN.amount ?? 0
        newNutrient.percentOfDailyNeeds = SN.percentOfDailyNeeds ?? 0
        newNutrient.unit = SN.unit ?? ""
        return newNutrient
    }
    
    static func parseBack(_ RN:RealmSNutrient) -> SNutrient{
        return SNutrient(title: RN.title, amount: RN.amount, unit: RN.unit, percentOfDailyNeeds: RN.percentOfDailyNeeds)
    }
    
    static func parseArrayBack(_ ARN:[RealmSNutrient]) -> [SNutrient]{
        return ARN.map({(RN) -> SNutrient in return RealmSNutrient.parseBack(RN)})
    }
}

class RealmSCaloricBreakdown:Object{
    @objc dynamic var percentProtein:Float = 0;
    @objc dynamic var percentFat:Float = 0;
    @objc dynamic var percentCarbs:Float = 0;
    
    static func parseData(_ CB: SCaloricBreakdown) -> RealmSCaloricBreakdown{
        var newCB =  RealmSCaloricBreakdown()
        newCB.percentProtein = CB.percentProtein ?? 0
        newCB.percentFat = CB.percentFat ?? 0
        newCB.percentCarbs = CB.percentCarbs ?? 0
        return newCB
    }
    
    static func parseBack(_ RCB: RealmSCaloricBreakdown) -> SCaloricBreakdown{
        return SCaloricBreakdown(percentProtein: RCB.percentProtein, percentFat: RCB.percentFat, percentCarbs: RCB.percentCarbs)
    }
}

class RealmSWeight:Object{
    @objc dynamic var amount:Int = 0;
    @objc dynamic var unit:String = "";
    
    static func parseData(_ SW:SWeight) -> RealmSWeight{
        var newSW = RealmSWeight()
        newSW.amount = SW.amount ?? 0
        newSW.unit = SW.unit ?? ""
        return newSW
    }
    
    static func parseBack(_ RSW:RealmSWeight) -> SWeight{
        return SWeight(amount: RSW.amount, unit: RSW.unit)
    }
}

class RealmSInstruction: Object{
    @objc dynamic var name:String = "";
    var steps:[RealmSStep] = [];
}

class RealmSEquipment: Object{
    @objc dynamic var id:Int = 0;
    @objc dynamic var name:String = "";
    @objc dynamic var localizedName:String = "";
    @objc dynamic var image:String = "";
    
    static func parseArrayData(_ ASE:[SEquipment]) -> [RealmSEquipment]{
        return ASE.map({(e) -> RealmSEquipment in return RealmSEquipment.parseData(e)})
    }
    
    static func parseData( _ SE:SEquipment) -> RealmSEquipment{
        var newSE = RealmSEquipment()
        if let id = SE.id, let name = SE.name, let localizedName = SE.localizedName, let image = SE.image{
            newSE.id = id;
            newSE.name = name;
            newSE.localizedName = localizedName;
            newSE.image = image
        }
        return newSE
    }
    
    static func parseArrayBack(_ ARSE:[RealmSEquipment]) -> [SEquipment]{
        return ARSE.map({(equipment) -> SEquipment in return RealmSEquipment.parseBack(equipment)})
    }
    
    static func parseBack(_ RSE:RealmSEquipment) -> SEquipment{
        return SEquipment(id: RSE.id, name: RSE.name, localizedName: RSE.localizedName, image: RSE.image)
    }
}

class RealmSLength: Object{
    @objc dynamic var number:Int = 0;
    @objc dynamic var unit: String = "";
    static func parseData( _ SL:SLength) -> RealmSLength{
        var newSL = RealmSLength()
        if let number = SL.number, let unit = SL.unit{
            newSL.number = number;
            newSL.unit = unit;
        }
        return newSL
    }
    
    static func parseBack(_ RSL:RealmSLength) -> SLength{
        return SLength(number: RSL.number, unit: RSL.unit)
    }
    
}

class RealmSStep:Object{
    @objc dynamic var number:Int = 0;
    @objc dynamic var step:String = "";
    var ingredients: [RealmSIngredient] = [];
    var equipment: [RealmSEquipment] = [];
    var length: RealmSLength?;
    
    static func parseArrayData(_ ASS:[SStep]) -> [RealmSStep]{
        return ASS.map({(step) -> RealmSStep in return RealmSStep.parseData(step)})
    }
    
    static func parseData(_ SS:SStep) -> RealmSStep{
        var newSS = RealmSStep()
        if let number = SS.number, let step = SS.step, let ingredients = SS.ingredients, let length = SS.length{
            newSS.number = number
            newSS.step = step;
            newSS.ingredients = RealmSIngredient.parseArrayData(ingredients)
            newSS.equipment = RealmSEquipment.parseArrayData(SS.equipment)
            newSS.length = RealmSLength.parseData(length)
        }
        return newSS
    }
    
    static func parseArrayBack(_ RSS:[RealmSStep]) -> [SStep]{
        return RSS.map({(rss) -> SStep in return RealmSStep.parseBack(rss)})
    }
    
    static func parseBack(_ RSS:RealmSStep) -> SStep{
        return SStep(number: RSS.number, step: RSS.step, ingredients: RealmSIngredient.parseArrayBack(RSS.ingredients), equipment: RealmSEquipment.parseArrayBack(RSS.equipment), length: RealmSLength.parseBack(RSS.length!))
    }
}

class RealmSSteps:Object{
    var steps:[RealmSStep] = [];
    
    static func parseArrayData(_ ASS:[SSteps]) -> [RealmSSteps] {
        return ASS.map({(ss) -> RealmSSteps in return RealmSSteps.parseData(ss)})
    }
    
    static func parseData(_ SS:SSteps) -> RealmSSteps{
        var newSS = RealmSSteps()
        if let SSS = SS.steps{
            newSS.steps = RealmSStep.parseArrayData(SSS)
        }
        return newSS
        
    }
    
    static func parseArrayBack(_ RASS:[RealmSSteps]) -> [SSteps]{
        return RASS.map({(rss) -> SSteps in return RealmSSteps.parseBack(rss)})
    }
    
    static func parseBack(_ RSS:RealmSSteps) -> SSteps{
        return SSteps(steps: RealmSStep.parseArrayBack(RSS.steps))
    }
    
}


class FavoriteRecipeManager:ObservableObject{
    
    var realm = try! Realm();
    var data : Results<RealmRecipe>?;
    
    @Published var finalData:[SResult] = []
    
    init(){
        self.readData()
    }
    
    func readData(){
        self.data = realm.objects(RealmRecipe.self);
        self.updatePublishedData()
    }
    
    func updatePublishedData(){
        DispatchQueue.main.async{
            if let safeResult = self.data{
                self.finalData = RealmRecipe.parseArrayBack(Array(safeResult))
                //                print(self.finalData);
            }
        }
    }
    
    func addRecipe(_ recipe:SResult){
        var newRecipe = RealmRecipe()
        newRecipe = RealmRecipe.parseData(recipe)
        self.saveData(newData: newRecipe);

    }
    
    func saveData(newData:RealmRecipe){
        do{
            try self.realm.write({
                self.realm.add(newData);
                self.updatePublishedData();
            })
        }catch{
            print("There is an error while saving the data! \(error)");
        }
    }
    
    func deleteData(index:Any?){
        var row = 0;
        if let index = index as? IndexPath{
            row = index.row
        }else if let index = index as? Int{
            row = index;
        }
        if let dataObj = self.data?[row]{
            do{
                try self.realm.write({
                    self.realm.delete(dataObj)
                    self.updatePublishedData()
                })
            }catch{
                print("There is an error! \(error)")
            }
        }
        
    }
    
    func deleteAll(){
        if let safeData = self.data{
            do{
                try realm.write({
                    realm.delete(safeData);
                    self.finalData = [];
                })
            }catch{
                print("There is an error \(error)")
            }
        }
    }
    
    
}


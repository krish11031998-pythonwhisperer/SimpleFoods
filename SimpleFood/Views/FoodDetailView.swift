//
//  FoodDetailView.swift
//  SimpleFood
//
//  Created by Krishna Venkatramani on 6/14/20.
//  Copyright © 2020 Team Krish. All rights reserved.
//

import SwiftUI
import Flags
import ChameleonFramework


let colors = [FlatYellow(),FlatTeal(),FlatWatermelon()]

struct FoodDetailView: View {
    var food : EdamamRecipe;
    @State var showSummary:Bool = true;
    @State var showRecipes:Bool = false;
    //    @State var colorSummary:UIColor = FlatWatermelon();
    //    @State var colorRecipe:UIColor = FlatWatermelon();
    @ObservedObject var imageManager = DownloadImage();
    @ObservedObject var recipeManager = FavoriteRecipeManager()
    init(food:EdamamRecipe){
        self.food = food;
        self.updateRecipe();
    }
    
    var nutrition:[String:Float]{
        get{
            var nutri = ["fat","sugar","energy","carbs","protein","fiber"];
            var result:[String:Float] = [:]
            if let safeNutrients = self.food.totalNutrients{
                print(safeNutrients["PROCNT"])
                nutri.forEach { (nutrient) in
                    if let nutrientCode = NutrientType[nutrient], let value = safeNutrients[nutrientCode]?.quantity{
                        result[nutrient] =  value
                    }
                }
            }else{
                nutri.forEach({(nutrient) in
                    result[nutrient] = 0
                })
            }
            print(result)
            return result
        }
    }
    
    var nutrientPercent:[String:[String:Int]]{
        get{
            var finalNutrient:[String:[String:Int]] = [:]
            var nutri = ["fat","energy","carbs","protein","fiber"].map { (value) -> String in
                return NutrientType[value]!;
            }
            let nutrientDetails = self.food.parseDigest();
            nutri.forEach{(nutrient) in
                if let label = nutrientDetails[nutrient]?.label , let daily = nutrientDetails[nutrient]?.daily, let total = nutrientDetails[nutrient]?.total{
                    finalNutrient[label] = ["value":Int(total),"max":Int(daily)];
                }
            }
            return finalNutrient
        }
    }
    
    var labels:[String]{
        get{
            var result:[String] = []
            if let diet = self.food.dietLabels{
                result += diet
            }
            if let health = self.food.healthLabels{
                result += health
            }
            return result
        }
    }
    
    
    var body: some View {
        //        ScrollView(.vertical,showsIndicators: false){
        VStack{
            VStack(alignment: .center){
                Image(uiImage: self.imageManager.image)
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width/1.15, height: 300, alignment: .center)
                    .cornerRadius(20)
                Spacer().frame(height:25)
                HStack{
                    Text(food.label?.capitalized ?? "No Title")
                        .font(.custom("Avenir Next", size: 30))
                        .padding(.all,10)
                    LoveButton(){
                        print("Adding the recipe");
                        self.recipeManager.addRecipe(self.food);
                    }
                }
                
                Spacer()
                Text("by \(food.source ?? "Krish")")
                    .font(.subheadline)
            }
            
            TabButtons(buttonOne: self.$showSummary, buttonTwo: self.$showRecipes);
            if self.showSummary{
                VStack(alignment: .leading, spacing: 5) {
                    SummaryBars(yeilds: self.food.yield ?? 0, time: (self.food.totalTime ?? 0)/60, weight: (self.food.totalWeight ?? 0.0)/1000.0).padding(.leading,25)
                    Spacer()
                    HStack{
                        Spacer()
                        PieChart(values: self.PieChartValues())
                        Spacer()
                    }.padding(.bottom,25)
                    NutrientBars(nutrition_info: self.nutrition);
                    DailyUseBars(barData: self.nutrientPercent);
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Tags")
                            .font(.headline)
                            .padding(.all)
                        ScrollView(.horizontal,showsIndicators: false){
                            HStack{
                                ForEach(self.labels,id: \.self){(tag) in
                                    TypeCell(type: tag)
                                }
                            }
                        }.padding(.all)
                    }
                    
                }.animation(.spring())
            }
            else if self.showRecipes{
                VStack(alignment: .leading, spacing: 5) {
                    IngredientRow(recipe: self.food.ingredients ?? [], color: FlatLime(), type: "ingredients")
                    Spacer()
                    WebPlayerView(urlString:self.food.url ?? "")
                    
                }.animation(.spring())
                
            }
        }
        .navigationBarHidden(true)
    }
    
    func PieChartValues()-> [Nutrients]{
        return [
            Nutrients(value: nutrition["protein"] ?? 0.0, color: Color(FlatGreenDark())),
            Nutrients(value: nutrition["carbs"] ?? 0.0, color: Color(FlatSkyBlueDark())),
            Nutrients(value: nutrition["fat"] ?? 0.0, color: Color(FlatRed())),
            Nutrients(value: nutrition["sugar"] ?? 0.0, color: Color(FlatLimeDark())),
            Nutrients(value: nutrition["fiber"] ?? 0.0, color: Color(FlatBlue())),
        ]
    }
    
    func updateRecipe(){
        self.imageManager.urlString = self.food.image ?? ""
        self.imageManager.getImage()
    }
    
}

struct LoveButton:View{
    let onClick: () -> Void
    var body: some View{
        Button(action:onClick){
            Circle()
                .frame(width:50,height:50)
                .overlay(
                    Image(systemName: "heart")
                        .resizable()
                        .renderingMode(.original)
                        .frame(width: 20, height: 20, alignment: .center)
            )
        }
        
    }
}

//struct FoodDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        FoodDetailView(food: example)
//    }
//}

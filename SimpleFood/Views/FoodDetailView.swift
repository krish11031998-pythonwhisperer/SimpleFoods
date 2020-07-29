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
    @Environment(\.colorScheme) var colorScheme
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
    
    var PieChartLegend:[String:Color]{
        get{
            return ["protein": Color(FlatGreenDark()),"carbs": Color(FlatSkyBlueDark()),"fat":Color(FlatRed()),"sugar":Color(FlatLimeDark()),"fiber": Color(FlatBlue())]
        }
    }
    
    var nutritionTotal:[String:[String:Int]]{
        get{
            var nutri = ["fat","sugar","carbs","protein","fiber"];
            var finalResult:[String:[String:Int]] = [:];
            var result:[String:Int] = [:]
            var total:Int = 0;
            if let safeNutrients = self.food.totalNutrients{
                print(safeNutrients["PROCNT"])
                nutri.forEach { (nutrient) in
                    if let nutrientCode = NutrientType[nutrient], let value = safeNutrients[nutrientCode]?.quantity{
                        result[nutrient] =  Int(value)
                        total += Int(value)
                    }
                }
                result.keys.forEach { (key) in
                    finalResult[key] = ["value": Int(result[key] ?? 0),"max":total]
                }
            }else{
                nutri.forEach({(nutrient) in
                    result[nutrient] = 0
                })
            }
            print(finalResult)
            return finalResult
        }
    }
    
    
    var nutrition:[String:Float]{
        get{
            var nutri = ["fat","sugar","carbs","protein","fiber"];
            var result:[String:Float] = [:]
            var total:Int = 0;
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
                //                ZStack(alignment:.bottom){
                Spacer().frame(height: 50)
                ZStack(alignment: .top){
                    Image(uiImage: self.imageManager.image)
                    .resizable()
                    .frame(width: width, height: UIScreen.main.bounds.height/2.5, alignment: .center)
                    .cornerRadius(20)
                    .padding(.top)
                    HStack{
                        Spacer()
                        LoveButton(){
                            print("Adding the recipe");
                            self.recipeManager.addRecipe(self.food)
                        }.padding(.all,10).padding(.trailing,2.5)
                    }
                }
                
            HStack{
                Spacer(minLength: 50)
                VStack{
                    Text(food.label?.capitalized ?? "No Title")
                        .foregroundColor(.white)
                        .font(.custom("Avenir Next", size: 30))
                        .fixedSize(horizontal: false, vertical: true)
                }
                Spacer(minLength: 50)
            }.padding(.leading,5)
                SummaryBars(yeilds: self.food.yield ?? 0, time: (self.food.totalTime ?? 0)/60, weight: (self.food.totalWeight ?? 0.0)/1000.0).padding(.horizontal,25).padding(.bottom)
                TabButtons(buttonOne: self.$showSummary, buttonTwo: self.$showRecipes);
                
            }
            .padding(.top,25)
            .background(LinearGradient(gradient: Gradient(colors: [Color(UIColor.flatWatermelon()).opacity(0.75),Color(UIColor.flatWatermelonDark())]), startPoint: .top, endPoint: .bottom))
            .clipShape(Corners(corner: [.bottomRight], size: CGSize(width: 100, height: 100)))
            
            ZStack{
                Color(UIColor.flatWatermelonDark())
                VStack{
                    if self.showSummary{
                        VStack(alignment: .leading, spacing: 5) {
                            HStack{
                                Spacer()
                                PieChart(values: self.PieChartValues(),legend: self.PieChartLegend)
                                Spacer()
                            }
                            Spacer().frame(height:20)
                            HStack{
                                Spacer()
                                NutrientBars(nutrition_info: self.nutrientPercent)
                                Spacer()
                            }
                        }.animation(.spring())
                    }
                    else if self.showRecipes{
                        HStack{
                            Spacer()
                            VStack(alignment: .leading, spacing: 5) {
                                
                                Spacer()
                                IngredientRow(recipe: self.food.ingredients ?? [], color: colorScheme == .dark ? UIColor.black : UIColor.white, type: "ingredients")
                                Spacer()
                                WebPlayerView(urlString:self.food.url ?? "")
                                
                            }.animation(.spring())
                            Spacer()
                        }.animation(.spring())
                        
                        
                    }
                }.background(self.colorScheme == .dark ? Color.black : Color.white).clipShape(Corners(corner: [.topLeft], size: CGSize(width:100,height:100)))
            }
        }
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
                .fill(Color.red)
                .frame(width:50,height:50)
                .overlay(
                    Image(systemName: "heart")
                        .resizable()
                        .renderingMode(.original)
                        .frame(width: 20, height: 20, alignment: .center)
            )
        }.buttonStyle(PlainButtonStyle())
        
    }
}

struct FoodDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FoodDetailView(food: edamamExample!)
    }
}

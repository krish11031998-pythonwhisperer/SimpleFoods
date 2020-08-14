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
    var food : SResult
    @State var showSummary:Bool = true
    @State var showRecipes:Bool = false
    @ObservedObject var imageManager = DownloadImage()
    @ObservedObject var recipeManager = FavoriteRecipeManager()
    init(food:SResult){
        self.food = food
        //        print(self.food)
        self.updateRecipe()
    }
    
    var PieChartLegend:[String:Color]{
        get{
            return ["protein": Color(FlatGreenDark()),"carbs": Color(FlatSkyBlueDark()),"fat":Color(FlatRed()),"sugar":Color(FlatLimeDark()),"fiber": Color(FlatBlue())]
        }
    }
    
    var getSteps:[SStep]{
        get {
            return self.food.analyzedInstructions?[0].steps ?? []
        }
    }
    
    var nutrientPercent:[String:SNutrient]{
        get{
            var finalNutrient:[String:SNutrient] = [:]
            var nutri = ["fat","calories","carbohydrates","protein","fiber","sugar"]
            if let nutrients = self.food.nutrition?.nutrients{
                nutrients.forEach { (nutrient) in
                    if let title = nutrient.title?.lowercased(){
                        if nutri.contains(title){
                            finalNutrient[title] = nutrient
                        }
                    }
                }
            }
            //            print(finalNutrient)
            return finalNutrient
            
            
        }
    }
    
    var labels:[String]{
        get{
            var result:[String] = []
            if let diet = self.food.diets{
                result += diet
            }
            if let health = self.food.dishTypes{
                result += health
            }
            return result
        }
    }
    
    var recipeSummary:String{
        get{
            var result:String = ""
            if let summary = self.food.summary{
                result = summary.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
            }
            return result
        }
    }
    
    var body: some View {
        ScrollView(.vertical,showsIndicators:false){
            VStack{
                self.imageView
                ZStack{
                    Color(UIColor.flatWatermelonDark())
                    VStack{
                        if self.showSummary{
                            VStack(alignment: .leading, spacing: 5) {
                                self.summayPanel.padding(.top, 20)
                                Spacer().frame(height:20)
                                HStack{
                                    Spacer()
                                    NutrientBars(nutrition_info: self.nutrientPercent, breakdownData: self.food.nutrition?.caloricBreakdown)
                                    Spacer()
                                }
                                Spacer().frame(height:20)
//                                HStack{
//                                    Spacer()
//                                    PieChart(values: self.PieChartValues(),legend: self.PieChartLegend)
//                                    Spacer()
//                                }
                                Spacer().frame(height:50)
                                
                            }.padding(.bottom,10).animation(.spring())
                        }
                        else if self.showRecipes{
                            HStack{
                                Spacer()
                                VStack(alignment: .leading, spacing: 5) {
                                    Group{
                                        Spacer()
                                        IngredientRow(recipe: self.food.nutrition?.ingredients ?? [], color: colorScheme == .dark ? UIColor.black : UIColor.white, type: "ingredients")
                                        Spacer()
                                        IngredientRow(steps: self.getSteps, color: colorScheme == .dark ? UIColor.black : UIColor.white, type: "instructions")
                                        Spacer()
                                        WebPlayerView(urlString:self.food.sourceUrl ?? "")
                                        Spacer().frame(height:50)
                                    }
                                }
                                Spacer()
                            }.animation(.spring())
                        }
                    }.background(self.colorScheme == .dark ? Color.black : Color.white).clipShape(Corners(corner: [.topLeft], size: CGSize(width:50,height:50)))
                }.padding(.bottom,10)
            }.padding(.bottom,10)
        }.edgesIgnoringSafeArea(.top)
    }
    
    var summayPanel: some View{
        VStack{
            Titles(title: "Summary")
            HStack{
                Spacer(minLength: 25)
                Text(self.recipeSummary)
                    .font(.custom("Avenir Next",size: 12.5))
                    .fontWeight(.medium)
                Spacer(minLength: 25)
            }
        }
        
    }
    
    var imageView : some View {
        VStack(alignment: .center){
            Spacer().frame(height: 50)
            ZStack(alignment: .top){
                Image(uiImage: self.imageManager.image)
                    .resizable()
                    .renderingMode(.original)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: width, height: UIScreen.main.bounds.height/2.5, alignment: .center)
                    .cornerRadius(20)
                    .padding(.top)
                HStack{
                    Spacer()
                    LoveButton(){
                        print("Adding the recipe")
                        self.recipeManager.addRecipe(self.food)
                    }.padding(.all,10).padding(.trailing,2.5)
                }
            }
            HStack{
                Spacer(minLength: 50)
                Text(self.food.title?.capitalized ?? "No Title")
                    .foregroundColor(.white)
                    .font(.custom("Avenir Next", size: 30))
                    .fixedSize(horizontal: false, vertical: true)
                Spacer(minLength: 50)
            }.padding(.leading,5)
            //            self.summayPanel.padding(.top)
            SummaryBars(yeilds: self.food.servings ?? 0, time: (self.food.readyInMinutes ?? 0)/60, weight: Float(self.food.nutrition?.weightPerServing?.amount ?? 0)/1000.0)
            TabButtons(buttonOne: self.$showSummary, buttonTwo: self.$showRecipes)
            
        }
        .padding(.top,25)
        .background(LinearGradient(gradient: Gradient(colors: [Color(UIColor.flatWatermelon()).opacity(0.75),Color(UIColor.flatWatermelonDark())]), startPoint: .top, endPoint: .bottom))
        .clipShape(Corners(corner: [.bottomRight], size: CGSize(width: 50, height: 50)))
    }
    
    
    
    
    func PieChartValues()-> [Nutrients]{
        return [
            Nutrients(value: self.food.nutrition?.caloricBreakdown?.percentProtein ?? 0.0, color: Color(FlatGreenDark())),
            Nutrients(value: self.food.nutrition?.caloricBreakdown?.percentCarbs ?? 0.0, color: Color(FlatSkyBlueDark())),
            Nutrients(value: self.food.nutrition?.caloricBreakdown?.percentFat ?? 0.0, color: Color(FlatRed())),
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
//

struct FoodDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FoodDetailView(food: SExample)
    }
}

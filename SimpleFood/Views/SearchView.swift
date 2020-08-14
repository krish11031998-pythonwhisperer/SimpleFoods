//
//  SearchView.swift
//  SimpleFood
//
//  Created by Krishna Venkatramani on 8/5/20.
//  Copyright © 2020 Team Krish. All rights reserved.
//

import SwiftUI

class ToggleValues: ObservableObject{
    @Published var selected:Bool = false
    @Published var min:Int = 0;
    @Published var max:Int = 100;
}

class ChoosenCuisine: ObservableObject{
    @Published var cuisines:SCuisine = .None
}

class ChoosenMeal: ObservableObject{
    @Published var meal:SMeal = .None
}

struct SearchDetailView: View {
    @State var advancedSearch:Bool = false
    @State var recipe:String = ""
    @State var cuisine:SCuisine = .None
    @ObservedObject var SFDM:SAPIManager = SAPIManager()
    @ObservedObject var CC:ChoosenCuisine = ChoosenCuisine()
    @ObservedObject var CM:ChoosenMeal = ChoosenMeal()
    var filterHeight:CGFloat{
        get{
            return self.advancedSearch ? 450 : 75
        }
    }
    var filters:[String] = ["Protein","Fat","Carbs","Calories"]
    var filtersState:[String:ToggleValues] = ["Protein":ToggleValues(),"Fat":ToggleValues(),"Carbs":ToggleValues(),"Calories":ToggleValues()]
    var body: some View{
        self.SV
    }
    
    func searchRecipes() -> SQuery{
        var newQuery = SQuery()
        if self.recipe != ""{
            newQuery.titleMatch = recipe
        }
        if self.advancedSearch{
            self.filtersState.keys.forEach({(key) in
                if let safeTV = self.filtersState[key], safeTV.selected{
                    if key == "Protein"{
                        newQuery.minProtein = safeTV.min
                        newQuery.maxProtein = safeTV.max
                    }
                    if key == "Fat"{
                        newQuery.minFat = safeTV.min
                        newQuery.maxFat = safeTV.max
                    }
                    if key == "Carbs"{
                        newQuery.minCarbs = safeTV.min
                        newQuery.maxCarbs = safeTV.max
                    }
                    if key == "Calories"{
                        newQuery.minCalories = safeTV.min
                        newQuery.maxCalories = safeTV.max
                    }
                }
            })
        }
        if self.CC.cuisines != .None{
            newQuery.cuisine = self.CC.cuisines.rawValue
        }
        if self.CM.meal != .None{
            newQuery.type = self.CM.meal.rawValue
        }
        newQuery.number = 10
        newQuery.instructionsRequired = true
        newQuery.addRecipeInformation = true
        newQuery.addRecipeNutrition = true
        return newQuery
    }
    
    func getValueBar(_ i:Int) -> ValueBar{
        var filter = self.filters[i]
        return ValueBar(title: filter, values: self.filtersState[filter]!)
    }
    
    
    var SV: some View {
        VStack(alignment: .leading,spacing:5){
            Text("Search Recipes !")
                .font(.custom("Avenir Next",size: 17.5))
                .foregroundColor(Color.mainColor)
            HStack {
                TextField("Pizza,Burger,etc......", text: self.$recipe){
                    print("Recipe Commit ! = \(self.recipe)")
                }.frame(height: 75)
                    .textFieldStyle(SearchTextFieldStyle())
                    .cornerRadius(20)
                NavigationLink(destination: DietRecipes(nil,self.searchRecipes())){
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.mainColor)
                        .frame(width:50,height:50)
                        .overlay(
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(Color.white)
                    )
                }
            }.frame(width: width)
            RoundedRectangle(cornerRadius:20)
                .fill(Color.mainColor)
                .frame(width: width, height: self.filterHeight)
                .animation(.easeInOut(duration: 0.25))
                .overlay(
                    VStack(alignment: .leading){
                        HStack{
                            Toggle(isOn:$advancedSearch){
                                Text("Advanced Search")
                                    .font(.custom("Avenir Next",size: 25))
                                    .foregroundColor(Color.white).padding(.leading)
                            }.padding(.horizontal)
                        }.padding(.top)
                        
                        VStack(alignment:.center){
                            ForEach(0..<self.filters.count){(i) in
                                self.getValueBar(i)
                            }
                        }.frame(height: self.advancedSearch ? 350: 0).opacity(self.advancedSearch ? 1 : 0).animation(.easeInOut(duration: 0.35))
                    }
            )
            VStack{
                Text("Cuisines")
                    .font(.custom("Avenir Next",size:25))
                    .foregroundColor(.mainColor)
                    .padding(.leading)
                CuisineBarButton(selectedCuisine: self.CC)
            }.padding(.top)
            VStack{
                Text("Meal Type")
                    .font(.custom("Avenir Next",size:25))
                    .foregroundColor(.mainColor)
                    .padding(.leading)
                MealTypeButton(selectedMeal: self.CM)
            }.padding(.vertical)
            Spacer()
        }
        //        .frame(height:height)
    }
}


struct ValueBar: View{
    var title:String
    @ObservedObject var values:ToggleValues
    var body: some View{
        self.V1
    }
    
    func toggleButton(_ type:String) -> some View{
        var button = type == "minus" ?  HStack(spacing: 5){
            minusButton
                .onTapGesture {
                    self.values.min -= 50
            }
            Text("\(self.values.min)")
                .font(.custom("Avenir Next",size: 12))
                .fontWeight(.semibold)
            
            plusButton
                .onTapGesture {
                    self.values.min += 50
            }
        }.frame(width: 75, height: 50)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .strokeBorder(Color.white, lineWidth: 1.5)
            ) : HStack(spacing: 5){
                minusButton
                    .onTapGesture {
                        self.values.max -= 50
                }
                Text("\(self.values.max)")
                    .font(.custom("Avenir Next",size: 12))
                    .fontWeight(.semibold)
                plusButton
                    .onTapGesture {
                        self.values.max += 50
                }
            }.frame(width: 75, height: 50)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .strokeBorder(Color.white, lineWidth: 1.5)
        )
        return button
    }
    
    var V1:some View{
        HStack{
            Text(self.title)
                .font(.custom("Avenir Next",size: 20))
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .onTapGesture {
                    self.values.selected.toggle()}
            Spacer()
            HStack {
                self.toggleButton("minus")
                Text("-")
                self.toggleButton("plus")
            }.frame(width : self.values.selected ? 200 : 0)
                .animation(.easeInOut(duration: 0.5)).opacity(self.values.selected ? 1 : 0)
        }.padding(.all)
    }
    
    var minusButton: some View{
        Image(systemName: "minus.circle")
            .resizable()
            .frame(width: 10,height: 10)
    }
    
    var plusButton: some View{
        Image(systemName: "plus.circle")
            .resizable()
            .frame(width: 10,height: 10)
    }
    
    
}

struct MealTypeButton:View{
    @ObservedObject var selectedMeal:ChoosenMeal
    var allMeal:[SMeal] = [.Appetizer,.Beverage,.Bread,.Breakfast,.Dessert,.Drink,.Fingerfood,.MainCourse,.Marinade,.Salad,.Sauce,.SideDish,.Snack,.Soup]
    var allMealArranged:[[SMeal]]{
        get{
            var result:[[SMeal]] = []
            for x in 0..<self.allMeal.count/3{
                var innerResult:[SMeal] = []
                for y in x*3..<(x+1)*3{
                    innerResult.append(self.allMeal[y])
                }
                result.append(innerResult)
            }
            return result
        }
    }
    
    var body: some View{
        ForEach(0..<self.allMealArranged.count){(i) in
            self.innerHStack(self.allMealArranged[i])
        }
    }
    
    func isSelected(_ cuisine:SMeal) -> Bool{
        return selectedMeal.meal == cuisine
    }
    
    func addMeal(_ meal:SMeal){
        if self.selectedMeal.meal == meal{
            self.selectedMeal.meal = .None
        }
        else{
            self.selectedMeal.meal = meal
        }
    }
    
    func innerHStack(_ meals:[SMeal]) -> some View{
        return HStack{
            ForEach(0..<meals.count){(i) in
                RoundedButton(selected: self.isSelected(meals[i]), data: meals[i]) { (selectedMeal) in
                    if let SM = selectedMeal as? SMeal{
                        self.addMeal(SM)
                    }
                    
                }
            }
        }
    }
}

struct CuisineBarButton:View{
    @ObservedObject var selectedCuisine:ChoosenCuisine
    var allCuisine:[SCuisine] = [.African,.American,.British,.Cajun,.Caribbean,.Chinese,.Eastern_European,.European,.French,.German,.Greek,.Irish,.Indian,.Italian,.Japanese,.Jewish,.Korean,.Latin_American,.Mediterranean,.Middle_Eastern,.Nordic,.Southern,.Spanish,.Thai,.Vietnamese]
    var allCuisineArranged:[[SCuisine]]{
        get{
            var result:[[SCuisine]] = []
            for x in 0..<self.allCuisine.count/3{
                var innerResult:[SCuisine] = []
                for y in x*3..<(x+1)*3{
                    innerResult.append(self.allCuisine[y])
                }
                result.append(innerResult)
            }
            return result
        }
    }
    
    var body: some View{
        ForEach(0..<self.allCuisineArranged.count){(i) in
            self.innerHStack(self.allCuisineArranged[i])
        }
    }
    
    func isSelected(_ cuisine:SCuisine) -> Bool{
        //            guard let safeCuisine = self.selectedCuisine else {return false}
        return selectedCuisine.cuisines == cuisine
    }
    
    func addCuisine(_ cuisine:SCuisine){
        if self.selectedCuisine.cuisines == cuisine{
            self.selectedCuisine.cuisines = .None
        }
        else{
            self.selectedCuisine.cuisines = cuisine
        }
    }
    
    func innerHStack(_ cuisines:[SCuisine]) -> some View{
        return HStack{
            ForEach(0..<cuisines.count){(i) in
                RoundedButton(selected: self.isSelected(cuisines[i]), data: cuisines[i]) { (selectedCuisine) in
                    if let safeCuisine = selectedCuisine as? SCuisine{
                        self.addCuisine(safeCuisine)
                    }
                    
                }
            }
        }
    }
}

struct RoundedButton:View{
    var selected:Bool
    var data:Any?
    var onClick : (_ cuisine:Any?) -> Void
    
    var title:String{
        get{
            if let SC = self.data as? SCuisine{
                return SC.rawValue.capitalized
            }else if let SM = self.data as? SMeal{
                return SM.rawValue.capitalized
            }else{
                return ""
            }
        }
    }
    
    var body: some View{
        RoundedRectangle(cornerRadius:20)
            .fill(self.selected ? Color.mainColor : Color.gray)
            .frame(width:width/3,height:40)
            .onTapGesture {
                self.onClick(self.data)
        }
        .overlay(
            Text(self.title)
                .font(.custom("Avenir Next",size:10))
                .foregroundColor(.white)
                .fontWeight(.medium)
                .padding(.all).onTapGesture {
                    self.onClick(self.data)
        })
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchDetailView()
    }
}

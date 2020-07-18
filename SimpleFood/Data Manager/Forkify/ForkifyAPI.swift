//
//  ForkifyApi.swift
//  SimpleFood
//
//  Created by Krishna Venkatramani on 6/13/20.
//  Copyright © 2020 Team Krish. All rights reserved.
//

import Foundation
import SwiftUI

class FoodManage: ObservableObject{
    var urlString:String = "https://forkify-api.herokuapp.com/api";
    @Published var foodSearch:[Food] = [Food(publisher: "101 Cookbooks", title: "Best Pizza Dough Ever", source_url: "http://www.101cookbooks.com/archives/001199.html", recipe_id: "47746", image_url: "http://forkify-api.herokuapp.com/images/best_pizza_dough_recipe1b20.jpg", publisher_url: "http://www.101cookbooks.com")];
    @Published var topFive:[Food] = [Food(publisher: "101 Cookbooks", title: "Best Pizza Dough Ever", source_url: "http://www.101cookbooks.com/archives/001199.html", recipe_id: "47746", image_url: "http://forkify-api.herokuapp.com/images/best_pizza_dough_recipe1b20.jpg", publisher_url: "http://www.101cookbooks.com")]
    @Published var typeFoodRecipes:[hashableRecipe] = [hashableRecipe(foods: [Food(publisher: "101 Cookbooks", title: "Best Pizza Dough Ever", source_url: "http://www.101cookbooks.com/archives/001199.html", recipe_id: "47746", image_url: "http://forkify-api.herokuapp.com/images/best_pizza_dough_recipe1b20.jpg", publisher_url: "http://www.101cookbooks.com"),Food(publisher: "101 Cookbooks", title: "Best Pizza Dough Ever", source_url: "http://www.101cookbooks.com/archives/001199.html", recipe_id: "47746", image_url: "http://forkify-api.herokuapp.com/images/best_pizza_dough_recipe1b20.jpg", publisher_url: "http://www.101cookbooks.com")], id: "1")];
    @Published var recipe:Recipe = Recipe(ingredients: [
    "4 1/2 cups (20.25 ounces) unbleached high-gluten, bread, or all-purpose flour, chilled",
    "1 3/4 (.44 ounce) teaspoons salt",
    "1 teaspoon (.11 ounce) instant yeast",
    "1/4 cup (2 ounces) olive oil (optional)",
    "1 3/4 cups (14 ounces) water, ice cold (40F)",
    "Semolina flour OR cornmeal for dusting","4 1/2 cups (20.25 ounces) unbleached high-gluten, bread, or all-purpose flour, chilled",
    "1 3/4 (.44 ounce) teaspoons salt",
    "1 teaspoon (.11 ounce) instant yeast",
    "1/4 cup (2 ounces) olive oil (optional)",
    "1 3/4 cups (14 ounces) water, ice cold (40F)",
    "Semolina flour OR cornmeal for dusting"])
    
    func getFoodSearch(_ food:String="pizza",_ format:Bool = false){
        guard let url = URL(string: "\(self.urlString)/search?q=\(food)") else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let safeData = data else {
                if let err = error{
                    print("Error Code: \(err)");
                }
                print("There was an error !");
                return
            }
            if let parseData = self.parseJSON(safeData) as? [Food]{
                DispatchQueue.main.async {
                    self.foodSearch = parseData;
                    self.topFive = Array(self.foodSearch[3...8])
                    if format{
                        self.formatRecipe();
                    }
                }
            }
        }.resume()
    }
    
    func getRecipe(_ recipeID:String="46956"){
        guard let url = URL(string: "\(self.urlString)/get?rId=\(recipeID)") else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let safeData = data else{
                if let err = error{
                    print("Error Code: \(err)");
                }
                print("There was an error !");
                return
            }
            if let parseData = self.parseJSON(safeData, "recipe") as? Recipe{
                DispatchQueue.main.async {
                    self.recipe = parseData
                    print("The Recipe looks like \(self.recipe.ingredients ?? [])");
                }
            }
        }.resume()
    }
    
    func parseJSON(_ data:Data,_ type:String="search") -> Any?{
        let decoder = JSONDecoder();
        if type == "search"{
            do {
                let finalData = try decoder.decode(FoodSearch.self, from: data);
                return finalData.recipes
            }catch{
                print("there was an error while decoding the FoodSearch query \(error)");
            }
        }else{
            do{
                let finalData = try decoder.decode(FoodRecipe.self, from: data);
                return finalData.recipe
            }catch{
                print("there was an error while decoding the FoodRecipe query \(error)");
            }
        }
        return nil
    }
    
       func formatRecipe(){
        print("formatting the recipe!");
         var resultFood:[hashableRecipe] = [];
         var subsection:[Food] = [];
         var count = 0;        
         for x in stride(from: 0, to: self.foodSearch.count-1, by: 2){
             var FFoods:[Food] = [];
             if x+1 > self.foodSearch.count-1{
                 FFoods = [self.foodSearch[x]]
             }else{
                 FFoods = [self.foodSearch[x],self.foodSearch[x+1]]
             }
             resultFood.append(hashableRecipe(foods: FFoods, id: "\(count)"))
             count+=1;
         }
         self.typeFoodRecipes = resultFood;
        if self.typeFoodRecipes.count > 0{
            print("1st element : \(self.typeFoodRecipes[0].foods)")
        }

     }
     
    
    
}

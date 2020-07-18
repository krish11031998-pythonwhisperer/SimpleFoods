//
//  EdamamAPI.swift
//  SimpleFood
//
//  Created by Krishna Venkatramani on 6/28/20.
//  Copyright © 2020 Team Krish. All rights reserved.
//

import Foundation
import SwiftUI

var RecipeCache = NSCache<NSString,CachedRecipes>()

class EdamamAPIManager:ObservableObject{
    
    var app_id = "28f0257a";
    var app_key = "2210d8644a261a651d426736269d8ed4";
    var query = queryParams();
    var baseUrl = "https://api.edamam.com/search"
    @Published var result:[ERecipeID] = [];
    @Published var singleResult:EdamamRecipe = EdamamRecipe();
    
    func getResults(){
        var finalurlString = "\(self.baseUrl)\(self.parseQuery())"
        if let cacheResult = RecipeCache.object(forKey: (finalurlString as NSString)){
            self.result = cacheResult.recipes!;
        }
        guard let url = URL(string: finalurlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let safeData = data else {return}
            if let safeParseData = self.parseData(safeData)?.hits{
                DispatchQueue.main.async {
                    let safeParsedData = safeParseData.map({ (hit) -> EdamamRecipe in
                        return hit.recipe ?? EdamamRecipe()
                    })
                    self.formatData(safeParsedData)
                }
            }else{
                print("Error parsin data")
            }
            
        }.resume()
    }
    
    
    func parseQuery() -> String{
        var finalStr = "";
        finalStr += "?app_id=\(self.app_id)&app_key=\(self.app_key)&q=\(self.query.q)&from=\(self.query.from)&to=\(self.query.to)"
        
        if let safeHealth = self.query.health{
            var fStr = safeHealth.map({ (health) -> String in
                return "health=\(health.rawValue)"
            }).reduce("") { (a, b) -> String in
                return a+b
            }
            finalStr += "&\(fStr)"
        }
        
        if let safeDiet = self.query.diet{
            var fStr = safeDiet.map({ (diet) -> String in
                return "diet=\(diet.rawValue)"
            }).reduce("") { (a, b) -> String in
                return a+b
            }
            finalStr += "&\(fStr)"
        }
        
        return finalStr
    }
    
    
    func parseData(_ data:Data) -> EdamamRecipeResult?{
        let decoder = JSONDecoder();
        do{
            let parseData = try decoder.decode(EdamamRecipeResult.self, from: data)
            print(parseData.hits?[0].recipe!);
            return parseData;
        }catch{
            print("Error : \(error)");
            return nil
        }
    }
    
    func formatData(_ result:[EdamamRecipe]){
        if result.count > 0{
            var count = 0
            var theResult = result.map { (recipe) -> ERecipeID in
                let newERID =  ERecipeID(id: count, recipe: recipe)
                count+=1;
                return newERID
            }
            RecipeCache.setObject(CachedRecipes(recipes:theResult), forKey: "\(self.baseUrl)\(self.parseQuery())" as NSString)
            self.result = theResult
        }
    }
    
    func parseRecipe(_ data:Data) -> EdamamRecipe?{
        let decoder = JSONDecoder();
        var finalParsedData:EdamamRecipe = EdamamRecipe();
        let str = String(decoding: data, as: UTF8.self)
        print(str)
        do{
            var parsedData = try decoder.decode([EdamamRecipe].self,from:data)
            if parsedData.count > 0{
                finalParsedData = parsedData[0]
            }
        }catch{
            print("There is an error in while parsing the data \(error)")
        }
        return finalParsedData
    }
    
    func formatURI(_ uri:String) -> String{
        var uriF = uri.replacingOccurrences(of: ":", with: "%3A");
        uriF = uriF.replacingOccurrences(of:"/" , with:"%2F")
        uriF = uriF.replacingOccurrences(of:"#", with:"%23");
        return uriF;
    }
    
    func getRecipe(_ uri:String) -> EdamamRecipe?{
        var Sendingdata:EdamamRecipe?;
        let semaphore = DispatchSemaphore(value: 0)
        var finalStr = self.baseUrl+"?app_id=\(self.app_id)&app_key=\(self.app_key)&r=\(self.formatURI(uri))"
        if let url = URL(string:finalStr){
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let safeData = data else {
                    if let err = error{
                        print("THere was an error with the error code from the API \(err)");
                        semaphore.signal()
                    }
                    return
                }
                if let safeParseData = self.parseRecipe(safeData){
                    Sendingdata = safeParseData;
                    semaphore.signal();
                }else{
                    print("Error parsin data")
                }
                
                
            }.resume()
        }else{
            semaphore.signal()
        }
        _ = semaphore.wait(timeout: .distantFuture)
        return Sendingdata
    }
    
    
}

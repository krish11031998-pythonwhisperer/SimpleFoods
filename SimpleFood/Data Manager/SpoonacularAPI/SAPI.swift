//
//  SAPI.swift
//  SimpleFood
//
//  Created by Krishna Venkatramani on 7/30/20.
//  Copyright © 2020 Team Krish. All rights reserved.
//

import Foundation
import SwiftUI

var SRecipeCache = NSCache<NSString,CachedSRecipes>()

class SAPIManager:ObservableObject{
    
    var app_key = "3e53598abaf7419ab2a2e30176146a76";
    var query = SQuery();
    var baseUrl = "https://api.spoonacular.com/recipes/complexSearch"
    @Published var result:[SResult] = [];
    @Published var singleResult:SResult = SResult();
    
    func getResults(){
        var finalurlString = "\(self.baseUrl)\(self.parseQuery())"
        if let cacheResult = SRecipeCache.object(forKey: (finalurlString as NSString)){
            self.result = cacheResult.recipes!;
        }
        guard let url = URL(string: finalurlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let safeData = data else {return}
            if let safeParseData = self.parseData(safeData){
                DispatchQueue.main.async {
                    self.result = safeParseData
                }
            }else{
                print("Error parsin data")
            }
            
        }.resume()
    }
    
    
    func parseQuery() -> String{
        var finalStr = "?apiKey=\(self.app_key)";
        var queryStr :[String] = []
        do {
            var queryDict = try self.query.allKeysValues()
            queryDict.keys.forEach({ (key) in
                if let value = queryDict[key]{
                    queryStr.append("\(key)=\(value)")
                }
            })
            finalStr += queryStr.reduce("", { (a, b) -> String in
                return a+"&"+b
            })
            
        }catch{
            print("There was an error \(error)")
        }
        
        return finalStr
    }
    
    
    func parseData(_ data:Data) -> [SResult]?{
        let decoder = JSONDecoder();
        do{
            let parseData = try decoder.decode(SRequest.self, from: data)
            print(parseData.results?[0].title!);
            return parseData.results ?? [];
        }catch{
            print("Error : \(error)");
            return nil
        }
    }
    
    
    func formatURI(_ uri:String) -> String{
        var uriF = uri.replacingOccurrences(of: ":", with: "%3A");
        uriF = uriF.replacingOccurrences(of:"/" , with:"%2F")
        uriF = uriF.replacingOccurrences(of:"#", with:"%23");
        return uriF;
    }
    
    
    
    
}

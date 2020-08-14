//
//  TastyAPI.swift
//  SimpleFood
//
//  Created by Krishna Venkatramani on 6/20/20.
//  Copyright © 2020 Team Krish. All rights reserved.
//

import Foundation

class TastyAPI:ObservableObject{
    
    @Published var foodList:[TastyFood] = exampleList;
    @Published var topFive:[TastyFood] = exampleList;
    var urlString:String = "https://tasty.p.rapidapi.com/recipes/list?"
    var start_limit:Int?;
    var end_limit:Int?;
    var tags:String?;
    let headers = [
        "x-rapidapi-host": "tasty.p.rapidapi.com",
        "x-rapidapi-key": "7746cb9f54msh2d203691cf02f42p161bc2jsn4079f978fca9"
    ];
    
    init(tags:String="",start:Int=0,end:Int=20){
        self.tags = tags;
        self.start_limit = start;
        self.end_limit = end;
        self.updatetopFive();
    }
    
    func updatetopFive(){
        if foodList.count >= 5{
            self.topFive = Array(foodList[0...4]);
        }else{
            print("foodList : \(self.foodList)")
        }
//        print("topfive \(topFive)");
    }
    
    func getData(){
        self.fetchData { (data, response, err) in
            guard let safeData = data else {
                var err_message = "";
                if let err=err{
                    err_message=err.localizedDescription;
                }
                print("There was an error : \(err_message)");
                return
            }
            let results = self.parseJSON(data: safeData);
            DispatchQueue.main.async {
                if results.count > 0{
                    self.foodList = results;
                    self.updatetopFive();
                }
                
            }
        }
    }
    
    func fetchData(completion:@escaping (Data?,URLResponse?,Error?) -> ()){
        let urlStringWparams = "\(self.urlString)tags=\(self.tags!)&from=\(self.start_limit!)&sizes=\(self.end_limit!)";
        if let url = URL(string: self.urlString){
            var request = URLRequest(url: url);
            request.allHTTPHeaderFields = self.headers;
            request.httpMethod = "GET";
            URLSession.shared.dataTask(with: request, completionHandler: completion).resume();
        }
    }
    
    func parseJSON(data:Data)->[TastyFood]{
        let decoder = JSONDecoder();
        do{
            let decodedData = try decoder.decode(TastyFoodResults.self, from: data);
            return decodedData.results ?? [];
        }catch{
            print("There was an error while decoding \(error.localizedDescription)");
        }
        return [];
    }
}

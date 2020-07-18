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
    @objc dynamic var title:String = "";
    @objc dynamic var uri:String = "";
    @objc dynamic var image:String = "";
    @objc dynamic var source:String = "";
    
    static func getExample() -> RealmRecipe{
        var exampleRealmRecipe = RealmRecipe()
        exampleRealmRecipe.title = "lemony zucchini goat cheese pizza";
        exampleRealmRecipe.uri = "http://www.edamam.com/ontologies/edamam.owl#recipe_fc0acc6d72b22beb2efc927546a33951";
        exampleRealmRecipe.image = "https://www.edamam.com/web-img/384/384017a33a45d2d39f042841815dd43d.jpg";
        exampleRealmRecipe.source = "Smitten Kitchen";
        return exampleRealmRecipe
    }
}




class FavoriteRecipeManager:ObservableObject{
    
    var realm = try! Realm();
    var data : Results<RealmRecipe>?;
    
    @Published var finalData:[RealmRecipe] = []
    
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
                self.finalData = Array(safeResult)
                print(self.finalData);
            }
        }
    }
    
    func addRecipe(_ recipe:EdamamRecipe){
        var newRecipe = RealmRecipe()
        //        print(recipe);
        print("label : \(recipe.label ?? "NA"), uri : \(recipe.uri ?? "NA") , image : \(recipe.image ?? "NA") and source : \(recipe.source ?? "NA")")
        if let title = recipe.label , let uri = recipe.uri , let image = recipe.image , let source = recipe.source{
            newRecipe.title = title;
            newRecipe.uri = uri;
            newRecipe.image = image;
            newRecipe.source = source;
            
            self.saveData(newData: newRecipe);
        }
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


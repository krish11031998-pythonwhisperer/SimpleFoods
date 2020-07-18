//
//  ShoppingList.swift
//  SimpleFood
//
//  Created by Krishna Venkatramani on 6/23/20.
//  Copyright © 2020 Team Krish. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftUI

class RealmIngredient : Object{
    @objc dynamic var id : Int = 0;//G
    @objc dynamic var name:String = "" ;//G
    @objc dynamic var quantity:String = "";//G
    @objc dynamic var unit:String = "";//G
    @objc dynamic var purchased: Bool = false;
}


class ShoppingList:ObservableObject{
    
    var realm = try! Realm();
    var data : Results<RealmIngredient>?;
    
    init(){
        self.readData();
    }
    
    func addIngredient(_ data: Ingredient){
        var newIng = RealmIngredient()
        guard let id = data.id , let name = data.name, let display_singular = data.display_singular , let display_plural = data.display_plural else {return}
        newIng.id = id;
        newIng.name = name;
        newIng.purchased = false;
        self.saveData(newData: newIng);
    }
    @Published var finalData : [RealmIngredient] = [];
    
    func updatepublishedData(){
        DispatchQueue.main.async{
            if let safeData = self.data{
                self.finalData = Array(safeData);
                print(self.finalData);
            }
        }
    }
    
    func readData(){
        self.data = realm.objects(RealmIngredient.self);
        self.updatepublishedData()
    }
    
    func saveData(newData:RealmIngredient){
        do{
            try self.realm.write({
                self.realm.add(newData);
                self.updatepublishedData();
            })
        }catch{
            print("There is an error while saving the data! \(error)");
        }
    }
    
    
    func updateObj(id:Int){
        print("id == \(id)")
        var dataObj = self.data?.filter("id = %@", id)
        if let safeDataObj = dataObj?[0] , let safeData = dataObj{
//            print("safDataObj \(safeDataObj.name)")
//            print("safeData \(safeData)");
            do{
                try self.realm.write({
                    safeDataObj.purchased = !safeDataObj.purchased
                })
                print(safeDataObj);
            }catch{
                print("There was an error while updating the ingredient!\(safeDataObj)");
            }
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
                    self.updatepublishedData()
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

//
//  FoodType.swift
//  SimpleFood
//
//  Created by Krishna Venkatramani on 6/13/20.
//  Copyright © 2020 Team Krish. All rights reserved.
//

import Foundation

struct FoodType: Identifiable{
    var id: String;
    var name: String;
}

struct hashableRecipe:Identifiable{
    var foods:[Food];
    var id:String;
}

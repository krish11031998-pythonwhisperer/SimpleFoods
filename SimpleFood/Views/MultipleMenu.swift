//
//  MultipleMenu.swift
//  SimpleFood
//
//  Created by Krishna Venkatramani on 7/26/20.
//  Copyright © 2020 Team Krish. All rights reserved.
//

import SwiftUI

struct MultipleMenu: View {
    @State var meal: Meal = .Breakfast
    @ObservedObject var EFDM:EdamamAPIManager = EdamamAPIManager();
    var body: some View {
        SideTabBar(value: self.$meal, foods: self.EFDM.result.count > 0 ? self.EFDM.result : [ERecipeID(id: 1, recipe: edamamExample!),ERecipeID(id: 2, recipe: edamamExample!)])
            .onAppear{
                var q = queryParams(q: self.meal.rawValue, from: 1, to: 5)
                self.EFDM.query = q;
                self.EFDM.getResults()
        }
//        Text("Hello")
    }
}

struct MultipleMenu_Previews: PreviewProvider {
    static var previews: some View {
        MultipleMenu()
    }
}

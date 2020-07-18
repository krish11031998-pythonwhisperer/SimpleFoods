//
//  SqaureFoodRow.swift
//  SimpleFood
//
//  Created by Krishna Venkatramani on 6/15/20.
//  Copyright © 2020 Team Krish. All rights reserved.
//

import SwiftUI

struct SqaureFoodRow: View {
    var foods:[EdamamRecipe] = [];
    @State var selection:Int? = nil;
    var body: some View {
        
        HStack(alignment: .top, spacing: 5){
//            NavigationLink(destination: FoodDetailView(food: self.foods[0]), tag: 1, selection: self.$selection, label: {
//                SquareFoodCell(food: self.foods[0], width: UIScreen.main.bounds.size.width/2.25, height: UIScreen.main.bounds.size.height/4).padding(.leading, 5)
//            }).buttonStyle(PlainButtonStyle())
//            NavigationLink(destination: FoodDetailView(food: self.foods[1]), tag: 2, selection: self.$selection, label: {
//                SquareFoodCell(food: self.foods[1], width: UIScreen.main.bounds.size.width/2.25, height: UIScreen.main.bounds.size.height/4).padding(.leading, 5)
//            }).buttonStyle(PlainButtonStyle())
            ForEach(self.foods){(food) in
                SquareFoodCell(food: food)
            }
    
        }.padding(.horizontal,10.0)
        
    }
}
//
//struct SqaureFoodRow_Previews: PreviewProvider {
//    static var previews: some View {
//        ScrollView(.vertical){
//            SqaureFoodRow(foods: [Food(publisher: "101 Cookbooks", title: "Best Pizza Dough Ever", source_url: "http://www.101cookbooks.com/archives/001199.html", recipe_id: "47746", image_url: "http://forkify-api.herokuapp.com/images/best_pizza_dough_recipe1b20.jpg", publisher_url: "http://www.101cookbooks.com"),Food(publisher: "101 Cookbooks", title: "Best Pizza Dough Ever", source_url: "http://www.101cookbooks.com/archives/001199.html", recipe_id: "47746", image_url: "http://forkify-api.herokuapp.com/images/best_pizza_dough_recipe1b20.jpg", publisher_url: "http://www.101cookbooks.com")])
//            SqaureFoodRow(foods: [Food(publisher: "101 Cookbooks", title: "Best Pizza Dough Ever", source_url: "http://www.101cookbooks.com/archives/001199.html", recipe_id: "47746", image_url: "http://forkify-api.herokuapp.com/images/best_pizza_dough_recipe1b20.jpg", publisher_url: "http://www.101cookbooks.com"),Food(publisher: "101 Cookbooks", title: "Best Pizza Dough Ever", source_url: "http://www.101cookbooks.com/archives/001199.html", recipe_id: "47746", image_url: "http://forkify-api.herokuapp.com/images/best_pizza_dough_recipe1b20.jpg", publisher_url: "http://www.101cookbooks.com")])
//            SqaureFoodRow(foods: [Food(publisher: "101 Cookbooks", title: "Best Pizza Dough Ever", source_url: "http://www.101cookbooks.com/archives/001199.html", recipe_id: "47746", image_url: "http://forkify-api.herokuapp.com/images/best_pizza_dough_recipe1b20.jpg", publisher_url: "http://www.101cookbooks.com"),Food(publisher: "101 Cookbooks", title: "Best Pizza Dough Ever", source_url: "http://www.101cookbooks.com/archives/001199.html", recipe_id: "47746", image_url: "http://forkify-api.herokuapp.com/images/best_pizza_dough_recipe1b20.jpg", publisher_url: "http://www.101cookbooks.com")])
//            SqaureFoodRow(foods: [Food(publisher: "101 Cookbooks", title: "Best Pizza Dough Ever", source_url: "http://www.101cookbooks.com/archives/001199.html", recipe_id: "47746", image_url: "http://forkify-api.herokuapp.com/images/best_pizza_dough_recipe1b20.jpg", publisher_url: "http://www.101cookbooks.com"),Food(publisher: "101 Cookbooks", title: "Best Pizza Dough Ever", source_url: "http://www.101cookbooks.com/archives/001199.html", recipe_id: "47746", image_url: "http://forkify-api.herokuapp.com/images/best_pizza_dough_recipe1b20.jpg", publisher_url: "http://www.101cookbooks.com")])
//            SqaureFoodRow(foods: [Food(publisher: "101 Cookbooks", title: "Best Pizza Dough Ever", source_url: "http://www.101cookbooks.com/archives/001199.html", recipe_id: "47746", image_url: "http://forkify-api.herokuapp.com/images/best_pizza_dough_recipe1b20.jpg", publisher_url: "http://www.101cookbooks.com"),Food(publisher: "101 Cookbooks", title: "Best Pizza Dough Ever", source_url: "http://www.101cookbooks.com/archives/001199.html", recipe_id: "47746", image_url: "http://forkify-api.herokuapp.com/images/best_pizza_dough_recipe1b20.jpg", publisher_url: "http://www.101cookbooks.com")])
//            SqaureFoodRow(foods: [Food(publisher: "101 Cookbooks", title: "Best Pizza Dough Ever", source_url: "http://www.101cookbooks.com/archives/001199.html", recipe_id: "47746", image_url: "http://forkify-api.herokuapp.com/images/best_pizza_dough_recipe1b20.jpg", publisher_url: "http://www.101cookbooks.com"),Food(publisher: "101 Cookbooks", title: "Best Pizza Dough Ever", source_url: "http://www.101cookbooks.com/archives/001199.html", recipe_id: "47746", image_url: "http://forkify-api.herokuapp.com/images/best_pizza_dough_recipe1b20.jpg", publisher_url: "http://www.101cookbooks.com")])
//        }
//        
//    }
//}

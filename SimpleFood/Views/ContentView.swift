//
//  ContentView.swift
//  SimpleFood
//
//  Created by Krishna Venkatramani on 6/13/20.
//  Copyright © 2020 Team Krish. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var windows : Int = 0;
    @State var deleteAll:Bool = false;
    var body: some View {
        NavigationView{
            VStack{
                if self.windows == 0{
                    ScrollView(.vertical, showsIndicators: false){
                        Spacer()
                        Text("Hello Krish!").font(.custom("Avenir Next", size: 50))
                        DifferentDiet()
                        Divider().frame(width:UIScreen.main.bounds.width/1.25,height:5)
                        FoodRow(type: "food", title: "pizza (Vegetarian)",imageStr: "pizza")
                        Divider().frame(width:UIScreen.main.bounds.width/1.25,height:5)
                        //                        FoodRow(type: "food", title: "pasta (Vegan)", cellType: "Large", q: "Pasta", health: .Vegan)
                        //                        Divider().frame(width:UIScreen.main.bounds.width/1.25,height:5)
//                        CuisineTypes(.Indian)
//                        Divider().frame(width:UIScreen.main.bounds.width/1.25,height:5)
                    }.animation(.spring())
                }else if self.windows == 1{
                    Text("Search");
                    Spacer()
                }else if self.windows == 2{
                    ScrollView(.vertical, showsIndicators: false){
                        IngredientShoppingList()
                    }.animation(.spring())
                }else if self.windows == 3{
                    ScrollView(.vertical, showsIndicators: false){
                        FavoritePanel()
                    }.animation(.spring())
                    
                }
                
                Tabs(windowIndex: self.$windows)
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarTitle(self.windows == 0 ? "Simple Foods" : self.windows == 1 ? "Search" : self.windows == 2 ? "Shopping List" : self.windows == 3 ? "Favorites" : "")
        }
    }
    
    func heading() -> String{
        switch(self.windows){
        case 1:
            return "Search"
        case 2:
            return "Shopping List"
        default:
            return "SimpleFoods"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

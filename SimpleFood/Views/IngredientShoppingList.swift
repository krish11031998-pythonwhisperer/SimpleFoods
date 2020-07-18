//
//  IngredientShoppingList.swift
//  SimpleFood
//
//  Created by Krishna Venkatramani on 6/23/20.
//  Copyright © 2020 Team Krish. All rights reserved.
//

import SwiftUI
import ChameleonFramework
struct IngredientShoppingList: View {
    @ObservedObject var shoppingList = ShoppingList();
    var body: some View {
        VStack{
            Button(action:{
                print("Button click");
                self.shoppingList.deleteAll();
            }){
                ZStack{
                    RoundedRectangle(cornerRadius: 15.0)
                        .frame(width:100,height: 50)
                        .foregroundColor(.gray)
                        .opacity(0.5)
                    Text("Delete All")
                        .foregroundColor(.white)
                }.padding(.top,10.0)
            }
            VStack(alignment:.leading){
                ForEach(self.shoppingList.finalData , id:\.self){(ingredient) in
                    ShoppingListCard(ingredient:ingredient,checked:ingredient.purchased)
                }.padding(.horizontal,15)
            }.frame(width:UIScreen.main.bounds.size.width)
        }
            
    }
}

struct IngredientShoppingList_Previews: PreviewProvider {
    static var previews: some View {
        IngredientShoppingList()
    }
}

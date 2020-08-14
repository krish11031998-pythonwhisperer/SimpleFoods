//
//  ShoppingListCard.swift
//  SimpleFood
//
//  Created by Krishna Venkatramani on 6/24/20.
//  Copyright © 2020 Team Krish. All rights reserved.
//

import SwiftUI

struct ShoppingListCard: View {
    var shoppingList = ShoppingList();
    var ingredient: RealmIngredient;
    @State var checked : Bool;
    var body: some View {
        Button(action: {
            self.shoppingList.updateObj(id: self.ingredient.id);
            self.checked = !self.checked;
            
        }) {
            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(self.checked ? Color(.green) : Color(.red))
                    .frame(minHeight: 50,idealHeight: 75)
                    .opacity(0.75)
                ZStack{
                    
                    HStack{
                        Text(ingredient.name.capitalized)
                            .font(.custom("Avenir Next", size: 17.50))
                            .fontWeight(.semibold)
                            .strikethrough(self.checked, color: Color(.white))
                            .foregroundColor(.white)
                        Spacer()
                        Text("\(ingredient.quantity) \(ingredient.unit)")
                            .font(.custom("Avenir Next", size: 17.50))
                            .fontWeight(.semibold)
                            .strikethrough(self.checked, color: Color(.white))
                            .foregroundColor(self.checked ? .black : .white)
                            .padding(.trailing)
                    }
                }.padding(.leading,10)
                
            }
            
        }
        
        
    }
}

struct ShoppingListCard_Previews: PreviewProvider {
    static var ingredient:RealmIngredient{
        get{
            var newIngredient = RealmIngredient()
            newIngredient.name = "Tofu"
            newIngredient.quantity = "10"
            newIngredient.unit = "g"
            return newIngredient
        }
    }
    static var previews: some View {
        ShoppingListCard(ingredient: ShoppingListCard_Previews.ingredient, checked: false)
    }
}


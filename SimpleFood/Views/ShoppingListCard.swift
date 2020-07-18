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
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(self.checked ? Color(.green) : Color(.red))
                .opacity(0.75)
                .frame(height: 50)
                .overlay(
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
                    }.padding(.leading,10))
        }
       

    }
}
//
//struct ShoppingListCard_Previews: PreviewProvider {
//    static var previews: some View {
//        ShoppingListCard()
//    }
//}


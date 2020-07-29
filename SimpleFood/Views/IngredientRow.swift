//
//  IngredientRow.swift
//  SimpleFood
//
//  Created by Krishna Venkatramani on 6/14/20.
//  Copyright © 2020 Team Krish. All rights reserved.
//

import SwiftUI
import ChameleonFramework
var cellWidth = UIScreen.main.bounds.size.width/1.25 - 10;
struct IngredientRow: View {
    @Environment(\.colorScheme) var colorScheme
    var icon:String{
        get{
            return self.type == "ingredients" ? "salad" : "timelapse"
        }
    }
    
    var texticon:String{
        get{
            return self.type == "ingredients" ? "checkmark.circle" : "stopwatch.fill"
        }
    }
    var shoppingList = ShoppingList();
    var titleIcon = "list.dash"
    var recipe:[EdamamIngredient] = [];
    //    var steps:[Steps] = []
    var color:UIColor = FlatYellow();
    var type:String = "ingredients";
    var title:String = "";
    init(recipe:[EdamamIngredient]=[],color:UIColor=FlatYellow(),type:String="ingredients",title:String?=nil){
        self.recipe = recipe;
        self.color = color;
        self.type = type;
        if let safeTitle = title{
            self.title = safeTitle;
        }
    }
    
    var recipeID:[EIngredientID]{
        get{
            var count = 0;
            return self.recipe.map { (ing) -> EIngredientID in
                let newIng = EIngredientID(id: count, details: ing)
                count+=1;
                return newIng;
            }
        }
    }
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 10){
            VStack(alignment:.leading){
                if title != "" {
                    HStack(alignment: .firstTextBaseline, spacing: 10){
                        
                        Image(uiImage: UIImage(systemName: self.titleIcon)!)
                            .frame(width: 15, height: 15).padding(.trailing,10)
                        Text(title)
                            .font(.custom("Avenir Next", size: 25.0))
                            
                            .fontWeight(.semibold)
                            .fixedSize(horizontal: false, vertical: true)
                            
                    }
                    
                }
                HStack(alignment: .center){
                    
//                    Image(uiImage: UIImage(named: self.icon)!)
//                    .resizable()
//                        .renderingMode(.original)
//                        .frame(width: 25, height: 25).padding(.trailing,5)
//                    Text(self.type.capitalized)
//                        .font(.custom("Avenir Next", size: 20.0))
//                        .fontWeight(.semibold)
                    Titles(title: "Ingredients",imageStr: "salad")
                    Spacer()
                    if type == "ingredients"{
                        Button(action: {
                            self.recipeID.forEach { (component) in
                                self.addComponent(component: component)
                            }
                        }) {
                            Circle()
                                .frame(width: 25, height: 25)
                                .foregroundColor(.gray)
                                .opacity(0.5)
                                .overlay(Image(systemName: "plus"))
                                .padding(.trailing,10)
                        }
                        
                    }
                }
            }
            VStack(alignment: .leading, spacing: 20){
                if type == "ingredients"{
                    ForEach(self.recipeID){(component) in
                        ZStack{
                            RoundedRectangle(cornerRadius: 20)
                                .frame(minWidth: cellWidth, idealWidth: cellWidth, maxWidth: cellWidth, minHeight: 75, idealHeight: 100, maxHeight: 250, alignment: .center)
                                .foregroundColor(Color(self.color))
                                .shadow(color: Color(self.color == UIColor.white ? UIColor.black : UIColor.white).opacity(0.5),radius: 2, x: 2, y: 2)
                            ZStack{
                                HStack(alignment: .center, spacing: 10){
                                    Button(action: {
                                        self.addComponent(component: component)
                                    }){
                                        Circle()
                                            .frame(width: 20, height: 20)
                                            .foregroundColor(.gray)
                                            .opacity(0.5)
                                            .overlay(Image(systemName: "plus"))
                                            .padding(.trailing,10)}
                                    Text(component.details.text ?? "No ingredient")
                                        .fixedSize(horizontal: false, vertical: true)
                                        .font(.system(size: 15, weight: .light, design: .serif))
                                        .foregroundColor(Color(ContrastColorOf(self.color, returnFlat: true)))
                                    Spacer()
                                    Text("\(Int(component.details.weight ?? 0.0)) g")
                                        .font(.system(size: 12.5, weight: .light, design: .serif))
                                        .foregroundColor(Color(ContrastColorOf(self.color, returnFlat: true)))
                                }.padding(.all)
                            }
                            
                        }
                    }
                }
                //                else if type == "instructions"{
                //                    ForEach(self.steps){(step) in
                //                        HStack(alignment: .top, spacing: 10){
                //                            Image(uiImage: UIImage(systemName: self.texticon)!).resizable().frame(width: 15.0, height: 15.0)
                //                            Text(step?.display_text ?? "No Instruction")
                //                                .fixedSize(horizontal: false, vertical: true)
                //                                .font(.system(size: 12.5, weight: .light, design: .serif))
                //                                .foregroundColor(Color(ContrastColorOf(self.color, returnFlat: true)))
                //                            Spacer();
                //                        }.padding(.trailing,15)
                //
                //                    }
                //                }
                
            }.padding(.top)
        }
        .frame(width: UIScreen.main.bounds.size.width/1.25)
        .padding(.all, 15.0)
        //            .background(Color(self.color))
        //            .cornerRadius(10)
    }
    
    func addComponent(component:EIngredientID?){
        if let safeIngredient = component{
            var newObj = RealmIngredient()
            newObj.name = safeIngredient.details.text ?? "";
            newObj.quantity = String(safeIngredient.details.weight ?? 0.0);
            newObj.unit = "g";
            
            self.shoppingList.saveData(newData: newObj);
        }
    }
}
//
struct IngredientRow_Previews: PreviewProvider {
    static var previews: some View {
        IngredientRow(recipe: edamamExample?.ingredients ?? [])
    }
}


//struct IngredientRow_Previews: PreviewProvider {
//    static var previews: some View {
//        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
//    }
//}

//
//  IDetailsCard.swift
//  SimpleFood
//
//  Created by Krishna Venkatramani on 8/6/20.
//  Copyright © 2020 Team Krish. All rights reserved.
//

import SwiftUI

struct IDetailsCard: View {
    var title: String
    var nutrients:[SNutrient] = []
    var selectedNutrients:[SNutrient]{
        get{
            var result:[SNutrient] = []
            var SNR = ["fat","carbohydrates","protein"]
            self.nutrients.forEach { (SN) in
                if let title = SN.title?.lowercased(), SNR.contains(title){
                    result.append(SN)
                }
                
            }
            return result
        }
    }
    var body: some View {
        HStack{
            VStack{
                Text(self.title)
                    .italic()
                    .font(.custom("Avenir Next",size: 20))
                    .fontWeight(.bold)
                    .padding(.bottom)
                
                ScrollView(.vertical) {
                    VStack{
                        ForEach(0..<self.nutrients.count){ (i) in
                            self.nutrientCard(self.nutrients[i])
                            
                        }
                    }
                }
            }
        }
    }
    
    func nutrientCard(_ nutrient:SNutrient) -> some View{
        let result = VStack{
            Text("\(nutrient.value) \(nutrient.unit ?? "l")")
                .font(.custom("Avenir Next",size: 17.5))
                .fontWeight(.bold)
            Text(nutrient.title ?? "l")
                .font(.custom("Avenir Next",size: 15))
                .fontWeight(.light)
        }
        return result
    }
}


struct InstructionDetailCard:View{
    var ingredients: [SIngredient] = []
    var active:Double{
        get{
            return self.ingredients.count > 0 ? 1 : 0
        }
    }
    var body: some View{
        VStack{
            HStack {
                Spacer()
                Text("Ingredients.")
                    .underline(true, color: Color.mainColor)
                    .font(.custom("Avenir Next", size: 17.5))
                    .italic()
                    .fontWeight(.semibold)
            
                Spacer()
            }
            ForEach(0..<self.ingredients.count){(i) in
                IIC(ingredient: self.ingredients[i])
                Divider().frame(width: 150,height: 2.5)
            }
        }.opacity(self.active)
    }
}

struct IIC:View{
    
    @ObservedObject var imageManager = DownloadImage()
    var ingredient:SIngredient? = nil{
        didSet{
            if let imageURL = self.ingredient?.image{
                self.imageManager.urlString = imageURL
                self.imageManager.getImage()
            }
        }
    }
    
    var ingredientName:String{
        get{
            return self.ingredient?.name ?? self.ingredient?.localizedName ?? "No Name"
        }
    }
    
    var body: some View{
        HStack{
            Image(uiImage: self.imageManager.image)
                .resizable()
                .frame(width: 25, height: 25)
                .cornerRadius(5).padding(.trailing)
            Text(self.ingredientName.capitalized)
                .font(.custom("Avenir Next",size: 15))
                .fontWeight(.medium)
            Spacer()
        }.frame(width:200)
    }
}

//struct IDetailsCard_Previews: PreviewProvider {
//    static var previews: some View {
//        IDetailsCard(title:"Avocado",nutrients: SExample.nutrition?.ingredients?[2].nutrients ?? [])
//    }
//}

struct IDetailsCard_Previews: PreviewProvider {
    static var previews: some View {
        InstructionDetailCard(ingredients: (SExample.analyzedInstructions?[0].steps?[0].ingredients!)!)
    }
}

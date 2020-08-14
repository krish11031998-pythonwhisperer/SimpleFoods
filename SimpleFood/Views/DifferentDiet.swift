//
//  DifferentDiet.swift
//  SimpleFood
//
//  Created by Krishna Venkatramani on 7/10/20.
//  Copyright © 2020 Team Krish. All rights reserved.
//
//["Vegan","Vegetarian","Ovo-Vegetarian","Whole30","Paleo","Primal"]

import SwiftUI
import ChameleonFramework
struct SHealthwID:Identifiable{
    var id:Int
    var health:[SHealth]
}

struct DifferentDiet: View {
    var types:[SHealth] = [.Vegan,.Vegetarian,.Paleo,.Ovo_Vegetarian,.Whole30,.Primal]
    var imagesCell:[SHealth:String] = [.Ovo_Vegetarian:"broccoli",.Vegetarian:"cauliflower",.Paleo:"meat",.Vegan:"salad",.Whole30:"potatoes-1",.Primal:"meat-2"]
    var colors:[SHealth:[Color]] = [.Vegan: [Color(UIColor.flatLime()),Color(UIColor.flatLimeDark())],
                                    .Vegetarian: [Color(UIColor.flatSkyBlue()),Color(UIColor.flatSkyBlueDark())],
                                    .Paleo: [Color(UIColor.flatMint()),Color(UIColor.flatMintDark())],
                                    .Ovo_Vegetarian: [Color(UIColor.flatOrange()),Color(UIColor.flatOrangeDark())],
                                    .Whole30: [Color(UIColor.flatPink()),Color(UIColor.flatPinkDark())],
                                    .Primal : [Color(UIColor.flatYellow()),Color(UIColor.flatYellowDark())]
    ]
    var formattedTypes:[SHealthwID]{
        get{
            var result:[SHealthwID] = []
            var resultCount = 0
            var count = 0
            var temp:[SHealth] = []
            while(count <= self.types.count){
                if count%2 == 0 && count > 0{
                    result.append(SHealthwID(id:resultCount,health:temp))
                    resultCount += 1
                    temp = []
                }
                if count < self.types.count{
                    temp.append(self.types[count])
                }
                count+=1
            }
            
            return result
        }
    }
    var body: some View {
        ScrollView(.horizontal,showsIndicators: false){
            HStack{
                ForEach(0..<self.types.count){(i) in
                    VerticalDietCell(title: self.types[i].rawValue, image: self.imagesCell[self.types[i]]!, colors: self.colors[self.types[i]]!)
                }
            }.padding(.horizontal)
        }
    }
}

struct VerticalDietCell:View{
    var title:String = ""
    var image:String = ""
    var colors:[Color] = [Color.mainColor,Color.mainColor]
    var body: some View{
        
        NavigationLink(destination:DietRecipes(self.title)) {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color.clear)
                .background(LinearGradient(gradient: .init(colors: self.colors), startPoint: .topLeading, endPoint: .bottomTrailing)).cornerRadius(20)
                .frame( width: 200, height: 250)
                .overlay(
                    VStack{
                        HStack{
                            Text("\(title.capitalized).")
                                .underline(true,color:Color.mainColor)
                                .font(.custom("Avenir Next",size: 20))
                                .fontWeight(.medium)
                                .padding(.leading,15)
                            Spacer()
                        }.padding(.top,10)
                        
                        Spacer()
                        Image(self.image)
                            .resizable()
                            .renderingMode(.original)
                            .frame(width:100,height:100)
                            .shadow(radius: 10, x: 2.5, y: 2.5)
                        Spacer()
                    }
            )
        }.buttonStyle(PlainButtonStyle())
    }
}

struct DietCell:View{
    var title:String
    var color:[Color]
    var imageStr:String
    var body: some View{
        NavigationLink(destination:DietRecipes(self.title)){
            RoundedRectangle(cornerRadius: 20)
                .fill(LinearGradient(gradient: .init(colors: self.color), startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width:width/2,height:100)
                .opacity(0.5)
                .overlay(
                    HStack{
                        Image(self.imageStr)
                            .resizable()
                            .renderingMode(.original)
                            .frame(width:25,height:25)
                        Text(self.title.capitalized)
                            .font(.custom("Avenir Next", size: 12.5))
                            .fontWeight(.medium)
                })
        }
        
    }
}


struct DifferentDiet_Previews: PreviewProvider {
    static var previews: some View {
        DifferentDiet()
    }
}

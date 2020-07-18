//
//  DifferentDiet.swift
//  SimpleFood
//
//  Created by Krishna Venkatramani on 7/10/20.
//  Copyright © 2020 Team Krish. All rights reserved.
//

import SwiftUI
import ChameleonFramework
struct HealthwID:Identifiable{
    var id:Int;
    var health:[Health];
}

struct DifferentDiet: View {
    var types:[Health] = [.Vegan,.Vegetarian,.Keto,.Eggs,.Dairy,.No_sugar]
    var imagesCell:[Health:String] = [.Vegan:"broccoli",.Vegetarian:"cauliflower",.Keto:"salad",.Eggs:"egg",.Dairy:"potatoes-1",.No_sugar:"honey"]
    var formattedTypes:[HealthwID]{
        get{
            var result:[HealthwID] = [];
            var resultCount = 0;
            var count = 0
            var temp:[Health] = []
            while(count <= self.types.count){
                if count%2 == 0 && count > 0{
                    result.append(HealthwID(id:resultCount,health:temp))
                    resultCount += 1
                    temp = []
                }
                if count < self.types.count{
                    temp.append(self.types[count])
                }
                count+=1
            }
            
            return result;
        }
    }
    var body: some View {
        VStack(alignment: .center){
            ForEach(self.formattedTypes){(hID) in
                HStack(spacing: 5){
                    DietCell(title: hID.health[0].rawValue,imageStr: self.imagesCell[hID.health[0]] ?? "")
                    DietCell(title:hID.health[1].rawValue, imageStr: self.imagesCell[hID.health[1]] ?? "")
                }
            }
        }
    }
}

struct DietCell:View{
    var title:String;
    var color:UIColor = UIColor.randomFlat();
    var imageStr:String;
    var body: some View{
        NavigationLink(destination:DietRecipes(self.title)){
            RoundedRectangle(cornerRadius: 20)
                .frame(width:width/2,height:100)
                .foregroundColor(.gray)
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
                            .foregroundColor(.white)
                })
        }
        
    }
}


struct DifferentDiet_Previews: PreviewProvider {
    static var previews: some View {
        DifferentDiet()
    }
}

//
//  FoodRow.swift
//  SimpleFood
//
//  Created by Krishna Venkatramani on 6/13/20.
//  Copyright © 2020 Team Krish. All rights reserved.
//

import SwiftUI
var count = 0;
let foodtypes = "carrot broccoli asparagus cauliflower corn cucumber green pepper lettuce mushrooms onion potato pumpkin red pepper tomato beetroot brussel sprouts peas zucchini radish sweet potato artichoke leek cabbage celery chili garlic basil coriander parsley dill rosemary oregano cinnamon saffron green bean bean chickpea lentil apple apricot avocado banana blackberry blackcurrant blueberry boysenberry cherry coconut fig grape grapefruit kiwifruit lemon lime lychee mandarin mango melon nectarine orange papaya passion fruit peach pear pineapple plum pomegranate quince raspberry strawberry watermelon salad pizza pasta popcorn lobster steak bbq pudding hamburger pie cake sausage tacos kebab poutine seafood chips fries masala paella som tam chicken toast marzipan tofu ketchup hummus chili maple syrup parma ham fajitas champ lasagna poke chocolate croissant arepas bunny chow pierogi donuts rendang sushi ice cream duck curry beef goat lamb turkey pork fish crab bacon ham pepperoni salami ribs".components(separatedBy: " ").map { (name) -> FoodType in
    count+=1;
    return FoodType(id: "\(count)", name: name)
};

struct FoodRow: View {
    @ObservedObject var FDM :EdamamAPIManager = EdamamAPIManager();
    var type:String = "food"
    var cellType = "SmallCell"
    var titleImageStr:String = "";
    var title : String;
    init(type:String,title:String,cellType:String = "SmallCell",q:String = "pizza", health:Health = .Vegetarian, imageStr:String? = nil){
        self.type = type;
        self.title = title.components(separatedBy: "_").map({ $0.capitalized }).reduce("", { (a, b) -> String in
            return a+" "+b
        });
        if let imageStr = imageStr{
            self.titleImageStr = imageStr;
        }
        self.FDM.query = queryParams(q: q, from: 0, to: 5, health: [health])
        self.FDM.getResults();
        self.cellType = cellType;
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 7.5){
            HStack{
                if self.titleImageStr != ""{
                    Image(titleImageStr)
                        .resizable()
                        .renderingMode(.original)
                        .frame(width:40,height: 40)
                        .padding(.leading,10)
                }
                Text(title)
                    .font(.title)
                    .padding(.leading, 5)
            }.padding(.leading,10)
            
            ScrollView(.horizontal, showsIndicators: false, content: {
                HStack(alignment: .top){
                    if type == "food"{
                        ForEach(self.FDM.result){(food) in
                            if self.cellType == "SmallCell"{
                                FoodCell(food: food.recipe,type: "normal")
                            }
                        }
                    }
                    Button(action: {
                        print("Clicked more!");
                    }){
                        VStack(alignment: .center,spacing: 5){
                            Circle()
                                .frame(width:50, height: 50)
                                .foregroundColor(.gray)
                                .overlay(Image(systemName: "plus"))
                            Text("More")
                                .font(.subheadline)
                            
                        }
                    }
                    
                }.frame(height:200).padding(.horizontal,10)
            }).padding(.top)
        }.padding(.top)
    }
}




struct FoodRow_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView(.vertical){
            FoodRow(type: "food", title: "under_30_minutes")
        }
        
    }
}

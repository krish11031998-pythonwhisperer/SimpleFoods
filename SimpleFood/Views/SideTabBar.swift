//
//  SideTabBar.swift
//  SimpleFood
//
//  Created by Krishna Venkatramani on 7/25/20.
//  Copyright © 2020 Team Krish. All rights reserved.
//

import SwiftUI

struct SideTabBar: View {
    @Binding var value:SMeal;
    var Dishes:[SMeal] = [.Breakfast,.Beverage, .Salad, .Drink, .Snack];
    var foods:[SResult] = [];
    var body: some View {
        HStack{
            ZStack{
                Rectangle()
                    .fill(Color.gray)
                    .opacity(0.5)
                    .frame(width: 50,height:300)
                    .clipShape(Corners(corner: [.topRight,.bottomRight], size: CGSize(width: 50, height: 50)))
                HStack(spacing: 5){
                    ForEach(self.Dishes, id: \.self){(dish) in
                        
                        VStack(spacing:1.5){
                            Circle()
                                .frame(width: 5, height: 5)
                                .opacity(self.value == dish ? 1.0 : 0)
//                                .opacity(self.Dishes. == 0 ? 1.0 : 0)
                            Text(dish.rawValue.capitalized)
                                .font(.custom("Avenir Next", size: 12.5))
                                .fontWeight(.medium)
                                .frame(width: 60)
                                .fixedSize(horizontal: false, vertical: true)
                                .onTapGesture{
                                    self.value = dish
                            }.frame(width: 50)
                        }.padding(.bottom)
                        
                    }
                }.frame(width: 50,height:350).rotationEffect(.init(degrees: 270))
            }
            
            ScrollView(.horizontal,showsIndicators: false){
                HStack(spacing: 5){
                    ForEach(0..<self.foods.count){(i) in
                        FoodVerticalCell(self.foods[i])
                    }
                }
            }
            
            Spacer()
        }.edgesIgnoringSafeArea(.all)
    }
}

//struct SideTabBar_Previews: PreviewProvider {
//    static var previews: some View {
//        SideTabBar(foods: SExamples)
//    }
//}

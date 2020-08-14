//
//  FoodTabs.swift
//  SimpleFood
//
//  Created by Krishna Venkatramani on 8/1/20.
//  Copyright © 2020 Team Krish. All rights reserved.
//

import SwiftUI

struct FoodTabs: View {
    @Binding var value:SMeal;
    @ObservedObject var SFDM:SAPIManager = SAPIManager();
    var Dishes:[SMeal] = [.Breakfast,.Beverage, .Salad, .Drink, .Snack];
//    var foods:[SResult] = [];
    var query:SQuery{
        didSet{
            self.SFDM.query = self.query;
            self.SFDM.getResults()
        }
    }
    
    func isActive(_ i:Int) -> Bool{
        return self.value == self.Dishes[i]
    }
    
    var foods:[SResult]{
        get{
            return self.SFDM.result.count > 0 ? self.SFDM.result : [SExample,SExample]
        }
        
    }
    
    var body: some View {
        
        VStack(alignment: .center){
            ScrollView(.horizontal,showsIndicators: false){
                HStack(spacing:10){
                    Spacer()
                    ForEach(0..<self.Dishes.count){(i) in
                        Text(self.Dishes[i].rawValue)
                            .underline(self.isActive(i), color: Color.mainColor)
                            .font(.custom("Avenir Next",size:17.5))
                            .fontWeight(.medium)
                            .opacity(self.isActive(i) ? 1 : 0.5)
                            .onTapGesture {
                                self.value = self.Dishes[i]
                        }
                    }
                    Spacer()
                }
            }
//            ForEach(0..<self.Dishes.count){(i) in
            FoodTabsScrollView( SQuery(type: self.value.rawValue, instructionsRequired: true, addRecipeInformation: true, addRecipeNutrition: true, number: 10))
//            }
            
            
        }.padding(.horizontal,10)
    }
}


struct FoodTabsScrollView:View{
    @ObservedObject var SFDM:SAPIManager = SAPIManager();
    var query = SQuery()
    
    init(_ query:SQuery){
        self.query = query;
        self.SFDM.query = self.query;
        self.SFDM.getResults()
    }
    
    var body: some View{
        ScrollView(.horizontal,showsIndicators: false){
            HStack(spacing:10){
                ForEach(self.SFDM.result.count > 0 ? self.SFDM.result : [SExample,SExample]){(food) in
                    FoodVerticalCell(food)
                }
            }
        }
    }
}

//struct FoodTabs_Previews: PreviewProvider {
//    static var previews: some View {
//        FoodTabs()
//    }
//}

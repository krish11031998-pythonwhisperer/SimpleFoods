//
//  NutrientBars.swift
//  SimpleFood
//
//  Created by Krishna Venkatramani on 6/20/20.
//  Copyright © 2020 Team Krish. All rights reserved.
//

import SwiftUI
import ChameleonFramework
struct NutrientBars: View {
    
    var nutrition_info:[String:SNutrient] = [:]
    var breakdownData:SCaloricBreakdown?
    var nutrients:[SNutrient] = []
    var nutritions:[String] = ["fat","calories","carbohydrates","protein","fiber","sugar"]
    @State var activeCard:String = ""
    var colors:[[UIColor]] = [[FlatWatermelon(),FlatWatermelonDark()],[FlatTeal(),FlatTealDark()],[FlatSkyBlue(),FlatSkyBlueDark()],[FlatBlue(),FlatBlueDark()],[ FlatLime(), FlatLimeDark()],[FlatPurple(),FlatPurpleDark()]]
    func getValue(_ count:Int) -> Int{
        return self.nutrition_info[self.nutritions[count]]?.value ?? 0
    }
    func getMax(_ count:Int) -> Int{
        return self.nutrition_info[self.nutritions[count]]?.max ?? 0
    }
    
    //    func getPercent(_ count:Int) -> Float{
    //        return self.nutrition_info[self.nutritions[count]]?.percent ?? 0.0
    //    }
    
    func getTitle(_ count:Int) -> String{
        return self.nutritions[count].capitalized == "Carbohydrates" ? "Carbs" : self.nutritions[count].capitalized
    }
    
    func getUnit(_ count:Int) -> String{
        return self.nutrition_info[self.nutritions[count]]?.unit ?? "g"
    }
    
    var nutrientPercent:[String:SNutrient]{
        get{
            var finalNutrient:[String:SNutrient] = [:]
            var nutri = ["fat","calories","carbohydrates","protein","fiber","sugar"]
            nutrients.forEach { (nutrient) in
                if let title = nutrient.title?.lowercased(){
                    if nutri.contains(title){
                        finalNutrient[title] = nutrient
                    }
                }
            }
            return finalNutrient
            
            
        }
    }
    
    func breakdownPercent(_ type:String) -> Float{
        var value:Float = 0.0
        if let BD = self.breakdownData{
            switch(type.lowercased()){
            case "protein":
                value = BD.percentProtein
                break
            case "carbs":
                value = BD.percentCarbs
                break
            case "fat":
                value = BD.percentFat
                break
            default:
                print("No bD for this type")
            }
        }
        return (value).rounded()
        
    }
    
    var LargeWaveCards: some View{
        VStack(alignment: .center, spacing: 10){
            HStack(spacing:10){
                WaveFillCards(key: self.getTitle(0), value: self.getValue(0), colorMain: self.colors[0][0], colorSecondary: self.colors[0][1],unit: self.getUnit(0) , max: self.getMax(0))
                WaveFillCards(key: self.getTitle(1), value: self.getValue(1), colorMain: self.colors[1][0], colorSecondary: self.colors[1][1],unit: self.getUnit(1) , max: self.getMax(1))
            }
            HStack(spacing:10){
                WaveFillCards(key: self.getTitle(2), value: self.getValue(2), colorMain: self.colors[2][0], colorSecondary: self.colors[2][1],unit: self.getUnit(2) , max: self.getMax(2))
                WaveFillCards(key: self.getTitle(3), value: self.getValue(3), colorMain: self.colors[3][0], colorSecondary: self.colors[3][1],unit: self.getUnit(3) , max: self.getMax(3))
            }
            HStack(spacing:10){
                WaveFillCards(key: self.getTitle(4), value: self.getValue(4), colorMain: self.colors[4][0], colorSecondary: self.colors[4][1],unit: self.getUnit(4) , max: self.getMax(4))
                WaveFillCards(key: self.getTitle(5), value: self.getValue(5), colorMain: self.colors[5][0], colorSecondary: self.colors[5][1],unit: self.getUnit(5) , max: self.getMax(5))
            }
        }.padding(.all)
    }
    
    var SmallWaveCards:some View{
        VStack{
            HStack(spacing:10){
                SRR(showDetails: self.$activeCard, key: self.getTitle(0), value: self.getValue(0), colorMain: self.colors[0][0], colorSecondary: self.colors[0][1],unit: self.getUnit(0) , max: self.getMax(0),percentTotal: Int(self.breakdownPercent(self.getTitle(0))))
                SRR(showDetails: self.$activeCard, key: self.getTitle(1), value: self.getValue(1), colorMain: self.colors[1][0], colorSecondary: self.colors[1][1],unit: self.getUnit(1) , max: self.getMax(1),percentTotal: Int(self.breakdownPercent(self.getTitle(1))))
                SRR(showDetails: self.$activeCard, key: self.getTitle(2), value: self.getValue(2), colorMain: self.colors[2][0], colorSecondary: self.colors[2][1],unit: self.getUnit(2) , max: self.getMax(2),percentTotal: Int(self.breakdownPercent(self.getTitle(2))))
            }
            HStack(spacing:10){
                
                SRR(showDetails: self.$activeCard, key: self.getTitle(3), value: self.getValue(3), colorMain: self.colors[3][0], colorSecondary: self.colors[3][1],unit: self.getUnit(3) , max: self.getMax(3),percentTotal: Int(self.breakdownPercent(self.getTitle(3))))
                SRR(showDetails: self.$activeCard, key: self.getTitle(4), value: self.getValue(4), colorMain: self.colors[4][0], colorSecondary: self.colors[4][1],unit: self.getUnit(4) , max: self.getMax(4),percentTotal: Int(self.breakdownPercent(self.getTitle(4))))
                SRR(showDetails: self.$activeCard, key: self.getTitle(5), value: self.getValue(5), colorMain: self.colors[5][0], colorSecondary: self.colors[5][1],unit: self.getUnit(5) , max: self.getMax(5),percentTotal: Int(self.breakdownPercent(self.getTitle(5))))
            }
        }.padding(.all)
        
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 5) {
            HStack{
                Spacer()
                Titles(title: "Nutrition Info",imageStr: "pizza-5")
                Spacer()
            }
            
            self.SmallWaveCards
        }
        
    }
}

//struct NutrientBars_Previews: PreviewProvider {
//    static var previews: some View {
//        NutrientBars(nutrition_info: ["protein":["value":12,"max":100],"carbs":["value":89,"max":100],"fats":["value": 198,"max":300],"fiber":["value":54,"max":100]])
//    }
//}

struct NutrientBars_Previews: PreviewProvider {
    static var previews: some View {
        NutrientBars(nutrients: (SExample.nutrition?.nutrients!)!)
    }
}

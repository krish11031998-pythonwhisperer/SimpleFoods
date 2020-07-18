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
    
    var nutrition_info:[String:Float];
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Nutrition Info")
            .font(.headline)
            .padding(.all)
            
            VStack(alignment: .center, spacing: 5){
                
                HStack{
                    SRR(key: "Fat", value: Int(self.nutrition_info["fat"] ?? 0.0), color: FlatRed(),unit: "g");
                    SRR(key: "Protein", value: Int(self.nutrition_info["protein"] ?? 0.0), color:FlatGreenDark(),unit: "g");
                    SRR(key: "Carbs", value: Int(self.nutrition_info["carbs"] ?? 0.0), color: FlatSkyBlueDark(),unit: "g");
                }
                HStack{
                    SRR(key: "Fiber", value: Int(self.nutrition_info["fiber"] ?? 0.0), color: FlatBlue(),unit: "g");
                    SRR(key: "Sugar", value: Int(self.nutrition_info["sugar"] ?? 0.0), color:FlatLimeDark(),unit: "g");
                    SRR(key: "Cal", value: Int(self.nutrition_info["energy"] ?? 0.0), color: FlatTealDark(),unit: "kcal");
                }
            }.padding(.all)
        }
        
    }
}

//struct NutrientBars_Previews: PreviewProvider {
//    static var previews: some View {
//        NutrientBars(nutrition_info: example.nutrition ?? Nutrition(fiber: 5, protein: 5, fat: 5, calories: 5, sugar: 5, carbohydrates: 5))
//    }
//}

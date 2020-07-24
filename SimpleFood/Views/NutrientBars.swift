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
    
    var nutrition_info:[String:[String:Int]];
    var body: some View {
        VStack(alignment: .center, spacing: 5) {
            
//            HStack(alignment: .firstTextBaseline){
//                Spacer()
//                Image(uiImage: UIImage(named:"pizza-5")!)
//                    .resizable()
//                    .renderingMode(.original)
//                    .frame(width: 30, height: 30).padding(.trailing,5)
//                Text("Nutrition Info")
//                .font(.custom("Avenir Next", size: 20))
//                    .fontWeight(.medium)
//                Spacer()
//            }
            HStack{
                Spacer()
                Titles(title: "Nutrition Info",imageStr: "pizza-5")
                Spacer()
            }
            
            
//            .italic()
//            .padding(.leading,50)
            
            VStack(alignment: .center, spacing: 10){
                
                HStack(spacing:0){
                    SRR(key: "Fat", value: Int(self.nutrition_info["Fat"]?["value"] ?? Int(0.0)), color: FlatRed(),unit: "g" , max: Int(self.nutrition_info["Fat"]?["max"] ?? Int(0.0)))
                    SRR(key: "Protein", value: Int(self.nutrition_info["Protein"]?["value"] ?? Int(0.0)), color:FlatGreenDark(),unit: "g",max: Int(self.nutrition_info["Protein"]?["max"] ?? Int(0.0)));
                    
                }
                HStack(spacing:0){
                    SRR(key: "Carbs", value: Int(self.nutrition_info["Carbs"]?["value"] ?? Int(0.0)), color: FlatSkyBlueDark(),unit: "g",max: Int(self.nutrition_info["Carbs"]?["max"] ?? Int(0.0)));
                    SRR(key: "Fiber", value: Int(self.nutrition_info["Fiber"]?["value"] ?? Int(0.0)), color: FlatBlue(),unit: "g",max: Int(self.nutrition_info["Fiber"]?["max"] ?? Int(0.0)));
                }
//                HStack(spacing:0){
//                    
//                    SRR(key: "Sugar", value:  Int(self.nutrition_info["sugar"]?["value"] ?? Int(0.0)), color:FlatLimeDark(),unit: "g",max: Int(self.nutrition_info["sugar"]?["max"] ?? Int(0.0)));
//                    SRR(key: "Cal", value:  Int(self.nutrition_info["sugar"]?["value"] ?? Int(0.0)), color: FlatTealDark(),unit: "kcal");
//                }
            }.padding(.all)
        }
        
    }
}

struct NutrientBars_Previews: PreviewProvider {
    static var previews: some View {
        NutrientBars(nutrition_info: ["protein":["value":12,"max":100],"carbs":["value":89,"max":100],"fats":["value": 198,"max":300],"fiber":["value":54,"max":100]])
    }
}

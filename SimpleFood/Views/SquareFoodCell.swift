//
//  SquareFoodCell.swift
//  SimpleFood
//
//  Created by Krishna Venkatramani on 6/15/20.
//  Copyright © 2020 Team Krish. All rights reserved.
//

import SwiftUI

struct SquareFoodCell: View {
    @ObservedObject var imageManager = DownloadImage()
    init(food:EdamamRecipe) {
        self.food = food;
        self.loadImage();
    }
    var food : EdamamRecipe;
    var width:CGFloat = UIScreen.main.bounds.size.width/2.25;
    var height:CGFloat = UIScreen.main.bounds.size.height/4;
    var body: some View {
        
            VStack(alignment: .leading){
                NavigationLink(destination: FoodDetailView(food: self.food)) {
                    RoundedRectangle(cornerRadius: 10.0)
                        .frame(width: width, height: height, alignment: .center)
                        .overlay(
                            Image(uiImage: self.imageManager.image)
                                .frame(width: width, height: height, alignment: .center)
                                .scaledToFill()
                                .cornerRadius(10.0)
                    )
                        
                }.buttonStyle(PlainButtonStyle())
                Text(food.label ?? "No Title")
                    //                .foregroundColor(.white)
                    .font(.custom("Avenir Next", size: 10))
                    .fontWeight(.regular)
                    .padding(.horizontal,5)
                    .lineLimit(3)
                        
            }
        
        
    }
    
    func loadImage(){
        print("The food in the food cell : \(self.food)")
        self.imageManager.urlString = self.food.image ?? ""
        self.imageManager.getImage();
    }
}

//struct SquareFoodCell_Previews: PreviewProvider {
//    static var previews: some View {
//        SquareFoodCell(food: TastyFood(country: Optional("US"), total_time_minutes: nil, total_time_tier: nil, instructions: Optional([SimpleFood.Steps(position: Optional(1), temperature: Optional(425), id: Optional(56878), display_text: Optional("Preheat oven to 425ºF.")), SimpleFood.Steps(position: Optional(2), temperature: nil, id: Optional(56879), display_text: Optional("In a small bowl, combine miso, Nakano® Sesame Rice Vinegar, soy sauce, honey, ginger, and garlic. Stir until miso is broken down and sauce is relatively smooth (a few small clumps are fine).")), SimpleFood.Steps(position: Optional(3), temperature: nil, id: Optional(56880), display_text: Optional("Place wings in a bowl and season with kosher salt. Pour approximately two-thirds of the miso sauce over the wings (reserve the rest of the sauce). Toss to combine.")), SimpleFood.Steps(position: Optional(4), temperature: nil, id: Optional(56881), display_text: Optional("Spread out coated wings on a parchment-lined sheet tray.")), SimpleFood.Steps(position: Optional(5), temperature: nil, id: Optional(56882), display_text: Optional("Bake wings for 20 minutes.")), SimpleFood.Steps(position: Optional(6), temperature: nil, id: Optional(56883), display_text: Optional("Remove from oven and spoon a bit of the reserved sauce over each wing. Sprinkle each wing with sesame seeds.")), SimpleFood.Steps(position: Optional(7), temperature: nil, id: Optional(56884), display_text: Optional("Place tray back in oven and cook for 5 more minutes, or until wings are golden brown and cooked through.")), SimpleFood.Steps(position: Optional(8), temperature: nil, id: Optional(56885), display_text: Optional("Garnish wings with minced cilantro before serving.")), SimpleFood.Steps(position: Optional(9), temperature: nil, id: Optional(56886), display_text: Optional("*Note: if Nakano® Sesame Rice Vinegar cannot be found, substitute Nakano® Seasoned Rice Vinegar with a dash of sesame oil.")), SimpleFood.Steps(position: Optional(10), temperature: nil, id: Optional(56908), display_text: Optional("Enjoy!"))]), thumbnail_url: Optional("https://img.buzzfeed.com/thumbnailer-prod-us-east-1/video-api/assets/270300.jpg"), original_video_url: Optional("https://s3.amazonaws.com/video-api-prod/assets/0fe3febb4cb14d8ea25144c1e5cde99e/Mizkan_SesameChickenWings_35250_DF_V1_FB_1.mp4"), sections: Optional([SimpleFood.Section(components: Optional([SimpleFood.Component(ingredient: Optional(SimpleFood.Ingredient(id: Optional(3546), name: Optional("miso"), display_singular: Optional("miso"), display_plural: Optional("misoes"))), id: Optional(69911.0), raw_text: Optional("¼ cup miso"), extra_comment: Optional(""), position: Optional(1), measurements: Optional([SimpleFood.Quantity(quantity: Optional("¼"), unit: Optional(SimpleFood.Unit(name: Optional("cup"), abbreviation: Optional("c"), display_plural: Optional("cups")))), SimpleFood.Quantity(quantity: Optional("60"), unit: Optional(SimpleFood.Unit(name: Optional("milliliter"), abbreviation: Optional("mL"), display_plural: Optional("mL"))))])), SimpleFood.Component(ingredient: Optional(SimpleFood.Ingredient(id: Optional(6589), name: Optional("Nakano® Sesame Rice Vinegar"), display_singular: Optional("Nakano® Sesame Rice Vinegar"), display_plural: Optional("Nakano® Sesame Rice Vinegars"))), id: Optional(69912.0), raw_text: Optional("2½ tablespoons Nakano® Sesame Rice Vinegar*"), extra_comment: Optional(""), position: Optional(2), measurements: Optional([SimpleFood.Quantity(quantity: Optional("2 ½"), unit: Optional(SimpleFood.Unit(name: Optional("tablespoon"), abbreviation: Optional("tbsp"), display_plural: Optional("tablespoons"))))])), SimpleFood.Component(ingredient: Optional(SimpleFood.Ingredient(id: Optional(28), name: Optional("soy sauce"), display_singular: Optional("soy sauce"), display_plural: Optional("soy sauces"))), id: Optional(69913.0), raw_text: Optional("4 teaspoons soy sauce"), extra_comment: Optional(""), position: Optional(3), measurements: Optional([SimpleFood.Quantity(quantity: Optional("4"), unit: Optional(SimpleFood.Unit(name: Optional("teaspoon"), abbreviation: Optional("tsp"), display_plural: Optional("teaspoons"))))])), SimpleFood.Component(ingredient: Optional(SimpleFood.Ingredient(id: Optional(52), name: Optional("honey"), display_singular: Optional("honey"), display_plural: Optional("honeys"))), id: Optional(69914.0), raw_text: Optional("3 tablespoons honey"), extra_comment: Optional(""), position: Optional(4), measurements: Optional([SimpleFood.Quantity(quantity: Optional("3"), unit: Optional(SimpleFood.Unit(name: Optional("tablespoon"), abbreviation: Optional("tbsp"), display_plural: Optional("tablespoons"))))])), SimpleFood.Component(ingredient: Optional(SimpleFood.Ingredient(id: Optional(273), name: Optional("ginger"), display_singular: Optional("ginger"), display_plural: Optional("gingers"))), id: Optional(69915.0), raw_text: Optional("1½ tablespoons grated ginger"), extra_comment: Optional("grated"), position: Optional(5), measurements: Optional([SimpleFood.Quantity(quantity: Optional("1 ½"), unit: Optional(SimpleFood.Unit(name: Optional("tablespoon"), abbreviation: Optional("tbsp"), display_plural: Optional("tablespoons"))))])), SimpleFood.Component(ingredient: Optional(SimpleFood.Ingredient(id: Optional(95), name: Optional("garlic"), display_singular: Optional("garlic"), display_plural: Optional("garlics"))), id: Optional(69916.0), raw_text: Optional("2 cloves garlic, grated"), extra_comment: Optional("grated"), position: Optional(6), measurements: Optional([SimpleFood.Quantity(quantity: Optional("2"), unit: Optional(SimpleFood.Unit(name: Optional("clove"), abbreviation: Optional("clove"), display_plural: Optional("cloves"))))])), SimpleFood.Component(ingredient: Optional(SimpleFood.Ingredient(id: Optional(250), name: Optional("chicken wings"), display_singular: Optional("chicken wing"), display_plural: Optional("chicken wings"))), id: Optional(69917.0), raw_text: Optional("3 pounds chicken wings, party style (flats and drumettes separated)"), extra_comment: Optional("party style (flats and drumettes separated)"), position: Optional(7), measurements: Optional([SimpleFood.Quantity(quantity: Optional("3"), unit: Optional(SimpleFood.Unit(name: Optional("pound"), abbreviation: Optional("lb"), display_plural: Optional("lb")))), SimpleFood.Quantity(quantity: Optional("1.3"), unit: Optional(SimpleFood.Unit(name: Optional("kilogram"), abbreviation: Optional("kg"), display_plural: Optional("kg"))))])), SimpleFood.Component(ingredient: Optional(SimpleFood.Ingredient(id: Optional(11), name: Optional("kosher salt"), display_singular: Optional("kosher salt"), display_plural: Optional("kosher salts"))), id: Optional(69918.0), raw_text: Optional("Kosher salt"), extra_comment: Optional(""), position: Optional(8), measurements: Optional([SimpleFood.Quantity(quantity: Optional("0"), unit: Optional(SimpleFood.Unit(name: Optional(""), abbreviation: Optional(""), display_plural: Optional(""))))])), SimpleFood.Component(ingredient: Optional(SimpleFood.Ingredient(id: Optional(1006), name: Optional("sesame seed"), display_singular: Optional("sesame seed"), display_plural: Optional("sesame seeds"))), id: Optional(69919.0), raw_text: Optional("Sesame seeds"), extra_comment: Optional(""), position: Optional(9), measurements: Optional([SimpleFood.Quantity(quantity: Optional("0"), unit: Optional(SimpleFood.Unit(name: Optional(""), abbreviation: Optional(""), display_plural: Optional(""))))])), SimpleFood.Component(ingredient: Optional(SimpleFood.Ingredient(id: Optional(372), name: Optional("fresh cilantro"), display_singular: Optional("fresh cilantro"), display_plural: Optional("fresh cilantros"))), id: Optional(69920.0), raw_text: Optional("Minced cilantro, for garnish"), extra_comment: Optional("for garnish"), position: Optional(10), measurements: Optional([SimpleFood.Quantity(quantity: Optional("0"), unit: Optional(SimpleFood.Unit(name: Optional(""), abbreviation: Optional(""), display_plural: Optional(""))))]))]))]), name: Optional("Miso-Glazed Sesame Chicken Wings"), yields: Optional("Servings: 4"), credits: Optional([SimpleFood.Credit(name: Optional("Nakano"))]), tags: Optional([SimpleFood.Tag(id: Optional(4202175.0), name: Optional("sponsored_recipe"), display_name: Optional("Sponsored Recipe"), type: Optional("business_tags"))]), prep_time_minutes: nil, nutrition: Optional(SimpleFood.Nutrition(fiber: Optional(0), protein: Optional(53), fat: Optional(52), calories: Optional(756), sugar: Optional(17), carbohydrates: Optional(20))))
//)
//    }
//}

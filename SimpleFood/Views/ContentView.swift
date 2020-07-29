//
//  ContentView.swift
//  SimpleFood
//
//  Created by Krishna Venkatramani on 6/13/20.
//  Copyright © 2020 Team Krish. All rights reserved.
//

import SwiftUI
import ChameleonFramework


struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var windows : Int = 0;
    @State var deleteAll:Bool = false;
    var animatedTopBar:CGFloat{
        get{
            return 200
        }
    }
    var Title:String{
        get{
            return self.windows == 0 ? "Simple Foods" : self.windows == 1 ? "Search" : self.windows == 2 ? "Shopping List" : self.windows == 3 ? "Favorites" : ""
        }
    }
    
    var body: some View {
        NavigationView{
            VStack{
                if self.windows == 0{
                    ScrollView(.vertical, showsIndicators: false){
                        AnimatedWaves().frame(width:UIScreen.main.bounds.width)
                            .overlay(
                                Text(self.Title)
                                    .font(.custom("Avenir Next", size: 40))
                                    .fontWeight(.light)
                                
                        )
                        Spacer()
                        HStack{
                            Rectangle()
                                .fill(Color(UIColor.flatLime()))
                                .frame(width:UIScreen.main.bounds.width - 100,height: 150)
                                .overlay(
                                    VStack{
                                        Text("Hello Krish!").font(.custom("Avenir Next", size: 35))
                                            .fontWeight(.light)
                                        Text("Check out our new Recipes!").font(.custom("Avenir Next", size: 15))
                                            .fontWeight(.light)
                                    }.padding(.trailing)
                                    
                            ).clipShape(Corners(corner: [.topRight,.bottomRight], size: CGSize(width:45,height:70)))
                            Spacer()
                        }.padding(.top,-35)
                            .padding(.bottom,-10)
                        ZStack{
                            Color(UIColor.flatLime())
                            VStack{
                                Spacer()
                                DifferentDiet()
                                Divider().frame(width:UIScreen.main.bounds.width/1.25,height:5)
                                FoodRow(type: "food", title: "Pasta",imageStr: "pasta")
                                Divider().frame(width:UIScreen.main.bounds.width/1.25,height:5)
                                MultipleMenu()
                            }.background(self.colorScheme == .dark ? Color.black : Color.white).clipShape(Corners(corner: [.topLeft], size: CGSize(width:50,height:70)))
                        }
                    }.animation(.spring())
                }else if self.windows == 1{
                    VStack {
                        AnimatedWaves().frame(width:UIScreen.main.bounds.width)
                            .overlay(
                                Text(self.Title)
                                    .font(.custom("Avenir Next", size: 40))
                                    .fontWeight(.light)
                                
                        )
                        Spacer()
                        Text("Search")
                    };
                    Spacer()
                }else if self.windows == 2{
                    ScrollView(.vertical, showsIndicators: false){
                        
                        VStack {
                            AnimatedWaves().frame(width:UIScreen.main.bounds.width)
                                .overlay(
                                    Text(self.Title)
                                        .font(.custom("Avenir Next", size: 40))
                                        .fontWeight(.light)
                                    
                            )
                            IngredientShoppingList()
                        }
                    }.animation(.spring())
                }else if self.windows == 3{
                    ScrollView(.vertical, showsIndicators: false){
                        VStack {
                            AnimatedWaves().frame(width:UIScreen.main.bounds.width)
                                .overlay(
                                    Text(self.Title)
                                        .font(.custom("Avenir Next", size: 40))
                                        .fontWeight(.light)
                                    
                            )
                            FavoritePanel()
                        }
                    }.animation(.spring())
                    
                }
                HStack{
                    Spacer()
                    Tabs(windowIndex: self.$windows)
                    Spacer()
                }.padding(.bottom).background(Color.clear)
                
            }.edgesIgnoringSafeArea(.all)
            
        }.navigationBarHidden(true)
    }
    
    func heading() -> String{
        switch(self.windows){
        case 1:
            return "Search"
        case 2:
            return "Shopping List"
        default:
            return "SimpleFoods"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

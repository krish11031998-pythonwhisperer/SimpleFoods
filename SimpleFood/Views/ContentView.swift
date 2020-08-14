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
    @State var windows : Int = 1;
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
    
    var themeColor:Color{
        get{
            return self.colorScheme == .dark ? Color.black: Color.white
        }
    }
    
    var oppThemeColor:Color{
        get{
            return self.themeColor == .white ? .black: .white
        }
    }
    
    var body: some View {
        NavigationView{
            VStack(spacing:0){
                
                ZStack{
                    self.oppThemeColor
                    self.pages
                }
                ZStack{
                    self.oppThemeColor
                    Tabs(color: self.themeColor, windowIndex: self.$windows).padding(.bottom)
                }.frame(height:50).padding(.bottom,10)
                    .clipShape(Corners(corner: [.topLeft,.topRight], size: CGSize(width: 0, height: 1)))
            }.frame(height:height)
                .navigationBarTitle("").navigationBarHidden(true)
        }
    }
    
    var pages: some View{
        
        Group{
            if self.windows == 0{
                
                HomeView(color: self.themeColor, Title: "Simple Foods")
                
            }
            else if self.windows == 1{
                SearchView()
            }
            else if self.windows == 2{
                IngredientListView()
            }
            else if self.windows == 3{
                FavListView()
            }
        }.frame(height: height - 50).clipShape(Corners(corner: [.bottomLeft,.bottomRight], size: CGSize(width: 65, height: 50)))
        
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

struct HomeView: View{
    var color:Color = Color.white;
    var Title:String;
    var shadowColor: Color{
        get{
            return self.color == .white ? Color.black : Color.white
        }
    }
    
    var divider: some View{
        Divider().frame(width:UIScreen.main.bounds.width/1.25,height:5)
    }
    var body: some View{
        
        //        NavigationView {
        ScrollView(.vertical, showsIndicators: false){
            VStack{
                Group {
                    AnimatedWaves()
                    Text("\(self.Title).")
                        .underline(true,color:Color.mainColor)
                        .font(.custom("Avenir Next", size: 40))
                        .fontWeight(.light)
                }
                
                Spacer()
                HStack{
                    Rectangle()
                        .fill(Color(UIColor.flatOrange()).opacity(0.15))
                        .frame(width:UIScreen.main.bounds.width,height: 250)
                        .background(Color.white)
                        .overlay(
                            HStack{
                                VStack{
                                    Text("Hello Krish!").font(.custom("Avenir Next", size: 25))
                                        .fontWeight(.light)
                                        .padding(.bottom, 10)
                                        .foregroundColor(Color.black)
                                    Text("Check out our new Recipes!").font(.custom("Avenir Next", size: 15))
                                        .fontWeight(.medium).fixedSize(horizontal: false, vertical: true)
                                        .padding(.bottom,20)
                                        .foregroundColor(Color.black)
                                }
                                Image(uiImage: UIImage(named:"intro")!)
                                    .resizable()
                                    .renderingMode(.original)
                                    .frame(width : 175, height: 175)
                                    .padding(.leading,50)
                                    .padding(.top)
                            }.padding(.leading)
                            
                    ).clipShape(Corners(corner: [.topRight,.bottomRight], size: CGSize(width:45,height:70))).padding(.trailing)
                }.animation(.easeIn)
                    .padding(.bottom,-8)
                
                ZStack{
                    Color(UIColor.flatOrange()).opacity(0.16).background(Color.white)
                    VStack{
                        Spacer(minLength: 25)
                        DifferentDiet()
                        self.divider
                        
                        MultipleMenu().padding(.leading, 5)
                        self.divider
                        Group{
                            FoodRow(type: "food", title: "Pasta",q:"pasta",imageStr: "pasta").padding(.leading, 5)
                            self.divider
                            FoodRow(type: "food", title: "Burger",q:"burger",imageStr: "hamburguer").padding(.leading, 5)
                            self.divider
                            FoodRow(type: "food", title: "Burrito",q:"burrito",imageStr: "wrap").padding(.leading, 5)
                            self.divider
                        }
                        
                        Spacer()
                    }.background(self.color).clipShape(Corners(corner: [.topLeft], size: CGSize(width:65,height:75))).animation(.spring())
                }
            }.background(self.color)
        }
    }
    //    }
}

struct SearchView:View{
    var color:Color = .white
    var Title:String = "Search";
    var body: some View{
        ScrollView(.vertical, showsIndicators:false) {
            VStack {
                AnimatedWaves()
                Text(self.Title)
                    .font(.custom("Avenir Next", size: 40))
                    .fontWeight(.light)
                SearchDetailView()
            }.background(self.color)
        }
    }
}

struct IngredientListView: View{
    var color:Color = .white
    var Title:String = "Ingredients";
    var body: some View{
        ScrollView(.vertical, showsIndicators: false){
            VStack {
                AnimatedWaves()
                Text(self.Title)
                    .font(.custom("Avenir Next", size: 40))
                    .fontWeight(.light)
                    .padding(.bottom)
                IngredientShoppingList()
                Spacer()
            }
        }.background(self.color)
    }
}

struct FavListView:View{
    var color:Color = .white
    var Title:String = "Favorite";
    var body: some View{
        ScrollView(.vertical, showsIndicators: false){
            VStack {
                AnimatedWaves()
                Text(self.Title)
                    .font(.custom("Avenir Next", size: 40))
                    .fontWeight(.light)
                FavoritePanel()
            }
        }.background(self.color).animation(.spring())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

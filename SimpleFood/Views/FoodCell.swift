//
//  FoodCell.swift
//  SimpleFood
//
//  Created by Krishna Venkatramani on 6/13/20.
//  Copyright © 2020 Team Krish. All rights reserved.
//

import SwiftUI

struct FoodCell: View {
    @ObservedObject var imageManager = DownloadImage();
    @State var showDetail : Bool = false;
    var width:CGFloat;
    var height:CGFloat;
    var type:String;
    init(food :EdamamRecipe,width:CGFloat=200,height:CGFloat=200,type:String="normal") {
        self.food = food;
        self.width = width;
        self.height = height;
        self.type = type;
        self.loadImage();
    }
    var food:EdamamRecipe;
    var body: some View {
        //        NavigationLink(destination: FoodDetailView(food: self.food)){
        NavigationLink(destination: CircleView(food: self.food)){
            if self.type == "normal"{
                ZStack{
                    Image(uiImage: self.imageManager.image)
                        .renderingMode(.original)
                        .frame(width: self.width, height: self.height)
                        .cornerRadius(20)
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: self.width, height: self.height)
                        .opacity(0.5)
                        .foregroundColor(.black)
                        .overlay(VStack(alignment: .leading,spacing: 5){
                            Spacer()
                            Text(self.food.label?.capitalized ?? "No Title")
                                .font(.headline)
                                .fixedSize(horizontal: false, vertical: true)
                                .frame(minWidth: 150, idealWidth: 175, maxWidth: 200, alignment: .leading)
                                .foregroundColor(.white)
                            Text(self.food.source?.capitalized ?? "No Publisher")
                                .font(.subheadline)
                                .foregroundColor(.white)
                                .padding(.bottom)
                        }.padding(.leading,10))
                    
                }.padding(.trailing, 15)
                
            }else{
                ZStack(alignment: .bottom){
                    Image(uiImage: self.imageManager.image)
                        .renderingMode(.original)
                        .frame(width: self.width, height: self.height)
                        .cornerRadius(20)
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width:self.width).frame(idealHeight: self.height/4, maxHeight: self.height/2)
                        .fixedSize(horizontal: true, vertical: false)
                        .foregroundColor(.white)
                        .overlay(VStack(alignment: .leading,spacing: 5){
                            Spacer()
                            Text(self.food.label?.capitalized ?? "No Title")
                                .font(.headline)
                                .fixedSize(horizontal: false, vertical: true)
                                .foregroundColor(.black)
                            Text(self.food.source?.capitalized ?? "No Publisher")
                                .font(.subheadline)
                                .foregroundColor(.black)
                                .padding(.bottom)
                        })
                }
            }
        }
        
    }
    
    func loadImage(){
        if let imgUrl = self.food.image{
            self.imageManager.urlString = imgUrl;
            self.imageManager.getImage();
        }
    }
}

struct FoodCell_Previews: PreviewProvider {
    static var previews: some View {
        FoodCell(food: edamamExample!, width: 200, height: 200, type: "featured").previewLayout(.sizeThatFits)
    }
}

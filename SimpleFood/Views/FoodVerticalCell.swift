//
//  FoodVerticalCell.swift
//  SimpleFood
//
//  Created by Krishna Venkatramani on 7/25/20.
//  Copyright © 2020 Team Krish. All rights reserved.
//

import SwiftUI

struct FoodVerticalCell: View {
    var width: CGFloat;
    var height: CGFloat;
    @ObservedObject var imageManager = DownloadImage()
    var food :EdamamRecipe;
    init(_ food:EdamamRecipe, _ width:CGFloat = 200, _ height:CGFloat = 300){
        self.width = width;
        self.height = height;
        self.food = food;
        if let imageURL = self.food.image{
            self.imageManager.urlString = imageURL;
            self.imageManager.getImage();
        }
    }
    var body: some View {
        VStack{
            ZStack(alignment: .bottom){
                Image(uiImage: self.imageManager.image)
                    .resizable()
                    .frame(width: self.width, height: self.height, alignment: .center)
                    .cornerRadius(20)
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.black)
                    .opacity(0.5)
                    .frame(width: self.width, height: self.height)
                VStack{
                    Spacer()
                    Text(self.food.label?.capitalized ?? "No Title")
                        .font(.custom("Avenir Next", size: 20))
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .frame(width:self.width - 50)
                        
                    .fixedSize(horizontal: false, vertical: true)
                        .padding(.bottom)
                }
            }.frame(width: self.width, height: self.height)
        }
        
        
    }
}

struct FoodVerticalCell_Previews: PreviewProvider {
    static var previews: some View {
        FoodVerticalCell(edamamExample!)
    }
}

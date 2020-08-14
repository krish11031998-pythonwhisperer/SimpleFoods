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
    var food :SResult;
    init(_ food:SResult, _ width:CGFloat = 200, _ height:CGFloat = 300){
        self.width = width;
        self.height = height;
        self.food = food;
        if let imageURL = self.food.image{
            self.imageManager.urlString = imageURL;
            self.imageManager.getImage();
        }
    }
    var body: some View {
        NavigationLink(destination : FoodDetailView(food: self.food)){
            VStack{
                ZStack(alignment: .bottom){
                    Image(uiImage: self.imageManager.image)
                        .resizable()
                        .renderingMode(.original)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: self.width, height: self.height, alignment: .center)
                        .cornerRadius(20)
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.black)
                        .opacity(0.5)
                        .frame(width: self.width, height: self.height)
                    HStack(){
                        
                        Text(self.food.title ?? "No Title")
                            .font(.custom("Avenir Next", size: 20))
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                            .frame(width:self.width - 50)
                            
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom)
                            .padding(.leading)
                        Spacer()
                    }
                }.frame(width: self.width, height: self.height)
            }
        }
        
        
    }
}

struct FoodVerticalCell_Previews: PreviewProvider {
    static var previews: some View {
        FoodVerticalCell(SExample)
    }
}

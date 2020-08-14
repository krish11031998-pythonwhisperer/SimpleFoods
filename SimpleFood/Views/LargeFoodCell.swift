//
//  VideoFoodCell.swift
//  SimpleFood
//
//  Created by Krishna Venkatramani on 6/29/20.
//  Copyright © 2020 Team Krish. All rights reserved.
//

import Foundation
import SwiftUI

struct LargeFoodCard:View{
    var widthFrame = UIScreen.main.bounds.width/1.25;
    //    var food:EdamamRecipe?
    //    @State var food:RealmRecipe? = RealmRecipe.getExample(){
    //        didSet{
    //            if let uri = self.food?.uri, let title = self.food?.title{
    //                print("Change the recipe to :\(title)");
    //                self.foodManager.getRecipe(uri);
    //            }
    //        }
    //    }
    //    @Binding var changeActive:Bool;
    var recipe:SResult;
    @ObservedObject var imageManager = DownloadImage();
    //    var onClick: (_ recipe:RealmRecipe) -> Void
    var cardImage:UIImage{
        get{
            self.imageManager.urlString = self.recipe.image;
            self.imageManager.getImage();
            return self.imageManager.image
        }
    }
    var cardTitle:String{
        get{
            return self.recipe.title?.capitalized ?? ""
        }
    }
    
    var publisher:String{
        get{
            return ""
        }
    }
    
    
    var body : some View{
        //
        //        Button(action:{
        //            self.onClick(self.recipe)
        //        }){
        ZStack(alignment: .bottom){
            Image(uiImage:self.cardImage)
                .resizable()
                .renderingMode(.original)
                .frame(width:width,height: UIScreen.main.bounds.height/4.5)
                .aspectRatio(contentMode: .fit)
            Rectangle()
                .frame(width:width,height: UIScreen.main.bounds.height/4.5)
                .foregroundColor(.black)
                .opacity(0.5).overlay(
                    VStack{
                        Spacer()
                        Text(self.cardTitle)
                            .font(.headline)
                            .foregroundColor(.white)
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(width:width,height: 35,alignment:.leading)
                            .padding(.leading)
                            .padding(.bottom)
                        Text(self.publisher)
                            .font(.subheadline)
                            .foregroundColor(.white)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom)
                            .padding(.leading)
                            .frame(width:width,height: 35,alignment:.leading)
                    }
            )
            
        }.cornerRadius(20)
    }
    
    //
    //    }
    
}

//struct VideoPlayerCardPreview:PreviewProvider{
//    static var previews: some View {
//        LargeFoodCard()
//    }
//}

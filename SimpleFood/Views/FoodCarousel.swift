//
//  FoodCarousel.swift
//  SimpleFood
//
//  Created by Krishna Venkatramani on 6/22/20.
//  Copyright © 2020 Team Krish. All rights reserved.
//

import SwiftUI

struct FoodCarousel: View {
    var foods:[TastyFood]
    @State var page  = 0;
    
    var body: some View {
        
        
//        GeometryReader{g in
            
//            List(foods: self.foods);
            Carousel(width: UIScreen.main.bounds.size.width, height: 450, data: self.foods, page: self.$page)
//        }
        
    }
}

struct List : View{
    var foods:[TastyFood]
    var body: some View{
        
        HStack{
            ForEach(self.foods){(food) in
                Card(food: food, width: UIScreen.main.bounds.size.width);
                
            }
        }
    }
}

struct Card:View{
    
    var food : TastyFood
    var width : CGFloat
    @ObservedObject var imageManager = DownloadImage()
    
    init(food:TastyFood,width:CGFloat){
        self.food = food;
        self.width = width;
        if let safeURL = self.food.thumbnail_url{
            self.imageManager.urlString = safeURL;
            self.imageManager.getImage();
        }
    }
    
    
    var body: some View {
        VStack(alignment:.center){
            VStack(alignment: .center, spacing: 10){
                Text(self.food.name ?? "")
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding(.top)
                    .padding(.horizontal)
                    .fixedSize(horizontal: false, vertical: true)
                Spacer().frame(height:25)
                Image(uiImage: self.imageManager.image)
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: self.width - 100, height: 250)
                    .cornerRadius(20)
                    .padding(.all)
                Spacer().frame(height:25)
            }.background(Color.white)
                .cornerRadius(20)
                .padding(.horizontal,20)
                .padding(.vertical,25)
        }.frame(width:self.width)
       
            
        
    }
}

struct Carousel : UIViewRepresentable{
    var width : CGFloat;
    var height: CGFloat;
    var data:[TastyFood] = [];
    @Binding var page : Int;
    
    func makeUIView(context: Context) -> UIScrollView {
        print(data.count);
        let total = self.width * CGFloat(data.count);
        let view = UIScrollView()
        view.isPagingEnabled = true;
        view.contentSize = CGSize(width: total, height: 1.0);
        view.bounces = true;
        view.showsVerticalScrollIndicator = false;
        view.showsHorizontalScrollIndicator = false;
        
        let viewList = UIHostingController(rootView: List(foods: self.data))
        viewList.view.frame = CGRect(x: 0, y: 0, width: total, height: self.height);
        
        viewList.view.backgroundColor = .clear;
        view.addSubview(viewList.view)
        
        return view
        
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
//        print("hello");
    }
    
    
  
}

struct FoodCarousel_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color(.yellow).edgesIgnoringSafeArea(.all)
            FoodCarousel(foods: exampleList)
        }
        
    }
}

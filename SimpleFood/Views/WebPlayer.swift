//
//  WebView.swift
//  SimpleFood
//
//  Created by Krishna Venkatramani on 7/10/20.
//  Copyright © 2020 Team Krish. All rights reserved.
//

import Foundation
import SwiftUI
import WebKit

struct WebPlayerView:View{
    var urlString : String?;
    var width = UIScreen.main.bounds.width/1.15
    var body: some View{
        ZStack(alignment: .center) {
            
            WebView(urlString:self.urlString)
                .frame(width:width, height:300)
                .cornerRadius(20)
            RoundedRectangle(cornerRadius: 20)
                .frame(width: width, height: 300)
                .opacity(0.5)
            RoundedRectangle(cornerRadius:20)
                .frame(width:width-100,height: 75)
                .padding(.horizontal)
//                .background(Color.blue)
                .foregroundColor(.blue)
                .opacity(0.75)
                .overlay(Text("Visit Website")
                    .font(.headline))
        }
        
        
    }
}


struct WebView:UIViewRepresentable{
    var urlString:String?;
    func makeUIView(context: Context) -> WebView.UIViewType {
        return WKWebView();
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let urlS = (self.urlString != nil) ? self.urlString as! String : "https://www.google.com";
        if let url = URL(string:urlS){
            let request = URLRequest(url: url)
            uiView.load(request);
            
        }
    }
    
}

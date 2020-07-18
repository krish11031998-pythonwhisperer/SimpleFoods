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

struct WebView:View{
    var urlString : String?;
    
    var body: some View{
        ZStack(alignment: .center) {
            RoundedRectangle(cornerRadius: 20)
            .frame(width: 300, height: 300)
            WebPlayer(urlString:self.urlString)
        }
        
        
    }
}


struct WebPlayer:UIViewRepresentable{
    var urlString:String?;
    func makeUIView(context: Context) -> WebPlayer.UIViewType {
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

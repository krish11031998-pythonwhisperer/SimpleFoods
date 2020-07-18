//
//  AuthorCard.swift
//  SimpleFood
//
//  Created by Krishna Venkatramani on 6/15/20.
//  Copyright © 2020 Team Krish. All rights reserved.
//

import SwiftUI

struct AuthorCard: View {
    var publisher:String;
    var publisher_url:String;
    var body: some View {
        RoundedRectangle(cornerRadius: 10.0)
            .frame(width: 200, height: 50)
            .foregroundColor(.gray)
            .overlay(
                VStack(alignment: .center, spacing: 10){
                    
                    Button(action: {
                        print("Clicked the button")
                    }) {
                        Text("by")
                            .font(.subheadline)
                        Text(self.publisher)
                            .font(.custom("Zapfino", size: 15))
                        .fontWeight(.medium)
                            .foregroundColor(.black)
                        
                    }
                    
            })
    }
}

struct AuthorCard_Previews: PreviewProvider {
    static var previews: some View {
        AuthorCard(publisher: "The Pioneer Woman",publisher_url: "http://thepioneerwoman.com")
    }
}

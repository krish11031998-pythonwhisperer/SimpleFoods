//
//  imageHelper.swift
//  SimpleFood
//
//  Created by Krishna Venkatramani on 6/13/20.
//  Copyright © 2020 Team Krish. All rights reserved.
//

import Foundation
import SwiftUI

var imageCache:[String:UIImage] = [:];

class DownloadImage:ObservableObject{
    var urlString:String?;
    @Published var image:UIImage = UIImage(named: "icedlatte")!;
    func getImage(){
        guard var urlStr = self.urlString , urlStr != ""  else {return}
        urlStr = self.formatURLString(urlS: urlStr);
        if imageCache.keys.contains(urlStr) , let img = imageCache[urlStr]{
            DispatchQueue.main.async {
                self.image = img;
            }
        }
        else{
            guard let url = URL(string: urlStr) else {return}
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let safeData = data, let img = UIImage(data: safeData){
                    DispatchQueue.main.async {
                        self.image = img;
                        imageCache[urlStr] = img;
                    }
                }else{
                    print("There was an error! \(error)");
                }
            }.resume()
        }
    }
    
    func formatURLString(urlS:String) -> String{
        let splituS = urlS.components(separatedBy: ":");
        return "https:"+splituS[1]
    }
}

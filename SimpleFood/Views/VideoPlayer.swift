//
//  VideoPlayer.swift
//  SimpleFood
//
//  Created by Krishna Venkatramani on 6/20/20.
//  Copyright © 2020 Team Krish. All rights reserved.
//

import SwiftUI
import AVKit
import AVFoundation
import ChameleonFramework

extension AVAsset {

    func generateThumbnail(completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global().async {
            let imageGenerator = AVAssetImageGenerator(asset: self)
            let time = CMTime(seconds: 0.0, preferredTimescale: 600)
            let times = [NSValue(time: time)]
            imageGenerator.generateCGImagesAsynchronously(forTimes: times, completionHandler: { _, image, _, _, _ in
                if let image = image {
                    completion(UIImage(cgImage: image))
                } else {
                    completion(nil)
                }
            })
        }
    }
}


struct Player : UIViewControllerRepresentable{
    var urlString:String;
    var thumbnailPic:UIImage?;
    init(urlString:String=""){
        self.urlString = urlString;
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<Player>) -> AVPlayerViewController {
        let controller = AVPlayerViewController();
        if let url = URL(string: self.urlString){
            let player = AVPlayer(url: url);
            player.isMuted = false;
            player.play();
            controller.player = player;
            
        }
        return controller;
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: UIViewControllerRepresentableContext<Player>) {
    }
    
//    func thumbnailPicture(){
//        guard let url = URL(string:self.urlString) else {return}
//        let asset = AVAsset(url:url)
//        let assetImgGenerate = AVAssetImageGenerator(asset: asset)
//        assetImgGenerate.appliesPreferredTrackTransform = true
//        let time = CMTimeMakeWithSeconds(Float64(1), 100)
//        do {
//            let img = try assetImgGenerate.copyCGImage(at: time, actualTime: nil)
//            let thumbnail = UIImage(cgImage: img)
//            return thumbnail
//        } catch {
//            print("there was a problem")
//        }
//
//    }
}

struct VideoPlayer: View {
    var urlString:String="";
    var title:String="";
    var color:UIColor = FlatMint()
    var width:CGFloat = UIScreen.main.bounds.size.width/1.25;
    init(urlString:String="",title:String=""){
        self.urlString = urlString;
        self.title = title;
    }
    
    var body: some View {
        VStack{
            if self.urlString != ""{
                VStack(alignment: .leading, spacing: 5){
                    Player(urlString: self.urlString).padding(.all).cornerRadius(10.0).aspectRatio(.init(16/9), contentMode: .fit)
                }
                
            }else{
                Text("No Video available! 😕")
                    .font(.headline)
                    .foregroundColor(Color(ContrastColorOf(self.color, returnFlat: true)))
                    .padding(.all);
            }
           
        }.frame(width: self.width, height: CGFloat(16/9)*self.width)
            .aspectRatio(.init(16/9), contentMode: .fit)
//            .background(Color(self.color))
//            .cornerRadius(10)
//            .padding(.all,10.0)
    }
}

struct VideoPlayer_Previews: PreviewProvider {
    static var previews: some View {
        VideoPlayer()
    }
}

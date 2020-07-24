//
//  PieChart.swift
//  SimpleFood
//
//  Created by Krishna Venkatramani on 6/24/20.
//  Copyright © 2020 Team Krish. All rights reserved.
//

struct Nutrients{
    var value: Float;
    var color : Color;
}


import SwiftUI

struct PieChart: View {
    var values : [Nutrients] = []
    var legend:[String:Color] = ["protein":Color.green,"protein":Color.green,"protein":Color.green,"protein":Color.green,"protein":Color.green,"protein":Color.green]
    
    var body: some View {
        VStack(alignment: .center){
            Titles(title: "Nutrients Breakdown",imageStr: "pan")
            HStack{
                Chart(values: self.values).padding(.top).frame(width:250,height:250)
                VStack(alignment: .leading){
                    ForEach(Array(self.legend.keys).sorted(), id: \.self){(key) in
                        HStack{
                            Circle()
                                .fill(self.legend[key] ?? Color.black)
                                .frame(width:10,height: 10)
                                
                            Text(key.capitalized)
                                .font(.subheadline)
                        }
                    }
                    
                }.padding(.horizontal)
            }
            
        }.padding(.all,25.0)
    }
}


struct Chart : View{
     @Environment(\.colorScheme) var colorScheme
    var values:[Nutrients]
    var body : some View{
        VStack{
            GeometryReader{g in
                ZStack{
                    ZStack{
                        
                        ForEach(0..<self.values.count, id: \.self){i in
                            
                            Arc(data: self.values, index: i, center: CGPoint(x: g.frame(in: .local).width/2, y: g.frame(in: .local).height/2))
                        }
                        
                    }.padding(.leading,10).padding(.top,10)
                    Circle()
                    .fill(self.colorScheme == .dark ? Color.black : Color.white)
                    .shadow(radius: 2, x: 1, y: 1)
                    .frame(width:85,height:85)
                }
                
                
            }
        }
        
    }
}

struct Arc : View{
    var data:[Nutrients];
    var index:Int;
    var center:CGPoint;
    
    var body : some View{
        
        Path{path in
            
            path.move(to: self.center)
            path.addArc(center: self.center, radius: 90, startAngle: .init(degrees :self.findAngle(type: "from")), endAngle: .init(degrees :self.findAngle(type: "to")), clockwise: false)
        }.fill(self.data[index].color)
    }
    
    func findAngle(type:String) -> Double{
        var currentTotal = 0;
        var total = self.data.map({ Int($0.value) }).reduce(0,{$0+$1})
        var degrees:Double = 0;
        if type == "from"{
            if index == 0{
                degrees = 0;
            }
            else{
                for i in 0..<index{
                    currentTotal += Int(self.data[i].value);
                }
                degrees = (Double(currentTotal)*360/Double(total));
            }

           
        }else if type == "to" {
            if index == 0{
                currentTotal = Int(self.data[0].value);
            }else{
                for i in 0...index{
                    currentTotal += Int(self.data[i].value);
                }
            }
            
            degrees = (Double(currentTotal)*360/Double(total));
        }
        print("index \(index) : type \(type) and degrees : \(degrees) total: \(total)")
        return degrees
    }
}


struct PieChart_Previews: PreviewProvider {
    static var previews: some View {
        PieChart(values:  [Nutrients(value: 34, color: .red),Nutrients(value: 56, color: .blue),Nutrients(value: 90, color: .yellow),Nutrients(value: 124, color: .black),Nutrients(value: 5, color: .orange)])
    }
}

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
    var values : [Nutrients] = [];
    var body: some View {
        VStack(alignment: .center){
            Text("Nutrients Breakdown")
                .font(.headline)
                .padding(.bottom,50)
//                .offset(x:0,y:-50)
            Chart(values: self.values).padding(.top)
        }.frame(width:200,height: 200)
            .padding(.all,25.0)
    }
}


struct Chart : View{
    var values:[Nutrients]
    var body : some View{
        GeometryReader{g in
            
            ZStack{
                
                ForEach(0..<self.values.count, id: \.self){i in
                    
                    Arc(data: self.values, index: i, center: CGPoint(x: g.frame(in: .local).width/2, y: g.frame(in: .local).height/2))
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
            path.addArc(center: self.center, radius: 100, startAngle: .init(degrees :self.findAngle(type: "from")), endAngle: .init(degrees :self.findAngle(type: "to")), clockwise: false)
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

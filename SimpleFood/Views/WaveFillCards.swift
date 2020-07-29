import SwiftUI
import ChameleonFramework
struct WaveFillCards: View {
    @Environment(\.colorScheme) var colorScheme
    var key:String;
    var value:Int;
    @State var animate:Bool = false;
    var colorMain:UIColor = UIColor.flatWatermelon()
    var colorSecondary:UIColor = UIColor.flatWatermelonDark()
    var unit:String;
    var max:Int = 100;
    var width:CGFloat{
        get{
            return UIScreen.main.bounds.size.width/2.25
        }
    }
    var percent:CGFloat{
        get{
            var value = CGFloat(self.value)/CGFloat(self.max) * 145.0
            return  value <= 145.0 ? value : 145.0
        }
    }
    
    var cardColor: LinearGradient{
        get{
            return LinearGradient(gradient: Gradient(colors:[Color(colorMain), Color(colorSecondary)]), startPoint: .top, endPoint: .bottom)
        }
    }
    var body: some View {
        ZStack(alignment: .bottom){
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray)
                .opacity(0.35)
                .frame(width:self.width, height: 220)
                .shadow(radius: 0.5, x: 2.5, y: 2.5)
            VStack{
                Text("\(key)").font(.custom("Avenir Next", size:20.0)).foregroundColor(Color(colorMain)).padding(.top)
                
                Divider().frame(width:UIScreen.main.bounds.size.width/3,height:5)
                VStack{
                    Spacer()
                    ZStack(alignment: .bottom){
                        Wave(yOffset: self.animate ? 0.2 :  -0.2)
                            .frame(width:UIScreen.main.bounds.size.width/2.25, height: self.percent)
                        .opacity(0.8)
                            .foregroundColor(Color(self.colorMain))
                        .animation(Animation.easeOut(duration: 2.5).repeatForever(autoreverses: true))
                        .clipShape(Corners(corner:[.bottomRight,.bottomLeft,.topRight,.topLeft], size:CGSize(width:10,height:10)))
                        .rotationEffect(.init(degrees: 180))
                        HStack{
                            Text("\(value) \(unit)").font(.custom("Avenir Next", size: 25)).foregroundColor(Color.white)
                        }.padding(.bottom).frame(width:self.width)
                    }
                }.frame(width:self.width, height: 150).padding(.bottom)
                
            }.frame(width:self.width, height: 200)
                
            .onAppear {
                self.animate.toggle()
            }
            
        }
    }
}
struct WaveFillCards_Previews: PreviewProvider {
    static var previews: some View {
        WaveFillCards(key: "Calories", value: 200, unit: "kcal")
    }
}

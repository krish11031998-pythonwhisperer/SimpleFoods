//
//  IngredientRow.swift
//  SimpleFood
//
//  Created by Krishna Venkatramani on 6/14/20.
//  Copyright © 2020 Team Krish. All rights reserved.
//

import SwiftUI
import ChameleonFramework
var cellWidth = UIScreen.main.bounds.size.width/1.25 - 10
struct IngredientRow: View {
    @Environment(\.colorScheme) var colorScheme
    @State var chosenCell: Int = -1
    var icon:String{
        get{
            return self.type == "ingredients" ? "salad" : "pot-2"
        }
    }
    
    var texticon:String{
        get{
            return self.type == "ingredients" ? "checkmark.circle" : "stopwatch.fill"
        }
    }
    
    var typeIcon:String{
        get{
            return self.type == "ingredients" ? "plus" : self.type == "instructions" ? "play" : "checkmark.fill"
        }
    }
    var shoppingList = ShoppingList()
    var titleIcon = "list.dash"
    var recipe:[SIngredient] = []
    var steps:[SStep] = []
    var color:UIColor = FlatYellow()
    var type:String = "ingredients"
    var title:String = ""
    init(recipe:[SIngredient]=[],steps:[SStep]=[],color:UIColor=FlatYellow(),type:String="ingredients",title:String?=nil){
        self.recipe = recipe
        self.steps = steps
        self.color = color
        self.type = type
        if let safeTitle = title{
            self.title = safeTitle
        }
    }
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 10){
            VStack(alignment:.leading){
                if title != "" {
                    HStack(alignment: .firstTextBaseline, spacing: 10){
                        
                        Image(uiImage: UIImage(systemName: self.titleIcon)!)
                            .frame(width: 15, height: 15).padding(.trailing,10)
                        Text(title)
                            .font(.custom("Avenir Next", size: 25.0))
                            
                            .fontWeight(.semibold)
                            .fixedSize(horizontal: false, vertical: true)
                        
                    }
                    
                }
                HStack(alignment: .center,spacing:7.5){
                    Titles(title: self.type.capitalized ,imageStr: self.icon)
                    //                    Spacer()
                    if type == "ingredients"{
                        Button(action: {
                            self.recipe.forEach { (component) in
                                self.addComponent(component: component)
                            }
                        }) {
                            Circle()
                                .frame(width: 25, height: 25)
                                .foregroundColor(.gray)
                                .opacity(0.5)
                                .overlay(Image(systemName: self.typeIcon))
                                .padding(.trailing,10)
                        }
                        
                    }
                }
            }
            VStack(alignment: .leading, spacing: 7.5){
                if type == "ingredients"{
                    TextBox(color: self.color, icon: self.typeIcon, type: self.type, cell: self.$chosenCell, values: self.recipe) { (value) in
                        if let safeValue = value as? SIngredient{
                            self.addComponent(component: safeValue)
                        }
                    }
                    
                }
                else if type == "instructions"{
                    TextBox(color: self.color, icon: self.typeIcon, type: self.type, cell: self.$chosenCell, values: self.steps) { (value) in
                        if let safeValue = value as? SStep{
                            print("Step : \(safeValue.step ?? "") was clicked")
                        }
                    }
                }
                
            }.padding(.top)
        }
        .frame(width: UIScreen.main.bounds.size.width/1.25)
        .padding(.all, 15.0)
    }
    
    func addComponent(component:SIngredient?){
        if let safeIngredient = component{
            var newObj = RealmIngredient()
            newObj.name = safeIngredient.localizedName ?? safeIngredient.name ??  ""
            newObj.quantity = String(safeIngredient.amount ?? 0.0)
            newObj.unit = safeIngredient.unit ?? "g"
            
            self.shoppingList.saveData(newData: newObj)
        }
    }
}

struct TextBox: View{
    var color: UIColor = .white
    var icon:String
    var type:String
    @State var fillAmount:CGFloat = 1.0
    @Binding var cell:Int
    @State var selectedColor : Color = Color.mainColor
    @State var time:Int = 0
    @State var showTimer:Bool = false
    @State var showDetails:Bool = false
    var values:[Any] = []
    var onClick: (_ value:Any) -> Void
    
    func getText(_ count:Int, _ key:String) -> String{
        var text:String = ""
        if self.type == "ingredients"{
            if let ingredient = self.values[count] as? SIngredient{
                if key == "mainText"{
                    text = ingredient.localizedName ?? ingredient.name ?? ""
                }
                else if key == "sideText"{
                    text = "\(Int(ingredient.amount ?? 0.0)) \(ingredient.unit ?? "g")"
                }
            }
        }
        else if self.type == "instructions"{
            if let instruction = self.values[count] as? SStep{
                if key == "mainText"{
                    text = instruction.step ?? ""
                }
            }
        }
        return text.capitalized
    }
    
    func timerSeleceted(_ i:Int) -> Bool{
        return self.cell == i && self.showTimer && self.type == "instructions"
    }
    
    func detailsSelected(_ i:Int) -> Bool{
        return self.cell == i && self.showDetails && self.type == "instructions"
    }
    
    func BGColor(_ count:Int) -> Color{
        return self.cell == count ?  Color.mainColor : Color(self.color)
    }
    
    func fireTimer(_ count:Int){
        
        if let step = self.values[count] as? SStep{
            var timeNumber:Int = 10
            if let t = step.length?.number{
                if let unit = step.length?.unit{
                    switch(unit){
                    case "minutes":
                        timeNumber = t*60
                        break
                    case "hour":
                        timeNumber = t*3600
                        break
                    default:
                        timeNumber = t
                    }
                }else{
                    timeNumber = t
                }
            }
            self.time = timeNumber;
            print("Timer fired!")
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                self.time-=1
                self.fillAmount = 1 - CGFloat(self.time)/CGFloat(timeNumber)
                print(self.time)
                if self.time == 0 {
                    self.fillAmount = 1.0
                    timer.invalidate()
                }
            }
        }
        
        
    }
    
    func firePreTimer(_ i:Int){
        self.time = 3
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (timer) in
            self.time-=1
            if self.time == 0{
                self.selectedColor = Color.mainColor
                timer.invalidate()
                self.fireTimer(i)
            }
        }
    }
    
    func getIngredientforStep(_ i:Int) -> [SIngredient]{
        if let values = self.values as? [SStep], let ingredients = values[i].ingredients{
            return ingredients
        }
        return []
    }
    
    func changeCell(_ i:Int){
        if self.cell != i{
            self.showDetails = false
            self.showTimer = false
            self.cell = i
        }
    }
    
    func getTime(_ time:Int) -> String{
        var result:String = ""
        if time < 60{
            result = "\(time)"
        }else if time < 3600{
            result = "\(time/60) mins \(time%60)"
        }else if time > 3600{
            var hr:Int = time/3600
            var min:Int = (time%3600)/60
            var sec:Int = (time%3600)%60
            result = "\(hr) hr \(min) min \(sec)"
        }
        return result
    }
    
    func textboxContent(_ i:Int) -> some View{
        var tb = VStack{
            HStack(alignment: .center, spacing: 10){
                Image(systemName: self.icon)
                    .resizable()
                    .frame(width: 15, height: 15, alignment: .center)
                    .foregroundColor(Color.mainColor)
                    .padding(.trailing,10)
                    .onTapGesture {
                        self.clickAction(i)
                }
                HStack{
                    Text(self.getText(i, "mainText"))
                        .fixedSize(horizontal: false, vertical: true)
                        .font(.system(size: 15, weight: .light, design: .serif))
                        .foregroundColor(Color(ContrastColorOf(self.color, returnFlat: true)))
                    Spacer()
                    Text(self.getText(i,"sideText"))
                        .font(.system(size: 12.5, weight: .light, design: .serif))
                        .foregroundColor(Color(ContrastColorOf(self.color, returnFlat: true)))
                }.onTapGesture {
                    self.changeCell(i)
                    self.showTimer = false
                    self.showDetails.toggle()
                    self.selectedColor = .white
                }
            }
            Spacer().frame(height:self.timerSeleceted(i) ? 10 : 0).animation(.easeIn)
            HStack{
                Text(self.getTime(self.time)).font(.custom("Avenir Next",size:25)).fontWeight(.medium).animation(.easeIn)
            }.opacity(self.timerSeleceted(i) ? 1 : 0).frame(width:self.timerSeleceted(i) ? cellWidth : 0, height:self.timerSeleceted(i) ? 60 : 0).animation(.easeIn)
            
            if self.detailsSelected(i){
                InstructionDetailCard(ingredients: self.getIngredientforStep(i))
                    //                        .frame(height: self.detailsSelected(i) ? )
                    .animation(.easeInOut(duration: 0.5))
                    .padding(.top)
            }
        }
        return tb
    }
    
    func clickAction(_ i:Int){
        if self.type == "ingredients"{
            self.onClick(self.values[i])
        }else if self.type == "instructions"{
            self.changeCell(i)
            self.showTimer.toggle()
            self.showDetails = false
            self.selectedColor = Color(UIColor.flatLime())
            self.firePreTimer(i)
        }
    }
    
    var body: some View{
        ForEach(0..<self.values.count){(i) in
            ZStack(alignment: .leading){
                RoundedRectangle(cornerRadius: 20)
                    .frame(minWidth: cellWidth, idealWidth: cellWidth, maxWidth: cellWidth)
                    .foregroundColor(Color(self.color))
                    .shadow(color: Color(self.color == UIColor.white ? UIColor.black : UIColor.white).opacity(0.5),radius: 2, x: 2, y: 2)
                RoundedRectangle(cornerRadius: 20)
                    .frame(width:self.fillAmount * cellWidth)
                    .foregroundColor(self.selectedColor)
                    .opacity(self.cell == i ? 1 : 0)
                    .animation(.easeIn)
                ZStack{
                    //                        Button(action: {
                    //                            self.clickAction(i)
                    //                        }){
                    self.textboxContent(i).padding(.all)
                }
                
            } 
        }
        
    }
}

struct IngredientRow_Previews: PreviewProvider {
    static var previews: some View {
        IngredientRow(recipe: [], steps: SExample.analyzedInstructions?[0].steps ?? [], color: .white, type: "instructions", title: "Instructions")
        //                IngredientRow(recipe: SExample.nutrition?.ingredients ?? [], steps: [], color: .white, type: "ingredients", title: "Ingredients")
    }
}

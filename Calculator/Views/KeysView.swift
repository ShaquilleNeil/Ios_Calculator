//
//  KeysView.swift
//  Calculator
//
//  Created by Shaquille O Neil on 2025-09-18.
//

import SwiftUI

struct KeysView: View {
    
    @State var displayValue = "0"
    @State var currentOperation: Operation = .none
    @State var runningNumber: Double = 0.0
    @State private var changeColor = false
    
    
    let buttons: [[keys]] = [
    [.clear, .negative, .percent, .divide],
    [.seven, .eight, .nine, .multiply],
    [.four, .five, .six, .minus],
    [.one, .two, .three, .add],
    [.zero, .decimal, .equal],
    ]
    
    
    
    var body: some View {
        VStack{
            Spacer() // push all elements to the bottom
            
            HStack{
                //rounded rectangle with animation
                RoundedRectangle(cornerRadius: 15)
                    .foregroundStyle(changeColor ? Color.num : Color.green.opacity(0.2))
                    .scaleEffect(changeColor ? 1.5 : 1.0)
                    .frame(width: 350, height: 280)
                    .animation(Animation.easeInOut.speed(0.17), value: changeColor)
                    .onAppear {
                        self.changeColor.toggle()
                    }.overlay{
                        Text(displayValue)
                            .font(.system(size: 100))
                            .foregroundStyle(.black)
                    }
            }.padding()//end of hstack
            
            //foreach loop
            ForEach(buttons, id: \.self){
                row in // getting the rows
                HStack(spacing: 12){
                    ForEach(row,id: \.self){
                        element in //.clear, . negative etc
                        Button{
                            print(element.rawValue)
                            didTap(button: element)
                        }label: {
                            Text(element.rawValue)
                                .font(.system(size: 30))
                                .foregroundStyle(.black)
                                .frame(width: self.getWidth(element: element), height: self.getHeight(element: element))
                                .background(element.buttonColor)
                                .clipShape(RoundedRectangle(cornerRadius: self.getWidth(element: element)/2))
                                .shadow(color: .purple.opacity(0.5), radius: 30)
                            
                        }
                    }
                }.padding(.bottom, 4)
            }
        }
    }
    
    //functions
    
    //button click
    func didTap(button: keys){
        switch button{
        case .add, .minus, .multiply, .divide, .equal:
            if button == .add {
                self.currentOperation = .add
                //need a running number, a number that keeps adding into itself
                self.runningNumber = Double(self.displayValue) ?? 0
            }else if button == .minus {
                self.currentOperation = .minus
                self.runningNumber = Double(self.displayValue) ?? 0
            }else if button == .multiply {
                self.currentOperation = .multiply
                
                self.runningNumber = Double(self.displayValue) ?? 0
            }else if button == .divide {
                self.currentOperation = .divide
                self.runningNumber = Double(self.displayValue) ?? 0
            }else if button == .equal {
                let runningValue = self.runningNumber
                let currentvALUE = Double(self.displayValue) ?? 0
                var result: Double = 0
                
                switch self.currentOperation {
                case .add:
                    result = runningValue + currentvALUE
                case .minus:
                    result = runningValue - currentvALUE
                case .multiply:
                    result = runningValue * currentvALUE
                case .divide:
                    //division by 0
                    if currentvALUE == 0 {
                        self.displayValue = "Undefined"
                        return
                    }
                    result = runningValue / currentvALUE
                case .none:
                    break // do nothing
                } //end of internal switch
                
                //Displays decimals when needed
                if result.truncatingRemainder(dividingBy: 1) == 0 {
                       self.displayValue = String(Int(result))
                   } else {
                       self.displayValue = String(result)
                   }
            }//end of if-else
            if button != .equal {
                self.displayValue = "0"
            }
            //end of the first switch
        case .clear:
            self.displayValue = "0" //reset to zero
        case .decimal:
            if !self.displayValue.contains("."){
                self.displayValue += "."
            }
        case .negative:
            if self.displayValue.first != "-"{
                self.displayValue = "-" + self.displayValue
            }else{
                self.displayValue.remove(at: self.displayValue.startIndex)
            }
        case .percent:
            if let number = Double(self.displayValue){
                self.displayValue = "\(number * 0.01)"
            }
        
        default :
            let number = button.rawValue
            if self.displayValue == "0"{
                self.displayValue = number
            }else {
                self.displayValue = "\(self.displayValue)\(number)"
            }
            
        }
    }
    
    
    
    
    //get width
    func getWidth(element: keys) -> CGFloat {
        if element == .zero {
            //spreading out the keys across the gap, 5 gaps between
            
            //for the zero to take up the size of 2 buttons
            return (UIScreen.main.bounds.width - (5*10)) / 2
        }
        return (UIScreen.main.bounds.width - (5*10)) / 4
    }
    
    //get height
    func getHeight(element: keys) -> CGFloat {
        return ((UIScreen.main.bounds.width - (5*10))) / 5
    }
}

#Preview {
    KeysView()
}

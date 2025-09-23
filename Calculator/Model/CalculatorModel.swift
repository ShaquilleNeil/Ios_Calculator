//
//  CalculatorModel.swift
//  Calculator
//
//  Created by Shaquille O Neil on 2025-09-18.
//

import Foundation
import SwiftUI

enum keys: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    
    //operations
    case add = "+"
    case minus = "-"
    case multiply = "*"
    case divide = "/"
    case equal = "="
    
    case clear = "AC"
    case decimal = "."
    case percent = "%"
    case negative = "-/+"
    
    //button color
    var buttonColor: Color{
        switch self {
        case .add, .minus, .multiply, .divide, .equal:
            return Color.vOperator
        case .clear, .decimal, .percent, .negative:
            return Color.hOperator
        default :
            return Color.num
        }
    }
}

enum Operation{
    case add, minus, multiply, divide, none
}// we use this enum to check and do the operation

//
//  CalculaterBrain.swift
//  BMI Calculator
//
//  Created by Muhammed Burkay Şendoğdu on 4.09.2022.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import Foundation
import UIKit

struct CalculaterBrain{
    var bmi: BMI?
    
    mutating func calculateBMIValue(weight: Float, height: Float){
        let bmiValue = Float(weight) / Float(height * height)
        if bmiValue < 18.5{
            bmi = BMI(value: bmiValue, advice: "Eat more pies", color: .blue)
        }else if bmiValue < 24.9{
            bmi = BMI(value: bmiValue, advice: "Fit as a fiddle!", color: .green)
        }else{
            bmi = BMI(value: bmiValue, advice: "Eat less pies", color: .red)
        }
    }
    func getBMIValue() -> String{
        return String(format: "%.1f", bmi?.value ?? "0.0")
    }
    
    func getAdvice() -> String{
        return bmi?.advice ?? "Error!"
    }
    
    func getColor() -> UIColor{
        return bmi?.color ?? UIColor.black
    }
    
}

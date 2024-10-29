//
//  Double.swift
//  WeatherApp
//
//  Created by Jese on 29.10.2024.
//
import Foundation

extension Double {
    func toSignedString() -> String  {
        var valueString = String(self)
        if self > 0 {
            valueString.insert("+", at: valueString.startIndex)
        }
        return valueString
    }
    
    func kelvinToCelsius() -> Double {
        return self - 273.15
    }
    
    func kelvinToFahrenheit() -> Double {
        return (self - 273.15) * 1.8 + 32
    }
    
    func rounded(toPlaces places:Int) -> Double {
           let divisor = pow(10.0, Double(places))
           return (self * divisor).rounded() / divisor
       }

    func covertFromKelvin(isCelsius: Bool) -> Double {
        if(isCelsius) {
            return self.kelvinToCelsius().rounded(toPlaces: 1)
        } else {
            return self.kelvinToFahrenheit().rounded(toPlaces: 1)
        }
    }
}

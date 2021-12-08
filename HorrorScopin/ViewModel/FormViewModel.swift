//
//  FormViewModel.swift
//  HorrorScopin
//
//  Created by Navati Jain on 2021-12-03.
//

import Foundation
import UIKit

enum PickerType {
    case sunSign, days
}

class FormViewModel {
    var sunSignPickerData: [SunSigns] {
        SunSigns.allCases
    }
    
    var daysPickerData: [Days] {
        Days.allCases
    }
    
    func getHoroscoope(for sunSign: SunSigns, day: Days){
        HoroscopeService.getHoroscope(for: sunSign.rawValue, day: day.rawValue) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let horoscoope):
                    print(horoscoope)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
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

enum State {
    case unselected, fail, fetching, success(Horoscope)
}

class FormViewModel {
    var sunSignPickerData: [SunSigns] {
        SunSigns.allCases
    }
    
    var daysPickerData: [Days] {
        Days.allCases
    }
    
    private var state: State = .unselected {
        didSet {
            stateChangeHandler?(state)
        }
    }
    var stateChangeHandler: ((State) -> ())?
  
    func getHoroscoope(for sunSign: SunSigns, day: Days) {
        state = .fetching
        HoroscopeService.getHoroscope(for: sunSign.rawValue, day: day.rawValue) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let horoscoope):
                    print(horoscoope)
                    self.state = .success(horoscoope)
                case .failure(let error):
                    print(error)
                    self.state = .fail
                }
            }
        }
    }
}

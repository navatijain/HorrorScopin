//
//  FormViewModel.swift
//  HorrorScopin
//
//  Created by Navati Jain on 2021-12-03.
//

import RxSwift
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
    
    var horoscopeObserver = PublishSubject<Horoscope>()
    let disposeBag = DisposeBag()
  
    func getHoroscoope(for sunSign: SunSigns, day: Days) {
      //  state = .fetching
        HoroscopeService.getHoroscope(for: sunSign.rawValue, day: day.rawValue) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let horoscoope):
                    self.horoscopeObserver.onNext(horoscoope)
                case .failure(let error):
                    self.horoscopeObserver.onError(error)
                }
            }
        }
    }
}

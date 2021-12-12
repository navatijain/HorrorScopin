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

class FormViewModel {
    var sunSignPickerData: [SunSigns] {
        SunSigns.allCases
    }
    
    var daysPickerData: [Days] {
        Days.allCases
    }
    
    var horoscopeObserver = PublishSubject<Horoscope>()
    var loadingObserver = BehaviorSubject<Bool>(value: false)
    let disposeBag = DisposeBag()
  
    func getHoroscoope(for sunSign: SunSigns, day: Days) {
        loadingObserver.onNext(true)
        HoroscopeService.getHoroscope(for: sunSign.rawValue, day: day.rawValue) {[weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let horoscoope):
                    self?.loadingObserver.onNext(false)
                    self?.horoscopeObserver.onNext(horoscoope)
                case .failure(let error):
                    self?.loadingObserver.onNext(false)
                    self?.horoscopeObserver.onError(error)
                }
            }
        }
    }
}

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
}

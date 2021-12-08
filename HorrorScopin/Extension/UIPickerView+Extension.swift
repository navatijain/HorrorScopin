//
//  UIPickerView+Extension.swift
//  HorrorScopin
//
//  Created by Navati Jain on 2021-12-08.
//

import UIKit

extension UIPickerView {
    var selectedRowIndex: Int {
        selectedRow(inComponent: 0)
    }
}

//
//  ViewController.swift
//  HorrorScopin
//
//  Created by Navati Jain on 2021-12-02.
//

import UIKit

class ViewController: UIViewController {
    
    /* UI */
    lazy var sunSignPicker: UIPickerView = {
        let sunSignPicker = UIPickerView()
        sunSignPicker.dataSource = self
        sunSignPicker.delegate = self
        sunSignPicker.translatesAutoresizingMaskIntoConstraints = false
        return sunSignPicker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(sunSignPicker)
        sunSignPicker.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        sunSignPicker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        sunSignPicker.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        SunSigns.allCases.count
    }
}

extension ViewController: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        SunSigns.allCases[row].rawValue.capitalized
    }
}


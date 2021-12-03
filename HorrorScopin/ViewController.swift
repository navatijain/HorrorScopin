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
        return sunSignPicker
    }()
    
    lazy var dayPicker: UIPickerView = {
        let sunSignPicker = UIPickerView()
        sunSignPicker.dataSource = self
        sunSignPicker.delegate = self
        return sunSignPicker
    }()
    
    lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .black
        return containerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSunSignPicker()
        view.backgroundColor = .white
    }
    
    private func setSunSignPicker(){
        view.addSubviewWithAutoLayout(sunSignPicker)
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
        switch pickerView {
        case sunSignPicker:
            return SunSigns.allCases.count
        case dayPicker:
            return Days.allCases.count
        default:
            return 0
        }
    }
}

extension ViewController: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case sunSignPicker:
            return SunSigns.allCases[row].rawValue.capitalized
        case dayPicker:
           return SunSigns.allCases[row].rawValue.capitalized
        default:
            return nil
        }
       
    }
}


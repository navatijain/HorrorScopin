//
//  ViewController.swift
//  HorrorScopin
//
//  Created by Navati Jain on 2021-12-02.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: UI
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
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [sunSignPicker,dayPicker])
        stackView.spacing = 20
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    //MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setSunSignPicker()
        view.backgroundColor = .white
    }
    
    private func setSunSignPicker(){
        view.addSubviewWithAutoLayout(stackView)
        let constraints = stackView.anchor(to: view, with: UIEdgeInsets(top: 15, left: 15, bottom: -15, right: -15))
        NSLayoutConstraint.activate(constraints)
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
            return Days.allCases[row].rawValue.capitalized
        default:
            return nil
        }
    }
}


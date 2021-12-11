//
//  ViewController.swift
//  HorrorScopin
//
//  Created by Navati Jain on 2021-12-02.
//

import UIKit

class FormViewController: UIViewController {
    
    let formViewModel = FormViewModel()
    
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
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("🔮", for: .normal)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 0.7
        button.addTarget(self, action: #selector(onButtonClick), for: .touchUpInside)
        return button
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [sunSignPicker,dayPicker, button, resultStackView])
        stackView.spacing = 20
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    //MARK: Result Components
   lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Description:"
        return label
    }()
    
    lazy var descriptionLabelContents = UILabel()
    
    lazy var compatibilityLabel: UILabel = {
         let label = UILabel()
         label.text = "Compatibility:"
         return label
     }()
     
    lazy var compatibilityContents = UILabel()
    
    lazy var resultStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [descriptionLabel,descriptionLabelContents,compatibilityLabel,compatibilityContents])
        stackView.spacing = 10
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    //MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        setup()
        setupHandler()
        
    }
    
    private func setupHandler() {
        formViewModel.stateChangeHandler = { [weak self] state in
            switch state {
            case .unselected:
                print("unselected")
            case  .fail:
                print("fail")
            case .fetching:
                print("spinner")
            case .success(let horoscope):
                let viewModel = PredictionViewModel(horoscope: horoscope)
                self?.present(PredictionViewController(viewModel: viewModel), animated: true)
            }
        }
    }
    
    private func setup(){
        view.addSubviewWithAutoLayout(stackView)
        let constraints = stackView.anchor(to: view, with: UIEdgeInsets(top: 15, left: 15, bottom: -15, right: -15))
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc private func onButtonClick() {
        let selectedSunSign = formViewModel.sunSignPickerData[sunSignPicker.selectedRowIndex]
        let selectedDay = formViewModel.daysPickerData[dayPicker.selectedRowIndex]
        formViewModel.getHoroscoope(for: selectedSunSign, day: selectedDay)
    }
}

extension FormViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case sunSignPicker:
            return formViewModel.sunSignPickerData.count
        case dayPicker:
            return formViewModel.daysPickerData.count
        default:
            return 0
        }
    }
}

extension FormViewController: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case sunSignPicker:
            return formViewModel.sunSignPickerData[row].rawValue.capitalized
        case dayPicker:
            return formViewModel.daysPickerData[row].rawValue.capitalized
        default:
            return nil
        }
    }
}

//
//  ViewController.swift
//  HorrorScopin
//
//  Created by Navati Jain on 2021-12-02.
//

import UIKit
import RxSwift
import RxCocoa

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
        let stackView = UIStackView(arrangedSubviews: [sunSignPicker,dayPicker, button, predictionStackView])
        stackView.spacing = 20
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    //MARK: Prediction Result Components
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
    
    lazy var predictionStackView: UIStackView = {
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
        //setObservers()
    }
    
    private func setup(){
        view.addSubviewWithAutoLayout(stackView)
        let constraints = stackView.anchor(to: view, with: UIEdgeInsets(top: 15, left: 15, bottom: -15, right: -15))
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc private func onButtonClick() {
        let selectedSunSign = formViewModel.sunSignPickerData[sunSignPicker.selectedRowIndex]
        let selectedDay = formViewModel.daysPickerData[dayPicker.selectedRowIndex]
        
        formViewModel.getHorosopeObservable(for: selectedSunSign, day: selectedDay)
            .map { $0?.description}
            .drive(descriptionLabelContents.rx.text)
            .disposed(by: formViewModel.disposeBag)
        
        formViewModel.getHorosopeObservable(for: selectedSunSign, day: selectedDay)
            .map { $0?.compatibility}
            .drive(compatibilityContents.rx.text)
            .disposed(by: formViewModel.disposeBag)
    }
    
//    private func hidePrediction() {
//        predictionStackView.isHidden = true
//    }
//
//    private func showPrediction() {
//        predictionStackView.isHidden = false
//    }
    
//    private func presentAlert(for error: Error) {
//        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
//        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//        alertController.addAction(cancel)
//        self.present(alertController, animated: true, completion: nil)
//    }
}

//MARK: Observers
extension FormViewController {
    private func setObservers(){
        setHoroscopeObserver()
        setLoadingObserver()
    }
    
    private func setHoroscopeObserver(){
        let result = formViewModel.horoscopeObserver.map { $0 }
            .asDriver(onErrorJustReturn: nil)
        
        result.map{ $0?.description ?? "" }
        .drive(descriptionLabelContents.rx.text)
        .disposed(by: formViewModel.disposeBag)
        
        result.map{ $0?.compatibility ?? "" }
        .drive(compatibilityContents.rx.text)
        .disposed(by: formViewModel.disposeBag)
        
    }
    
    private func setLoadingObserver() {
        formViewModel.loadingObserver.subscribe (onNext: { isLoading in
            isLoading ? Spinner.show(on: self.view) : Spinner.hide(from: self.view)
        }).disposed(by: formViewModel.disposeBag)
    }
}

//MARK: UIPicker
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

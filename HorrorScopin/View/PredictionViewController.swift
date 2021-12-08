//
//  PredictionViewController.swift
//  HorrorScopin
//
//  Created by Navati Jain on 2021-12-08.
//

import UIKit

class PredictionViewController: UIViewController {
    //MARK: UI
    
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
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [descriptionLabel,descriptionLabelContents,compatibilityLabel,compatibilityContents])
        stackView.spacing = 10
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    
    //MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
        setup()
    }
    
    private func setup(){
        view.addSubviewWithAutoLayout(stackView)
        let constraints = stackView.anchor(to: view, with: UIEdgeInsets(top: 10, left: 10, bottom: -10, right: -10))
        NSLayoutConstraint.activate(constraints)
    }
    
    


}

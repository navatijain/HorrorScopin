//
//  Spinner.swift
//  HorrorScopin
//
//  Created by Navati Jain on 2021-12-12.
//

import Foundation
import UIKit

open class Spinner: UIView {
    
    // MARK: - Properties
    public var outerLineWidth : CGFloat = 5.0
    public var outerEndStroke : CGFloat = 0.5
    public var outerAnimationDuration : CGFloat = 2.0
    public var currentOuterRotation : CGFloat = 0
    
    private var spinnerColor: UIColor? {
        didSet {
            layer.strokeColor = spinnerColor?.cgColor
        }
    }
    
    //MARK: - Init
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.commonInit()
    }
    
    // MARK: - Spinner show hide
    public static func show(on view: UIView, color: UIColor = .purple, backgroundColor: UIColor = .clear, size: CGFloat = 50.0) {
        let backgroundView = UIView()
        backgroundView.frame = view.frame
        //backgroundView.backgroundColor = Colors.themeLightGrey.withAlphaComponent(0.7)
        backgroundView.backgroundColor = backgroundColor
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.tag = 1000
        
        let spinner = Spinner()
        spinner.spinnerColor = color
        spinner.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = false
        
        backgroundView.addSubview(spinner)
        
        view.addSubview(backgroundView)
        
        var constraints = backgroundView.anchor(to: view)
        
        constraints.append(contentsOf: [
            spinner.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            spinner.widthAnchor.constraint(equalToConstant: size),
            spinner.heightAnchor.constraint(equalToConstant: size),
        ])
        
        NSLayoutConstraint.activate(constraints)
        
        spinner.startAnimating()
    }
    
    public static func hide(from view: UIView) {
        view.isUserInteractionEnabled = true
        view.subviews.forEach { (view) in
//            if view is Spinner {
//                view.removeFromSuperview()
//                view.superview?.removeFromSuperview()
//            }
            if view.tag == 1000 {
                view.removeFromSuperview()
            }
        }
    }
    
    // MARK: - OVERRIDE
    override open var layer: CAShapeLayer {
        return super.layer as! CAShapeLayer
    }
    
    override open class var layerClass: AnyClass {
        return CAShapeLayer.self
    }
    
    override open func layoutSubviews() {
        layer.path = UIBezierPath(ovalIn: bounds.insetBy(dx: layer.lineWidth / 2, dy: layer.lineWidth / 2)).cgPath
    }
}

extension Spinner {
    
    //MARK: - Private Methods
    private func commonInit() {
        layer.lineWidth = outerLineWidth
        layer.strokeStart = 0.0
        layer.strokeEnd = outerEndStroke
        layer.lineCap = .round
        layer.fillColor = nil
    }
    
    private func animateOuterRing() {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.fromValue = 360 * CGFloat(Double.pi/180)
        rotationAnimation.toValue = 0 * CGFloat(Double.pi/180)
        rotationAnimation.duration = Double(outerAnimationDuration)
        rotationAnimation.repeatCount = HUGE
        layer.add(rotationAnimation, forKey: "rotateOuter")
    }
    
    private func startAnimating() {
        animateOuterRing()
    }
    
    private func stopAnimating() {
        layer.removeAllAnimations()
        removeFromSuperview()
    }
}



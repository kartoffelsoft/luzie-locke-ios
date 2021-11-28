//
//  PulseRoundButton.swift
//  luzie-locke-ios
//
//  Created by Harry on 16.10.21.
//

import UIKit

class PulseRoundButton: UIButton {
  
  let radius: CGFloat
  
  let pulseLayer      = CAShapeLayer()
  let pulseAnimation  = CABasicAnimation(keyPath: "transform.scale")
  
  override var backgroundColor: UIColor? {
    didSet {
      pulseLayer.fillColor = backgroundColor?.withAlphaComponent(0.3).cgColor
    }
  }
  
  init(radius: CGFloat) {
    self.radius = radius
    super.init(frame: .zero)
    
    configureButton()
    configurePulseLayer()
  }
  
  private func configureButton() {
    titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
    translatesAutoresizingMaskIntoConstraints = false
    layer.cornerRadius = radius
  }
  
  private func configurePulseLayer() {
    let circularPath = UIBezierPath(arcCenter: .zero, radius: radius, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
    pulseLayer.path = circularPath.cgPath
    pulseLayer.position = .init(x: radius, y: radius)
    
    pulseAnimation.toValue = 1.3
    pulseAnimation.duration = 0.8
    pulseAnimation.autoreverses = true
    pulseAnimation.repeatCount = Float.infinity
    pulseAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
    
    layer.insertSublayer(pulseLayer, at: 0)
  }
  
  func animatePulse() {
    pulseLayer.add(pulseAnimation, forKey: "pulse")
  }
  
  func stopPulse() {
    pulseLayer.removeAllAnimations()
  }
  
  override var intrinsicContentSize: CGSize {
    var size    = super.intrinsicContentSize
    size.height = radius * 2
    size.width  = radius * 2
    return size
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

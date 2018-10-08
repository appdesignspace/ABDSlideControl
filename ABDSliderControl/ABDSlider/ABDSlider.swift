//
//  ABDSlider.swift
//  ABDSliderControl
//
//  Created by Destin on 03/10/2018.
//  Copyright © 2018 com.appsbydestin. All rights reserved.
//

import UIKit

@IBDesignable class ABDSlider: UIControl {
  var minValue = 0.0 {
    didSet {
      updateTrackLayers()
    }
  }
  var maxValue = 1.0 {
    didSet {
      updateTrackLayers()
    }
  }
  
  // Users are able to modify Default Values
  var lowerValue: Double = 0.2 {
    didSet {
      updateTrackLayers()
    }
  }
  
 var upperValue: Double = 0.8 {
    didSet {
      updateTrackLayers()
    }
  }
  
  @IBInspectable var trackTintColor: UIColor = UIColor(white: 0.9, alpha: 1.0) {
    didSet {
      bgTrackLayer.setNeedsDisplay()
    }
  }
  
  @IBInspectable var knobHighlightTintColor: UIColor = UIColor(red: 0.0, green: 0.45, blue: 0.94, alpha: 1.0) {
    didSet {
      lowerKnobLayer.setNeedsDisplay()
      upperKnobLayer.setNeedsDisplay()
    }
  }
  
  @IBInspectable var knobTintColor: UIColor = UIColor(red: 0.0, green: 0.45, blue: 0.94, alpha: 1.0) {
    didSet {
      lowerKnobLayer.setNeedsDisplay()
      upperKnobLayer.setNeedsDisplay()
    }
  }
  
  var curve: CGFloat = 1.0 {
    didSet {
      bgTrackLayer.setNeedsDisplay()
      lowerKnobLayer.setNeedsDisplay()
      upperKnobLayer.setNeedsDisplay()
    }
  }
  
  // Define Slider Tracks
  let bgTrackLayer = ABDSliderTrackLayer()
  let lowerKnobLayer = ABDSliderKnobLayer()
  let upperKnobLayer = ABDSliderKnobLayer()
  
  var previousPosition = CGPoint()
  
  var knobWidth: CGFloat {
    return CGFloat(bounds.height)
  }
  
  override var frame: CGRect {
    didSet {
      updateTrackLayers()
    }
  }
  
  //MARK: - INIT METHIDS
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    lowerKnobLayer.slider = self
    upperKnobLayer.slider = self
  }
  
  override func draw(_ rect: CGRect) {
    
    bgTrackLayer.slider = self
    bgTrackLayer.contentsScale = UIScreen.main.scale
    layer.addSublayer(bgTrackLayer)
    
    lowerKnobLayer.slider = self
    lowerKnobLayer.contentsScale = UIScreen.main.scale
    layer.addSublayer(lowerKnobLayer)
    
    upperKnobLayer.slider = self
    upperKnobLayer.contentsScale = UIScreen.main.scale
    layer.addSublayer(upperKnobLayer)
    
    updateTrackLayers()
  }
  
  private func updateTrackLayers() {
    CATransaction.begin()
    CATransaction.setDisableActions(true)
    
    bgTrackLayer.frame = bounds.insetBy(dx: 0.0, dy: bounds.height / 3.0)
    bgTrackLayer.setNeedsDisplay()
   
    let lowerKnobCenter = CGFloat(positionForKnob(lowerValue))
    lowerKnobLayer.frame = CGRect(x: lowerKnobCenter - knobWidth / 2.0,y: 0.0,
                                  width: knobWidth, height: knobWidth)
    lowerKnobLayer.setNeedsDisplay()
    
    let upperKnobCenter = CGFloat(positionForKnob(upperValue))
    upperKnobLayer.frame = CGRect(x: upperKnobCenter - knobWidth / 2.0, y: 0.0,
                                  width: knobWidth, height: knobWidth)
    upperKnobLayer.setNeedsDisplay()
    
    CATransaction.commit()
  }
  
  func positionForKnob(_ value: Double) -> Double {
    return Double(bounds.width - knobWidth) * (value - minValue) / (maxValue - minValue) +  Double(knobWidth / 2.0)
  }
  
  //MARK: UITRACKING EVENTS
  
  override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
    previousPosition = touch.location(in: self)
    
    //
    if lowerKnobLayer.frame.contains(previousPosition) {
      lowerKnobLayer.isHighlighted = true
      
    } else if upperKnobLayer.frame.contains(previousPosition) {
      upperKnobLayer.isHighlighted = true
    }
    
    return lowerKnobLayer.isHighlighted || upperKnobLayer.isHighlighted
  }
  
  override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
    let position = touch.location(in: self)
    
    //
    let deltaPosition = Double(position.x - previousPosition.x)
    let deltaValue = (maxValue - minValue) * deltaPosition / Double(bounds.width - knobWidth)
    
    previousPosition = position
    
    //
    if lowerKnobLayer.isHighlighted {
      lowerValue += deltaValue
      lowerValue = boundValue(value: lowerValue, toLowerValue: minValue, upperValue: upperValue)
    
    } else if upperKnobLayer.isHighlighted {
      upperValue += deltaValue
      upperValue = boundValue(value: upperValue, toLowerValue: lowerValue, upperValue: maxValue)
    }
    
    sendActions(for: .valueChanged)
    
    return true
  }
  
  override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
    lowerKnobLayer.isHighlighted = false
    upperKnobLayer.isHighlighted = false
  }
  
  private func boundValue(value: Double,
                          toLowerValue lowerValue: Double,
                          upperValue: Double) -> Double {
    return min(max(value, lowerValue), upperValue)
  }
  
}

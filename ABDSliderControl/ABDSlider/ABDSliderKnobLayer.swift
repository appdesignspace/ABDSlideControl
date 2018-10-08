//
//  ABDSliderKnobLayer.swift
//  ABDSliderControl
//
//  Created by Destin on 04/10/2018.
//  Copyright © 2018 com.appsbydestin. All rights reserved.
//

import UIKit

class ABDSliderKnobLayer: CALayer {
  weak var slider: ABDSlider?
  
  var previousPosition = CGPoint()
  
  var isHighlighted: Bool = false {
    didSet {
      setNeedsDisplay()
    }
  }
  
  override func draw(in ctx: CGContext) {
    
    if let slider = slider {
      let knobFrame = bounds.insetBy(dx: 2.0, dy: 2.0)
      let cornerRadius = knobFrame.height * slider.curve / 2.0
      let knobPath = UIBezierPath(roundedRect: knobFrame,
                                  cornerRadius: cornerRadius)
      
      ctx.setFillColor(slider.knobTintColor.cgColor)
      ctx.addPath(knobPath.cgPath)
      ctx.fillPath()
      
      if isHighlighted {
        ctx.setFillColor(UIColor(white: 0.0, alpha: 0.1).cgColor)
        ctx.addPath(knobPath.cgPath)
        ctx.fillPath()
      }
      
    }
  }
  
}

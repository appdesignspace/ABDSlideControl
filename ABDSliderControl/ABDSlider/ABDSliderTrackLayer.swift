//
//  ABDSliderTrackLayer.swift
//  ABDSliderControl
//
//  Created by Destin on 04/10/2018.
//  Copyright © 2018 com.appsbydestin. All rights reserved.
//

import UIKit

class ABDSliderTrackLayer: CALayer {
  weak var slider: ABDSlider?
  
  override func draw(in ctx: CGContext) {
    if let slider = slider {
      
      //
      let cornerRadius = bounds.height * slider.curve / 2.0
      let path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
      ctx.addPath(path.cgPath)
      
      // Fill Track
      ctx.setFillColor(slider.trackTintColor.cgColor)
      ctx.addPath(path.cgPath)
      ctx.fillPath()
      
      // Fill Knobs
      ctx.setFillColor(slider.knobHighlightTintColor.cgColor)
      let lowerValuePos = CGFloat(slider.positionForKnob(slider.lowerValue))
      let upperValuePos = CGFloat(slider.positionForKnob(slider.upperValue))
      let rect = CGRect(x: lowerValuePos, y: 0.0,
                        width: upperValuePos - lowerValuePos, height: bounds.height)
      ctx.fill(rect)
    }
    
  }
  
}

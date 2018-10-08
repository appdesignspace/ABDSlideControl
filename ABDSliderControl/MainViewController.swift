//
//  ViewController.swift
//  ABDSliderControl
//
//  Created by Destin on 03/10/2018.
//  Copyright © 2018 com.appsbydestin. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
  // Initiate Instance of Custom Slider
  @IBOutlet weak var slider: ABDSlider!
    
  override func viewDidLoad() {
    super.viewDidLoad()

    //slider.addTarget(self, action: #selector(rangeSliderValueChanged), for: .valueChanged)
  }
  
//  @objc func rangeSliderValueChanged(_ slider: ABDSlider) {
//    print("Range slider value changed: (\(slider.lowerValue) \(slider.upperValue))")
//  }
  
  @IBAction func sliderChanged(sender: Any) {
    print("Range slider value changed: (\(slider.lowerValue) \(slider.upperValue))")
  }
}


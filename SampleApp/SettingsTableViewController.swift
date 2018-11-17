//
//  SettingsTableViewController.swift
//  ARChartsSampleApp
//
//  Created by Boris Emorine on 7/25/17.
//  Copyright © 2017 Boris Emorine. All rights reserved.
//

import UIKit
import  ARCharts

protocol SettingsDelegate {
    func didUpdateSettings(_ settings: Settings)
}

class SettingsTableViewController: UITableViewController {
    
    var settings: Settings?
    var delegate: SettingsDelegate?
    
    @IBOutlet weak var longPressAnimationSegmentedControl: UISegmentedControl!
    @IBOutlet weak var entranceAnimationSegmentedControl: UISegmentedControl!
    @IBOutlet weak var opacitySlider: UISlider!
    @IBOutlet weak var opacityLabel: UILabel!
    @IBOutlet weak var labelSwitch: UISwitch!
    @IBOutlet weak var widthLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var lengthLabel: UILabel!
    @IBOutlet weak var widthSlider: UISlider!
    @IBOutlet weak var heightSlider: UISlider!
    @IBOutlet weak var lengthSlider: UISlider!
    
    @IBOutlet weak var dataSetSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupControlsState()
    }
    
    private func setupControlsState() {
        guard let settings = settings else {
            return
        }
        
        entranceAnimationSegmentedControl.selectedSegmentIndex = settings.index(forEntranceAnimationType: settings.animationType)
        longPressAnimationSegmentedControl.selectedSegmentIndex = settings.index(forLongPressAnimationType: settings.longPressAnimationType)
        opacitySlider.value = settings.barOpacity
        opacityLabel.text = String(format: "%.1f", arguments: [opacitySlider.value])
        labelSwitch.isOn = settings.showLabels
        widthSlider.value = settings.graphWidth
        heightSlider.value = settings.graphHeight
        lengthSlider.value = settings.graphLength
        widthLabel.text = String(format: "Width: %.1f", settings.graphWidth)
        heightLabel.text = String(format: "Height: %.1f", settings.graphHeight)
        lengthLabel.text = String(format: "Length: %.1f", settings.graphLength)
        dataSetSegmentedControl.selectedSegmentIndex = settings.dataSet
    }
    
    // MARK: Actions
    
    @IBAction func handleEntranceAnimationSegmentControlValueChange(_ sender: UISegmentedControl) {
        if let entranceAnimationType = settings?.entranceAnimationType(forIndex: sender.selectedSegmentIndex) {
            settings?.animationType = entranceAnimationType
        } else {
            settings?.animationType = .fade
        }
    }
    
    @IBAction func handleLongPressAnimationSegmentControlValueChange(_ sender: UISegmentedControl) {
        if let longPressAnimationType = settings?.longPressAnimationType(forIndex: sender.selectedSegmentIndex){
            settings?.longPressAnimationType = longPressAnimationType
        } else {
            settings?.longPressAnimationType = .shrink
        }
    }
    
    @IBAction func handleOpacitySliderValueChange(_ sender: UISlider) {
        settings?.barOpacity = sender.value
        opacityLabel.text = String(format: "%.1f", arguments: [sender.value])
    }
    
    @IBAction func handleSwitchValueChange(_ sender: UISwitch) {
        settings?.showLabels = sender.isOn
    }
    
    @IBAction func handleDataSetValueChange(_ sender: UISegmentedControl) {
        settings?.dataSet = sender.selectedSegmentIndex
    }
        
    @IBAction func handleWidthSliderValueChange(_ sender: UISlider) {
        widthLabel.text = String(format: "Width: %.1f", sender.value)
        settings?.graphWidth = sender.value
    }
    
    @IBAction func handleHeightSliderValueChange(_ sender: UISlider) {
        heightLabel.text = String(format: "Height: %.1f", sender.value)
        settings?.graphHeight = sender.value
    }
    
    @IBAction func handleLengthSliderValueChange(_ sender: UISlider) {
        lengthLabel.text = String(format: "Length: %.1f", sender.value)
        settings?.graphLength = sender.value
    }
    
    @IBAction func handleTapSave(_ sender: Any) {
        if let settings = settings {
            delegate?.didUpdateSettings(settings)
        }
        self.dismiss(animated: true, completion: nil)
    }

}

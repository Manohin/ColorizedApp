//
//  SettingsViewController.swift
//  ColorizedApp
//
//  Created by Alexey Manokhin on 05.02.2023.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    @IBOutlet var redValueLabel: UILabel!
    @IBOutlet var greenValueLabel: UILabel!
    @IBOutlet var blueValueLabel: UILabel!
    
    @IBOutlet var redColorSlider: UISlider!
    @IBOutlet var greenColorSlider: UISlider!
    @IBOutlet var blueColorSlider: UISlider!
    
    @IBOutlet var colorDisplayView: UIView!
    
    var color: UIColor!
    
    unowned var delegate: SettingsViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorDisplayView.layer.cornerRadius = 15
        colorDisplayView.backgroundColor = color
        setRgbToSlider()
        setLabelText(redValueLabel, redColorSlider)
        setLabelText(greenValueLabel, greenColorSlider)
        setLabelText(blueValueLabel, blueColorSlider)
    }
    
    @IBAction func doneButtonTapped() {
        guard let backgroundColor = colorDisplayView.backgroundColor else { return }
        delegate.setColor(for: backgroundColor)
        dismiss(animated: true)
    }
    
    @IBAction func redColorSliderAction() {
        setLabelText(redValueLabel, redColorSlider)
        setColor()
    }
    
    @IBAction func greenColorSliderAction() {
        setLabelText(greenValueLabel, greenColorSlider)
        setColor()
    }
    
    @IBAction func blueColorSliderAction() {
        setLabelText(blueValueLabel, blueColorSlider)
        setColor()
    }
    
    private func setLabelText(_ label: UILabel, _ slider: UISlider) {
        label.text = String(format: "%.2f", slider.value)
    }
    
    private func setColor() {
        colorDisplayView.backgroundColor = UIColor(
            red: CGFloat(redColorSlider.value),
            green: CGFloat(greenColorSlider.value),
            blue: CGFloat(blueColorSlider.value),
            alpha: 1
        )
    }
    
    private func setRgbToSlider() {
        let colors = CIColor(color: color)

        redColorSlider.value = Float(colors.red)
        greenColorSlider.value = Float(colors.green)
        blueColorSlider.value = Float(colors.blue)
    }
}

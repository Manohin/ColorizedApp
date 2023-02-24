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
    
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    
    var color: UIColor!
    
    unowned var delegate: SettingsViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorDisplayView.layer.cornerRadius = 15
        colorDisplayView.backgroundColor = color
        
        setRgbToSlider()
        
        setText(redValueLabel, redTextField, redColorSlider)
        setText(greenValueLabel, greenTextField, greenColorSlider)
        setText(blueValueLabel, blueTextField, blueColorSlider)
        
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
        
        
    }
    
    @IBAction func doneButtonTapped() {
        guard let backgroundColor = colorDisplayView.backgroundColor else { return }
        delegate.setColor(for: backgroundColor)
        dismiss(animated: true)
    }
    
    @IBAction func redColorSliderAction() {
        setText(redValueLabel, redTextField, redColorSlider)
        setColor()
    }
    
    @IBAction func greenColorSliderAction() {
        setText(greenValueLabel, greenTextField, greenColorSlider)
        setColor()
    }
    
    @IBAction func blueColorSliderAction() {
        setText(blueValueLabel, blueTextField, blueColorSlider)
        setColor()
    }
    
    private func setText(_ label: UILabel,_ textField: UITextField, _ slider: UISlider) {
        label.text = String(format: "%.2f", slider.value)
        textField.text = String(format: "%.2f", slider.value)
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
// MARK: - UITextFieldDelegate


extension SettingsViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let value = textField.text else { return }
        guard let floatValue = Float(value) else { return }
        
        switch textField {
        case redTextField:
            redColorSlider.value = floatValue
        case greenTextField:
            greenColorSlider.value = floatValue
        default:
            blueColorSlider.value = floatValue
        }
        setColor()
    }
    
}

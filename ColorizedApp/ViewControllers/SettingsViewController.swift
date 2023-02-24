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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
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
    
    private func showAlert(title: String, message: String, handler: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "OK", style: .cancel, handler: handler)
        
        alert.addAction(okButton)
        
        present(alert, animated: true)
    }
}
// MARK: - UITextFieldDelegate

extension SettingsViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let value = textField.text else { return }
        guard let floatValue = Float(value) else {
            showAlert(title: "Внимание!", message: "Введите корректное значение от 0 до 1.00") {_ in
                textField.text = ""
            }
            
            return
        }
        guard floatValue <= 1.0 else {
            if textField == redTextField {
                redColorSlider.setValue(1.00, animated: true)
                redValueLabel.text = String(format: "%.2f", 1.00)
                redTextField.text = "1.00"
            } else if textField == greenTextField {
                greenColorSlider.setValue(1.00, animated: true)
                greenValueLabel.text = String(format: "%.2f", 1.00)
                greenTextField.text = "1.00"
            } else {
                blueColorSlider.setValue(1.00, animated: true)
                blueValueLabel.text = String(format: "%.2f", 1.00)
                blueTextField.text = "1.00"
            }
            setColor()
            return
        }
        
        switch textField {
        case redTextField:
            redColorSlider.setValue(floatValue, animated: true)
            redValueLabel.text = String(format: "%.2f", floatValue)
        case greenTextField:
            greenColorSlider.setValue(floatValue, animated: true)
            greenValueLabel.text = String(format: "%.2f", floatValue)
        default:
            blueColorSlider.setValue(floatValue, animated: true)
            blueValueLabel.text = String(format: "%.2f", floatValue)
        }
        setColor()
    }
}

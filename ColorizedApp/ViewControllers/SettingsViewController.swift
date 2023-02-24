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
        
        addDoneButton(textField: redTextField)
        addDoneButton(textField: greenTextField)
        addDoneButton(textField: blueTextField)
        
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
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        
        alert.addAction(okAction)
        
        present(alert, animated: true)
    }
    
    private func addDoneButton(textField: UITextField) {
        let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: .none)
        self.tabBarController?.navigationItem.rightBarButtonItems = [rightBarButtonItem]
    }
        @objc private func call_Method () {
        print("Click")
        }

    }
    
// MARK: - UITextFieldDelegate


extension SettingsViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let value = textField.text else { return }
        guard let floatValue = Float(value) else {
            showAlert(title: "Внимание!", message: "Введите корректное значение!")
            textField.text = ""
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

//
//  MainViewController.swift
//  ColorizedApp
//
//  Created by Alexey Manokhin on 23.02.2023.
//

import UIKit

protocol SettingsViewControllerDelegate: AnyObject {
    func setColor(for color: UIColor)
}

final class MainViewController: UIViewController {
    
    @IBAction func settingsButton(_ sender: UIBarButtonItem) {
        
        dismiss(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "segueIdentifier" else { return }
        
        //  guard let navigationController = segue.destination as? UINavigationController else { return }
        
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        settingsVC.color = view.backgroundColor
        settingsVC.delegate = self
    }
    
}

extension MainViewController: SettingsViewControllerDelegate {
    func setColor(for color: UIColor) {
        view.backgroundColor = color
    }
}

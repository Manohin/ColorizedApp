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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        settingsVC.color = view.backgroundColor
        settingsVC.delegate = self
    }
}

// MARK: - SettingsViewControllerDelegate

extension MainViewController: SettingsViewControllerDelegate {
    func setColor(for color: UIColor) {
        view.backgroundColor = color
    }
}

//
//  Color.swift
//  ColorizedApp
//
//  Created by Alexey Manokhin on 23.02.2023.
//

import UIKit

struct Color {
    let red: CGFloat
    let green: CGFloat
    let blue: CGFloat
    
    static func getColor() -> UIColor {
        UIColor(red: 255, green: 255, blue: 255, alpha: 1)
    }
}

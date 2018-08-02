//
//  Constants.swift
//  062_path
//
//  Created by Oleg Kolomyitsev on 30/07/2018.
//  Copyright © 2018 Oleg Kolomyitsev. All rights reserved.
//

import UIKit

enum Constants {
    enum Drawing {
        enum Point {
            static let color: UIColor = .red
            enum Size {
                static let start: CGFloat = 20
                static let final: CGFloat = 15
                static let `default`: CGFloat = 10
            }
        }
        enum Route {
            static let color: UIColor = .blue
            static let width: CGFloat = 5
        }
    }
    enum ScreenScale {
        static let inset = UIEdgeInsets(
            top: 20 / 320 * UIScreen.main.bounds.height,
            left: 0,
            bottom: 0,
            right: 20 / 568 * UIScreen.main.bounds.width)
    }
}

//
//  IProcessor.swift
//  062_path
//
//  Created by Oleg Kolomyitsev on 30/07/2018.
//  Copyright © 2018 Oleg Kolomyitsev. All rights reserved.
//

import Foundation

typealias CanStartWorking = Bool

protocol IProcessor {
    @discardableResult
    func tryToStartWorking() -> CanStartWorking
}

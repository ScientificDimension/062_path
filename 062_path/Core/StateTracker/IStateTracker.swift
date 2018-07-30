//
//  IStateTracker.swift
//  062_path
//
//  Created by Oleg Kolomyitsev on 29/07/2018.
//  Copyright © 2018 Oleg Kolomyitsev. All rights reserved.
//

import Foundation

enum RouteProcessingState: Int {
    case selectStartPoint = 0
    case selectFinalPoint
    case completed
    
    mutating func next() {
        switch self {
        case .selectStartPoint:
            self = .selectFinalPoint
        case .selectFinalPoint:
            self = .completed
        case .completed:
            self = .selectStartPoint
        }
    }
}

protocol IStateTracker {
    var currentState: RouteProcessingState { get }
    func next()
}

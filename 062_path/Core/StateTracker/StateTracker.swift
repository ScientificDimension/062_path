//
//  StateTracker.swift
//  062_path
//
//  Created by Oleg Kolomyitsev on 29/07/2018.
//  Copyright © 2018 Oleg Kolomyitsev. All rights reserved.
//

import Foundation

class StateTracker: IStateTracker { 
    
    private(set) var currentState: RouteProcessingState = .selectStartPoint
    
    func next() {
        currentState.next()
    }
}

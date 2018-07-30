//
//  IAlertAssistant.swift
//  062_path
//
//  Created by Oleg Kolomyitsev on 30/07/2018.
//  Copyright © 2018 Oleg Kolomyitsev. All rights reserved.
//

import Foundation

typealias EmptyClosure = () -> Void

enum AlertTitle: String {

    case cannotStart = "The route can not be built from start point."
    case cannotFinish = "The route can not be built to end point."
    case cannotProceedDueToEqual = "The start and end points of the route are the same: select another end point."
    case routesNotFound = "The start and end points of the route are not linked: select another end point."
    
    var text: String {
        return self.rawValue
    }
}

protocol IAlertAssistant {
    func tryShowAlert(title: AlertTitle,  completion: @escaping EmptyClosure)
}

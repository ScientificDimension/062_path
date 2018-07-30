//
//  IRoutesCalculator.swift
//  017_test_dispatchGroup
//
//  Created by Oleg Kolomyitsev on 28/07/2018.
//  Copyright © 2018 Oleg Kolomyitsev. All rights reserved.
//

import Foundation

typealias Vertex = Int
typealias ToVertices = [[Vertex]]
typealias Routes = [[Vertex]]

protocol IRoutesCalculator {
    func getRoutes(from start: Vertex, to final: Vertex) -> Routes
    func log(_ data: [[Vertex]])
}

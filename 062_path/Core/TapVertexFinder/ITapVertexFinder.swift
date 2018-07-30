//
//  ITapVertexFinder.swift
//  062_path
//
//  Created by Oleg Kolomyitsev on 29/07/2018.
//  Copyright © 2018 Oleg Kolomyitsev. All rights reserved.
//

import UIKit

protocol ITapVertexFinder {
    func findNearestVertex(to tap: CGPoint) -> Vertex
}


//
//  Container.swift
//  062_path
//
//  Created by Oleg Kolomyitsev on 29/07/2018.
//  Copyright © 2018 Oleg Kolomyitsev. All rights reserved.
//

import Foundation

struct Container: Decodable {
    let points: [String: Point]
    let paths: [String: [String: Path]]
    let plan_id: String
}

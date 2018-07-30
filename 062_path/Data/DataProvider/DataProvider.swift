//
//  DataProvier.swift
//  062_path
//
//  Created by Oleg Kolomyitsev on 29/07/2018.
//  Copyright © 2018 Oleg Kolomyitsev. All rights reserved.
//

import Foundation

class DataProvider: IDataProvider {
    
    func getData() -> Container {
        guard
            let url = Bundle.main.url(forResource: "data", withExtension: "json"),
            let json = try? Data(contentsOf: url),
            let container = try? JSONDecoder().decode(Container.self, from: json) else {
                fatalError()
        }
        
        return container
    }
}

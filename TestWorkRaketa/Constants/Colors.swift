//
//  Colors.swift
//  TestWorkRaketa
//
//  Created by Vladimirus on 28.10.2020.
//

import UIKit

enum Colors {
    case green
    
    func color() -> UIColor {
        switch self {
        case .green:
            return #colorLiteral(red: 0.09681961685, green: 0.6830199957, blue: 0.4399944842, alpha: 1)
            
        }
    }
}

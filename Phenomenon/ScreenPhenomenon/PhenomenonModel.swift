//
//  PhenomenonModel.swift
//  Phenomenon
//
//  Created by Alexander Suprun on 16.07.2024.
//

import Foundation
import UIKit

enum PhenomenonModel: CaseIterable {
    case snowy
    case rainy
    case thunderstorm
    case rainbow
    
    func imageSet() -> UIImage {
        switch self {
        case .snowy:
            return UIImage(resource: .snow)
        case .rainy:
            return UIImage(resource: .rainy)
        case .thunderstorm:
            return UIImage(resource: .thunderstorm)
        case .rainbow:
            return UIImage(resource: .rainbow)
        }
    }
    
    func imageBackgound() -> UIImage {
        switch self {
        case .snowy:
            return UIImage(resource: .houseSnow)
        case .rainy:
            return UIImage(resource: .houseRain)
        case .thunderstorm:
            return UIImage(resource: .houseThunder)
        case .rainbow:
            return UIImage(resource: .houseRainbow)
        }
    }
    
    func getColors() -> [CGColor] {
        switch self {
        case .snowy:
            return [UIColor.blue.cgColor, UIColor.white.cgColor]
        case .rainy:
            return [UIColor.blue.cgColor, UIColor.darkGray.cgColor]
        case .thunderstorm:
            return [UIColor.lightGray.cgColor, UIColor.darkGray.cgColor]
        case .rainbow:
            return [UIColor.orange.cgColor, UIColor.yellow.cgColor]
        }
    }
    
    enum Section: Int, CaseIterable, Hashable {
        case main
    }
    
    struct PhenomenonDataModel: Hashable {

        let image: UIImage
    }
}

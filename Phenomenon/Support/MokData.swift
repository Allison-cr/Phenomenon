//
//  Support.swift
//  Phenomenon
//
//  Created by Alexander Suprun on 16.07.2024.
//

import Foundation
import UIKit

class MokData {
    func PhenomenonData() -> [PhenomenonModel.PhenomenonDataModel] {
        [
            PhenomenonModel.PhenomenonDataModel(image: PhenomenonModel.imageSet(.snowy)()),
            PhenomenonModel.PhenomenonDataModel(image: PhenomenonModel.imageSet(.rainy)()),
            PhenomenonModel.PhenomenonDataModel(image: PhenomenonModel.imageSet(.thunderstorm)()),
            PhenomenonModel.PhenomenonDataModel(image: PhenomenonModel.imageSet(.rainbow)())
        ]
    }
}

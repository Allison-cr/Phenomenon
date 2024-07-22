//
//  PhenomenonBuilder.swift
//  Phenomenon
//
//  Created by Alexander Suprun on 16.07.2024.
//

import Foundation

final class PhenomenonBuilder {
    func assembly() -> PhenomenonViewController {
        let viewController = PhenomenonViewController()
        let presenter = PhenomenonPresenter()
        presenter.viewController = viewController
        viewController.presenter = presenter
        return viewController
    }
}

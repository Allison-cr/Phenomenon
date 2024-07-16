//
//  MainCoordinator.swift
//  Phenomenon
//
//  Created by Alexander Suprun on 16.07.2024.
//

import Foundation
import UIKit

final class MainCoordinator: ICoordinator {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        runMenuFlow()
    }
     
    private func runMenuFlow() {
        let viewController = PhenomenonViewController() 
        navigationController.isNavigationBarHidden = true
        navigationController.setViewControllers([viewController], animated: true)
    }
}

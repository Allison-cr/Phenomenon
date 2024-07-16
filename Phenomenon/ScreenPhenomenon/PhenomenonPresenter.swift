//
//  PhenomenonPresenter.swift
//  Phenomenon
//
//  Created by Alexander Suprun on 16.07.2024.
//

import UIKit

protocol IPhenomenonPresenter: AnyObject {
    func loadData()

}

final class PhenomenonPresenter: IPhenomenonPresenter {
//    private var clouser: EmptyClosure?
    weak var viewController: IPhenomenonViewController?
    

    func loadData() {
        let model = MokData().PhenomenonCategory()
        viewController?.viewReady(model: model)
    }
}

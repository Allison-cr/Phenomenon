//
//  PhenomenonViewController.swift
//  Phenomenon
//
//  Created by Alexander Suprun on 16.07.2024.
//

import UIKit

protocol IPhenomenonViewController: AnyObject {
    func viewReady(model: [PhenomenonModel])
}


class PhenomenonViewController: UIViewController {
  
    // MARK: Variables
    private lazy var collectionView: UICollectionView = settingCollectionView()

    
    // MARK: Dependencies
    var presenter: IPhenomenonPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    } 


}

private extension PhenomenonViewController {
    func settingCollectionView() -> UICollectionView {
        let collection = UICollectionView()
        return collection
    }
}


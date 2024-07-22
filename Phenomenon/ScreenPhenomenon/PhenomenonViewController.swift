//
//  PhenomenonViewController.swift
//  Phenomenon
//
//  Created by Alexander Suprun on 16.07.2024.
//

import UIKit

protocol IPhenomenonViewController: AnyObject {
    func viewReady(model: [PhenomenonModel.PhenomenonDataModel])
    func updateBackground(image: UIImage)
}

class PhenomenonViewController: UIViewController {
    
    // MARK: Variables
    private lazy var textLabel: UILabel = settingTextLabel()
    private lazy var headerView: UIView = settingHeaderView()
    private lazy var houseImageView: UIImageView = setupBackground()
    private lazy var collectionView: UICollectionView = settingCollectionView()
    private var elements: [PhenomenonModel.PhenomenonDataModel] = []
    var dataSource: CollectionDataSource?
    
    // MARK: Dependencies
    var presenter: IPhenomenonPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingMainView()
        collectionView.delegate = self
        presenter?.loadData()
    }
 
  
    // MARK: - Applying Random Effect
    private func randomStart() {
        guard !elements.isEmpty else { return }
        let randomIndex = Int.random(in: 0..<elements.count)
        let phenomenon = PhenomenonModel.allCases[randomIndex]
        let indexPath = IndexPath(item: randomIndex, section: 0)
        self.collectionView.scrollToItem(at: indexPath, at: .top, animated: false)

        presenter?.updateWeatherEffect(in: view, for: randomIndex)
        presenter?.updateWeatherBackground(for: phenomenon)
        presenter?.updateHeaderBackground(in: headerView, for: phenomenon)
    }
}
// MARK: - Backoground
private extension PhenomenonViewController {
    func setupBackground() -> UIImageView {
        let houseImageView = UIImageView()
        houseImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(houseImageView)
        return houseImageView
    }
    
    func settingHeaderView() -> UIView {
        var headerView = UIView()
        headerView = RoundedBottomCornersView()
        headerView.backgroundColor = .purple
        headerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerView)
        return headerView
    }
    
    func settingTextLabel() -> UILabel {
        let label = UILabel()
        label.text = "chose_the_weather".localized
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(label)
        return label
    }
}

// MARK: - Load Data
extension PhenomenonViewController: IPhenomenonViewController {
    func viewReady(model: [PhenomenonModel.PhenomenonDataModel]) {
        elements = model
        reloadData()
        
        DispatchQueue.main.async {
            self.randomStart()
        }
    }
    
    func updateBackground(image: UIImage) {
        UIView.transition(with: houseImageView, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.houseImageView.image = image
        }, completion: nil)
    }
}

// MARK: - SettingView
private extension PhenomenonViewController {
    func settingMainView() {
        settingDataSource()
        settingLayout()
        reloadData()
    }

    func settingCollectionView() -> UICollectionView {
        let collection = UICollectionView(
            frame: .zero,
            collectionViewLayout: settingCollectionLayout()
        )
        collection.register(
            PhenomenonCell.self,
            forCellWithReuseIdentifier: "\(PhenomenonCell.self)"
        )
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.alwaysBounceVertical = false
        headerView.addSubview(collection)
        return collection
    }
    
    func settingLayout() {
        
        NSLayoutConstraint.activate([
            houseImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: Margins.dividedScreen - 16),
            houseImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            houseImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            houseImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 8),
            collectionView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: Margins.dividedScreen + 16)
        ])
        
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 64),
            textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16),
            textLabel.heightAnchor.constraint(equalToConstant: 16)
         ])
        
        
        view.bringSubviewToFront(headerView)
    }
}
// MARK: - Setting DataSource and Layout collection
private extension PhenomenonViewController {
    func settingDataSource() {
        dataSource = CollectionDataSource(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, itemIdentifier in
                let section = PhenomenonModel.Section.allCases[indexPath.section]
                switch section {
                case .main:
                    let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: "\(PhenomenonCell.self)",
                        for: indexPath
                    ) as! PhenomenonCell
                    cell.configure(element: itemIdentifier)
                    return cell
                }
            }
        )
    }
    
    func reloadData() {
        var snapshot = CollectionSnapShot()
        snapshot.appendSections([.main])
        snapshot.appendItems(elements, toSection: .main)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    func settingCollectionLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout(
            sectionProvider: { [weak self] index, environment in
                self?.settingSectionLayout()
            }
        )
        return layout
    }

    func settingSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            ),
            subitems: [item]
        )
    
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging
        
        return section
    }
}
// MARK: - UICollectionViewDelegate, UIScrollViewDelegate
extension PhenomenonViewController: UICollectionViewDelegate, UIScrollViewDelegate {
            
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.updateWeatherEffect(in: view, for: indexPath.item)
        let phenomenon = PhenomenonModel.allCases[indexPath.item]
        presenter?.updateWeatherBackground(for: phenomenon)
        presenter?.updateHeaderBackground(in: headerView, for: phenomenon)
      }
}

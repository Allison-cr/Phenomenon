//
//  PhenomenonCell.swift
//  Phenomenon
//
//  Created by Alexander Suprun on 16.07.2024.
//
import UIKit

final class PhenomenonCell: UICollectionViewCell {
    
    private lazy var imageView : UIImageView = settingImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        settingMainView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(element: PhenomenonModel.PhenomenonDataModel) {
        imageView.image = element.image
    }
}

private extension PhenomenonCell {
    
    func settingMainView() {
        settingLayout()
    }
    
    func settingImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)
        return imageView
    }
    
    func settingLayout() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}

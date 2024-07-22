//
//  RoundedBottomCornersView.swift
//  Phenomenon
//
//  Created by Alexander Suprun on 21.07.2024.
//

import UIKit


class RoundedBottomCornersView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        let cornerRadius: CGFloat = 20.0
        let maskPath = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: [.bottomLeft, .bottomRight],
            cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)
        )
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        layer.mask = maskLayer
    }
}

//
//  PhenomenonPresenter.swift
//  Phenomenon
//
//  Created by Alexander Suprun on 16.07.2024.
//

import UIKit

protocol IPhenomenonPresenter: AnyObject {
    func loadData()
    func updateWeatherEffect(in view: UIView, for pageIndex: Int)
    func updateWeatherBackground(for phenomenon: PhenomenonModel)
    func updateHeaderBackground(in view: UIView, for phenomenon: PhenomenonModel)
}

final class PhenomenonPresenter: IPhenomenonPresenter {

    weak var viewController: IPhenomenonViewController?

    func loadData() {
        let model = MokData().PhenomenonData()
        viewController?.viewReady(model: model)
    }
    
    func updateWeatherEffect(in view: UIView, for pageIndex: Int) {
        view.layer.sublayers?.removeAll(where: { $0 is CAEmitterLayer || $0 is CAShapeLayer })
        
        switch pageIndex {
        case 0:
            setupSnow(in: view)
        case 1:
            setupRain(in: view)
        case 2:
            setupLightning(in: view)
        case 3:
            setupRainbowArcs(in: view)
        default:
            break
        }
    }
    
    func updateWeatherBackground(for phenomenon: PhenomenonModel) {
            let backgroundImage = phenomenon.imageBackgound()
            viewController?.updateBackground(image: backgroundImage)
    }
    
    func updateHeaderBackground(in view: UIView, for phenomenon: PhenomenonModel) {
        view.layer.sublayers?.removeAll { $0 is CAGradientLayer }

        let colors = phenomenon.getColors()
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds 
        gradientLayer.colors = colors
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        let gradientChangeAnimation = CABasicAnimation(keyPath: "colors")
        gradientChangeAnimation.duration = 0.5
        gradientChangeAnimation.toValue = colors
        gradientChangeAnimation.fillMode = .forwards
        gradientChangeAnimation.isRemovedOnCompletion = false
        gradientLayer.add(gradientChangeAnimation, forKey: "colorChange")
        gradientLayer.colors = colors
    }
}

extension PhenomenonPresenter {
    func setupRain(in view: UIView) {
        let snowEmitter = CAEmitterLayer()
        snowEmitter.frame = view.bounds
        view.layer.addSublayer(snowEmitter)
        
        let snowCell = CAEmitterCell()
        let snowflakeImage = UIImage(systemName: "drop.halffull")?.withTintColor(.white).cgImage
        snowCell.contents = snowflakeImage
        snowCell.birthRate = 40
        snowCell.lifetime = 2.3
        snowCell.velocityRange = 50
        snowCell.yAcceleration = 300
        snowCell.scale = 0.3
        snowCell.scaleRange = 0.2
        snowCell.alphaSpeed = -0.3
        
        snowEmitter.emitterPosition = CGPoint(x: view.center.x, y: 0)
        snowEmitter.emitterSize = CGSize(width: view.bounds.width, height: 1)
        snowEmitter.emitterShape = .rectangle
        snowEmitter.emitterCells = [snowCell]
    }
    
    func setupRainbowArcs(in view: UIView) {
        let colors: [UIColor] = [.red, .orange, .yellow, .green, .blue, .systemIndigo, .purple]
        let lineWidth: CGFloat = 10
        let radius: CGFloat = 200
        let center = CGPoint(x: view.center.x, y: view.center.y + 50)
        let startAngle: CGFloat = .pi
        let endAngle: CGFloat = 0
        
        for (index, color) in colors.enumerated() {
            let arcLayer = CAShapeLayer()
            arcLayer.frame = view.bounds
            arcLayer.strokeColor = color.cgColor
            arcLayer.lineWidth = lineWidth
            arcLayer.fillColor = UIColor.clear.cgColor
            
            let currentRadius = radius - CGFloat(index) * lineWidth
            let path = UIBezierPath(arcCenter: center, radius: currentRadius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
            arcLayer.path = path.cgPath
            
            view.layer.addSublayer(arcLayer)
            
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = 0
            animation.toValue = 1
            animation.duration = 4
            animation.repeatCount = .infinity
            animation.autoreverses = true
            animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            
            arcLayer.add(animation, forKey: "arcAnimation")
        }
    }
    
    func setupSnow(in view: UIView) {
        let snowEmitter = CAEmitterLayer()
        snowEmitter.frame = view.bounds
        view.layer.addSublayer(snowEmitter)
        
        let snowCell = CAEmitterCell()
        snowCell.contents = createSnowflakeImage()?.cgImage
        snowCell.birthRate = 40
        snowCell.lifetime = 6
        snowCell.velocityRange = 50
        snowCell.yAcceleration = 70
        snowCell.scale = 0.3
        snowCell.scaleRange = 0.2
        snowCell.alphaSpeed = -0.15
        snowCell.spin = 1
        snowCell.spinRange = 1
        
        snowEmitter.emitterPosition = CGPoint(x: view.center.x, y: 0)
        snowEmitter.emitterSize = CGSize(width: view.bounds.width, height: 1)
        snowEmitter.emitterShape = .rectangle
        snowEmitter.emitterCells = [snowCell]
    }
    
    func createSnowflakeImage() -> UIImage? {
        let size = CGSize(width: 30, height: 30)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let context = UIGraphicsGetCurrentContext()
        
        context?.setStrokeColor(UIColor.white.cgColor)
        context?.setLineWidth(2.0)
        
        context?.move(to: CGPoint(x: size.width / 2, y: 0))
        context?.addLine(to: CGPoint(x: size.width / 2, y: size.height))
        
        context?.move(to: CGPoint(x: 0, y: size.height / 2))
        context?.addLine(to: CGPoint(x: size.width, y: size.height / 2))
        
        context?.move(to: CGPoint(x: size.width * 0.1, y: size.height * 0.1))
        context?.addLine(to: CGPoint(x: size.width * 0.9, y: size.height * 0.9))
        
        context?.move(to: CGPoint(x: size.width * 0.9, y: size.height * 0.1))
        context?.addLine(to: CGPoint(x: size.width * 0.1, y: size.height * 0.9))
        
        context?.strokePath()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    func setupLightning(in view: UIView) {
    let numberOfLightningStrikes = 16
    
    for _ in 0..<numberOfLightningStrikes {
        let lightningLayer = CAShapeLayer()
        lightningLayer.frame = view.bounds
        lightningLayer.strokeColor = UIColor.white.cgColor
        lightningLayer.lineWidth = 2.0
        lightningLayer.fillColor = UIColor.clear.cgColor
        view.layer.addSublayer(lightningLayer)
        
        let path = createLightningPath(for: view)
        lightningLayer.path = path.cgPath
        
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 1
        animation.toValue = 0
        animation.duration = 0.6
        animation.repeatCount = .infinity
        animation.autoreverses = true
        animation.beginTime = CACurrentMediaTime() + CFTimeInterval(arc4random_uniform(3))
        lightningLayer.add(animation, forKey: "lightningAnimation")
    }
}
    
    func createLightningPath(for view: UIView) -> UIBezierPath {
    let path = UIBezierPath()
    
    let startX = CGFloat(arc4random_uniform(UInt32(view.bounds.width)))
    path.move(to: CGPoint(x: startX, y: 0))
    
    let numberOfPoints = 5
    for i in 1...numberOfPoints {
        let x = startX + CGFloat(arc4random_uniform(80)) - 80
        let y = (view.bounds.height / 2 + CGFloat(arc4random_uniform(160))) / CGFloat(numberOfPoints) * CGFloat(i)
        path.addLine(to: CGPoint(x: x, y: y))
    }
    
    return path
}
}

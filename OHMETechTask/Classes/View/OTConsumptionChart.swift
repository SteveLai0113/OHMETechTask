//
//  OTConsumptionChart.swift
//  OHMETechTask
//
//  Created by Steve Lai on 24/9/2021.
//

import UIKit

class OTConsumptionChart: UIView {
    
    public var strokeWidth: CGFloat = 20
    public static var colors: [UIColor] = [
        .blue,.yellow,.red,.brown,.cyan,.green, .systemPink, .orange, .black, .systemBlue, .systemGreen
    ]

    public var dailyRecord: OTDailyConsumptionRecord?{
        didSet{
            // 1. clean up
            self.layer.removeAllAnimations()
            for layer in chartLayers{
                layer.removeFromSuperlayer()
                layer.removeAllAnimations()
            }
            
            // 2. set up
            guard let dailyRecord = dailyRecord else {
                return
            }
//            let sorted = dailyRecord.items.sorted(by: {$0.consumptionWh > $1.consumptionWh}) // sorting in accendingOrder
            guard let sum = dailyRecord.items?.map({$0.consumptionWh}).reduce(0, +) else{
                return
            }
            
            // 3. draw base layer
            drawBasLayer()
            
            // 4a. draw sub layers
            chartLayers.enumerated().forEach { (_, element) in
                element.removeFromSuperlayer()
            }
            chartLayers = []
            
            // 4.b.
            var temp = 0
            dailyRecord.items?.enumerated().forEach{(index, element) in
                let i = index % OTConsumptionChart.colors.count
                let layer = self.layer(percentage: Float(element.consumptionWh + temp) / Float(sum), color: OTConsumptionChart.colors[i])
                temp += element.consumptionWh
                print("STEVE \(Float(temp) / Float(sum))")
                chartLayers.append(layer)

            }
        }
    }
    public var baseLayer = CALayer()
    public var chartLayers = [CALayer]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() -> Void{
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func layer(percentage: Float, color: UIColor) -> CALayer{
        // 1. Prepare config
        let center = CGPoint(x: bounds.width * 0.5, y: bounds.height * 0.5)
        let radius = max(bounds.width * 0.5, bounds.height * 0.5) - strokeWidth
        
        let startAngle: CGFloat = .pi * 0.5
        let endAngle: CGFloat = .pi * 2 * CGFloat(percentage) + startAngle
        
        
        // 2. create path
        let path = UIBezierPath(
            arcCenter: center,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: true)
        
        // 3. create layer
        let layer = CAShapeLayer()
        layer.path = path.cgPath
        layer.strokeColor = color.cgColor
        layer.fillColor = nil
        layer.lineCap = .round
        layer.lineWidth = strokeWidth
        layer.strokeStart = 0
        layer.strokeEnd = 0
        
        // 4. setup animation
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.byValue = 1
        animation.duration = 3
        animation.fillMode  = .forwards
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        animation.isRemovedOnCompletion = false
        
        // 5. apply
        self.layer.insertSublayer(layer, at: 1)
        layer.add(animation, forKey: "drawAnimation")
        return layer
        
        
    }
    
    func drawBasLayer(){
        
        // 0. if base layer, remove
        self.baseLayer.removeFromSuperlayer()
        
        // 1. Prepare config
        let center = CGPoint(x: bounds.width * 0.5, y: bounds.height * 0.5)
        let radius = max(bounds.width * 0.5, bounds.height * 0.5) - strokeWidth
        
        let startAngle: CGFloat = .pi * 0.5
        let endAngle: CGFloat = .pi * 2 + startAngle
        
        
        // 2. create path
        let path = UIBezierPath(
            arcCenter: center,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: true)
        
        // 3. create layer
        let layer = CAShapeLayer()
        layer.path = path.cgPath
        layer.strokeColor = UIColor.lightGray.cgColor
//        layer.shadowColor = UIColor.gray.cgColor
        layer.fillColor = nil
        layer.lineCap = .round
        layer.lineWidth = strokeWidth
        layer.strokeStart = 0
        layer.strokeEnd = 1
        
        self.layer.insertSublayer(layer, at: 0)
        self.baseLayer = layer
        
    }

}

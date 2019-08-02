//
//  AudioVisualizerContainerView.swift
//  Today
//
//  Created by Madison Kaori Shino on 8/1/19.
//  Copyright © 2019 Madi S. All rights reserved.
//

import UIKit

class AudioVisualizerContainerView: UIView {

    //Wave Bar Properties
    var waveBarWidth: CGFloat = 4.0
    var waveBarColor = UIColor.gray.cgColor
    var waveForms: [Int] = Array(repeating: 0, count: 100)
    var waveIsActive = false {
        didSet {
            if waveIsActive == true {
                waveBarColor = UIColor.white.cgColor
            } else {
                waveBarColor = UIColor.gray.cgColor
            }
        }
    }
    
    //Wave Bar View Properties
    override init (frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
    }

    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        self.backgroundColor = UIColor.clear
    }
    
    //Draw Wave Bars
    override func draw(_ rectangle: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.clear(rectangle)
        context.setLineWidth(2)
        context.fill(rectangle)
        context.setFillColor(red: 0, green: 0, blue: 0, alpha: 0)
        context.setStrokeColor(self.waveBarColor)
        
        let width = rectangle.size.width
        let height = rectangle.size.height
        let t = Int(width / waveBarWidth)
        let s = max(0, waveForms.count - t)
        let m = height / 2
        let r = waveBarWidth / 2
        let x = m - r
        var bar: CGFloat = 0
        for i in (s..<waveForms.count) {
            var v = height * CGFloat(waveForms[i]) / 50
            if v > x {
                v = x
            } else if v < 3 {
                v = 3
            }
            
            let oneX = bar * self.waveBarWidth
            var oneY: CGFloat = 0
            let twoX = oneX + r
            var twoY: CGFloat = 0
            var twoS: CGFloat = 0
            var twoE: CGFloat = 0
            var twoC: Bool = false
            let threeX = twoX + r
            let threeY = m
            if i % 2 == 1 {
                oneY = m - v
                twoY = m - v
                twoS = -180.radians
                twoE = 0.radians
                twoC = false
            } else {
                oneY = m + v
                twoY = m + v
                twoS = 180.radians
                twoE = 0.radians
                twoC = true
            }
            
            context.move(to: CGPoint(x: oneX, y: m))
            context.addLine(to: CGPoint(x: oneX, y: oneY))
            context.addArc(center: CGPoint(x: twoX, y: twoY), radius: r, startAngle: twoS, endAngle: twoE, clockwise: twoC)
            context.addLine(to: CGPoint(x: threeX, y: threeY))
            context.strokePath()
            bar += 1
        }
    }
}

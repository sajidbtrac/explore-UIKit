//
//  ViewController.swift
//  BezierCurves
//
//  Created by Sajid Shanta on 10/7/23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var boardingpassView: BoardingPassView!
    @IBOutlet weak var planeView: PlaneView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        boardingpassView.isHidden = true
        planeView.isHidden = true

    }
    @IBAction func showBoardingPass(_ sender: Any) {
        boardingpassView.isHidden.toggle()
    }
    
    @IBAction func showPlane(_ sender: Any) {
        planeView.isHidden.toggle()
    }
}

class BoardingPassView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setupView() {
        let path = getPath()
        
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        shape.lineWidth = 2.0
        shape.strokeColor = UIColor.gray.cgColor
        shape.fillColor = UIColor.clear.cgColor
        
        self.layer.addSublayer(shape)
    }
    
    func getPath() -> UIBezierPath {
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: 50, y: 10))
        
        path.addLine(to: CGPoint(x: 200, y: 10))
        
        path.addArc(withCenter: CGPoint(x: 200, y: 30), radius: 20, startAngle: CGFloat(Double.pi/2 * 3), endAngle: 0, clockwise: true)
        
        path.addLine(to: CGPoint(x: 220, y: 150))
        
        path.addArc(withCenter: CGPoint(x: 220, y: 160), radius: 10, startAngle: CGFloat(Double.pi/2 * 3), endAngle:  CGFloat(Double.pi/2), clockwise: false)
        
        path.addLine(to: CGPoint(x: 220, y: 260))
        
        path.addArc(withCenter: CGPoint(x: 200, y: 260), radius: 20, startAngle: 0, endAngle:  CGFloat(Double.pi/2), clockwise: true)
        
        path.addLine(to: CGPoint(x: 50, y: 280))
        
        path.addArc(withCenter: CGPoint(x: 50, y: 260), radius: 20, startAngle: CGFloat(Double.pi/2), endAngle:  CGFloat(Double.pi), clockwise: true)
        
        path.addLine(to: CGPoint(x: 30, y: 170))
        
        path.addArc(withCenter: CGPoint(x: 30, y: 160), radius: 10, startAngle: CGFloat(Double.pi/2), endAngle:  CGFloat(Double.pi/2 * 3), clockwise: false)
        
        path.addLine(to: CGPoint(x: 30, y: 30))
        
        path.addArc(withCenter: CGPoint(x: 50, y: 30), radius: 20, startAngle: CGFloat(Double.pi), endAngle:  CGFloat(Double.pi/2 * 3), clockwise: true)
        
        path.move(to: CGPoint(x: 40, y: 160))
        path.addLine(to: CGPoint(x: 210, y: 160))
        
        path.close()
        return path
    }
}

class PlaneView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setupView() {
        let path = getPath()
        
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        shape.lineWidth = 2.0
        shape.strokeColor = UIColor.gray.cgColor
        shape.fillColor = UIColor.clear.cgColor
        
        self.layer.addSublayer(shape)
    }
    
    func getPath() -> UIBezierPath {
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: 230, y: 520))
        
        path.addLine(to: CGPoint(x: 70, y: 520))
        path.addLine(to: CGPoint(x: 60, y: 250))
        
        path.addCurve(to: CGPoint(x: 240, y: 250), controlPoint1: CGPoint(x: 80, y: 0), controlPoint2: CGPoint(x: 230, y: 0))
        
        
        path.close()
        return path
    }
}

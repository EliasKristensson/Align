//
//  ViewController.swift
//  Align
//
//  Created by Elias Kristensson on 2020-09-25.
//  Copyright © 2020 Elias Kristensson. All rights reserved.
//

import UIKit

class MyPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    var allViewControllers = [UIViewController]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("here")

        self.dataSource = self

        let vc1: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "DotsID")
        let vc2: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "SectorID")
        allViewControllers = [vc1, vc2]

        self.setViewControllers([vc1], direction: UIPageViewController.NavigationDirection.forward, animated: false)
    }

    // UIPageViewControllerDataSource

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?
    {
        let currentIndex = allViewControllers.firstIndex(of: viewController)!
        return currentIndex == 0 ? nil : allViewControllers[currentIndex-1]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
    {
        let currentIndex = allViewControllers.firstIndex(of: viewController)!
        return currentIndex == allViewControllers.count-1 ? nil : allViewControllers[currentIndex+1]
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int
    {
      return allViewControllers.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int
    {
        return 0
    }
}

//class PieChart: UIView {
//
//    override func draw(_ rect: CGRect) {
//
//        drawSlice(rect: rect, startPercent: 0, endPercent: 33.3, color: .green)
//        drawSlice(rect: rect, startPercent: 33.3, endPercent: 66.6, color: .red)
//        drawSlice(rect: rect, startPercent: 66.6, endPercent: 100, color: .blue)
//    }
//
//    private func drawSlice(rect: CGRect, startPercent: CGFloat, endPercent: CGFloat, color: UIColor) {
//        let center = CGPoint(x: rect.origin.x + rect.width / 2, y: rect.origin.y + rect.height / 2)
//        let radius = min(rect.width, rect.height) / 2
//        let startAngle = startPercent / 100 * CGFloat.pi * 2 - CGFloat.pi
//        let endAngle = endPercent / 100 * CGFloat.pi * 2 - CGFloat.pi
//        let path = UIBezierPath()
//        path.move(to: center)
//        path.addArc(withCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
//        path.close()
//        color.setFill()
//        path.fill()
//    }
//}

//class SectorStar: UIView {
//
//    var spokes = 26
//    var size = 100
//    
//    override func draw(_ rect: CGRect) {
//        
//        for i in stride(from: 0, to: 100, by: 100/spokes) {
//            drawSpoke(rect: rect, startPercent: CGFloat(i), endPercent: CGFloat(i + 50/spokes), color: .black)
//            drawSpoke(rect: rect, startPercent: CGFloat(i + 50/spokes), endPercent: CGFloat(i + 100/spokes), color: .white)
//        }
//    }
//
//    private func drawSpoke(rect: CGRect, startPercent: CGFloat, endPercent: CGFloat, color: UIColor) {
//        let center = CGPoint(x: rect.origin.x + rect.width / 2, y: rect.origin.y + rect.height / 2)
//        let radius = min(rect.width, rect.height) / 2
//        let startAngle = startPercent / 100 * CGFloat.pi * 2 - CGFloat.pi
//        let endAngle = endPercent / 100 * CGFloat.pi * 2 - CGFloat.pi
//        let path = UIBezierPath()
//        path.move(to: center)
//        path.addArc(withCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
//        path.close()
//        color.setFill()
//        path.fill()
//    }
//}

class MainViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    
    var pages = [UIViewController]()
    
    var radiusCirclesDefault = [Float(2), Float(20)]
    var noCirclesDefault = [Float(10), Float(10)]
    
//    let containerView: UIView = {
//        let view = UIView()
//        view.backgroundColor = .clear
//        return view
//    }()
    
    @IBOutlet weak var viewChanger: UISegmentedControl!
    @IBOutlet weak var noCircles: UISlider!
    @IBOutlet weak var radiusCircles: UISlider!
    @IBOutlet weak var invertSwitch: UISwitch!
    
    @IBOutlet weak var containerView: UIView!
    
    
    @IBAction func invertSwitchChanged(_ sender: Any) {
        if invertSwitch.isOn {
            view.backgroundColor = .black
        } else {
            view.backgroundColor = .white
        }
    }
    
    @IBAction func noCirclesDidChange(_ sender: Any) {
        
        switch viewChanger.selectedSegmentIndex {
        case 0:
            drawCircle()
//        case 1:
//            drawSector()
        case 2:
            drawColors()
        default:
            drawCircle()
        }
    }
    
    @IBAction func radiusDidChange(_ sender: Any) {
        switch viewChanger.selectedSegmentIndex {
        case 0:
            drawCircle()
//        case 1:
//            drawSector()
        case 2:
            drawColors()
        default:
            drawCircle()
        }
    }
    
    @IBAction func viewChanged(_ sender: Any) {
        switch viewChanger.selectedSegmentIndex {
        case 0:
            drawCircle()
//        case 1:
//            drawSector()
        case 2:
            drawColors()
        default:
            drawCircle()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.isIdleTimerDisabled = true
        
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
        
        let p1: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "DotsID")
        let p2: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "SectorID")
                
        pages.append(p1)
        pages.append(p2)
        
//        noCircles.value = noCirclesDefault[0]
//        radiusCircles.value = radiusCirclesDefault[0]
//        makeContainerView()
//        drawCircle()
//        setBackground()
    }
    

    func setBackground() {
        if invertSwitch.isOn {
            view.backgroundColor = .black
        } else {
            view.backgroundColor = .white
        }
    }
    
    func makeContainerView() {
        containerView.frame = CGRect(x: 25, y: 100, width: view.frame.width - 50, height: view.frame.height - 250)
        containerView.layer.borderWidth = 2
        view.addSubview(containerView)
    }
    
    private func drawColors() {
        
        let S = 20*CGFloat(radiusCircles.value)
        
        containerView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        
//        let pieChart = PieChart(frame: CGRect(x: containerView.bounds.midX - S/2, y: containerView.bounds.midY - S/2, width: S, height: S))
//        pieChart.backgroundColor = .clear
//        containerView.addSubview(pieChart)
        
    }
    
//    private func drawSector() {
//
//        let S = 20*CGFloat(radiusCircles.value)
//        let N = Int(noCircles.value)
//
//        containerView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
//
//        let pieChart = SectorStar(frame: CGRect(x: containerView.bounds.midX - S/2, y: containerView.bounds.midY - S/2, width: S, height: S))
//        pieChart.spokes = Int(N)
//        pieChart.backgroundColor = .clear
//        containerView.addSubview(pieChart)
//
//    }
    
    private func drawCircle() {
        
        containerView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        
        let r = CGFloat(radiusCircles.value)
        var N = CGFloat(noCircles.value)
        
        if N < 2*r {
            N = 2*r
        }
        
        var c = UIColor.black.cgColor
        if invertSwitch.isOn {
            c = UIColor.white.cgColor
        }
        
        for i in stride(from: containerView.bounds.minX+r, to: containerView.bounds.maxX-r, by: N) {
            for k in stride(from: containerView.bounds.minY+r, to: containerView.bounds.maxY-r, by: N) {
                
                let path = UIBezierPath(ovalIn: CGRect(x: i, y: k, width: r, height: r))
                
                let shapeLayer = CAShapeLayer()
                shapeLayer.path = path.cgPath
                shapeLayer.fillColor = c
                shapeLayer.lineWidth = 0
                
                containerView.layer.addSublayer(shapeLayer)
                
            }
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController)-> UIViewController? {
           
            let cur = pages.firstIndex(of: viewController)!

            // if you prefer to NOT scroll circularly, simply add here:
            // if cur == 0 { return nil }

            var prev = (cur - 1) % pages.count
            if prev < 0 {
                prev = pages.count - 1
            }
            return pages[prev]
        }

        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController)-> UIViewController? {
             
            let cur = pages.firstIndex(of: viewController)!

            // if you prefer to NOT scroll circularly, simply add here:
            // if cur == (pages.count - 1) { return nil }

            let nxt = abs((cur + 1) % pages.count)
            return pages[nxt]
        }

        func presentationIndex(for pageViewController: UIPageViewController)-> Int {
            return pages.count
        }

}


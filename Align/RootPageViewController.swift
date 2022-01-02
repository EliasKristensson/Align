//
//  RootPageViewController.swift
//  Align
//
//  Created by Elias Kristensson on 2020-10-06.
//  Copyright © 2020 Elias Kristensson. All rights reserved.
//

import UIKit

public struct Device {
    var deviceType = "Typical"
    var PPI = 326.0
//    var scale = CGFloat(10)
    var scale1mm = 10.0
    let pixels = UIScreen.screens.first?.currentMode?.size
    var scale = UIScreen.screens.first!.scale
}

public var device = Device()

class RootPageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    lazy var viewControllerList: [UIViewController] = {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc1 = sb.instantiateViewController(identifier: "DotsVC")
        let vc2 = sb.instantiateViewController(identifier: "SectorVC")
        let vc3 = sb.instantiateViewController(identifier: "rgbVC")
        let vc4 = sb.instantiateViewController(identifier: "checkerboardVC")
        let vc5 = sb.instantiateViewController(identifier: "gridVC")
        let vc6 = sb.instantiateViewController(identifier: "whitefieldVC")
        let vc7 = sb.instantiateViewController(identifier: "grayscaleVC")
        let vc8 = sb.instantiateViewController(identifier: "xriteVC")
        let vc9 = sb.instantiateViewController(identifier: "irisVC")
        let vc10 = sb.instantiateViewController(identifier: "rulerVC")
        let vc11 = sb.instantiateViewController(identifier: "sineVC")
        let vc12 = sb.instantiateViewController(identifier: "ballsVC")
        let vc13 = sb.instantiateViewController(identifier: "strobeVC")
        let vc14 = sb.instantiateViewController(identifier: "frameVC")
        let vc15 = sb.instantiateViewController(identifier: "randomVC")

        return [vc1, vc1, vc2, vc3, vc4, vc5, vc6, vc7, vc8, vc9, vc10, vc11, vc12, vc13, vc15]
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.isIdleTimerDisabled = true
        overrideUserInterfaceStyle = .light
        
        self.dataSource = self
                
        if let firstViewController = viewControllerList.first {
            self.setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
        
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let vcIndex = viewControllerList.firstIndex(of: viewController) else {return nil}
        
        let previousIndex = vcIndex - 1
        
        if previousIndex < 0 {
            return viewControllerList[viewControllerList.count-1]
        }
        
        guard viewControllerList.count > previousIndex else {return nil}
        
        return viewControllerList[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let vcIndex = viewControllerList.firstIndex(of: viewController) else {return nil}
        
        let nextIndex = vcIndex + 1
        
        if nextIndex == viewControllerList.count {
            return viewControllerList[0]
        }
        
        guard viewControllerList.count != nextIndex else {return nil}
        
        guard viewControllerList.count > nextIndex else {return nil}
        
        return viewControllerList[nextIndex]
    }

}

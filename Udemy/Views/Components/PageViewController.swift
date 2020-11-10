//
//  PageViewController.swift
//  Udemy
//
//  Created by Phúc Lý on 10/20/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return subViewControllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
            let firstViewControllerIndex = subViewControllers.firstIndex(of: firstViewController) else {
                return 0
            }
        return firstViewControllerIndex
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentIndex: Int = subViewControllers.firstIndex(of: viewController) ?? 0
        return currentIndex <= 0 ? nil : subViewControllers[currentIndex-1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentIndex: Int = subViewControllers.firstIndex(of: viewController) ?? 0
        return currentIndex >= subViewControllers.count - 1 ? nil : subViewControllers[currentIndex+1]
    }
    
    lazy var subViewControllers: [UIViewController] = {
       return [
        UIViewController(),
        UIViewController(),
        UIViewController()
       ]
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self

        
        if let firstViewController = subViewControllers.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    

    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: style, navigationOrientation: navigationOrientation, options: options)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

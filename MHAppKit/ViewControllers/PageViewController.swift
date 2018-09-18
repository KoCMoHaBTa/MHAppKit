//
//  BasePageViewController.swift
//  MHAppKit
//
//  Created by Milen Halachev on 3/21/15.
//  Copyright (c) 2015 Milen Halachev. All rights reserved.
//

import UIKit

open class PageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    @IBInspectable open var initialPageIndex: Int = 0
    @IBInspectable open var endlessPaging: Bool = false

    open override func viewDidLoad() {
        
        super.viewDidLoad()

        self.delegate = self
        self.dataSource = self
        self.reloadData()
    }
    

    //MARK: - UIPageViewControllerDataSource & UIPageViewControllerDelegate
    
    open func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        var index = self.indexOfViewController(viewController)
        
        if index == 0 || index == NSNotFound
        {
            return nil
        }
        
        index -= 1
        return self.viewControllerAtIndex(index)
    }
    
    open func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        var index = self.indexOfViewController(viewController)
        
        if index == NSNotFound
        {
            return nil
        }
        
        index += 1
        
        if index == self.numberOfViewControllers()
        {
            return nil
        }
        
        return self.viewControllerAtIndex(index)
    }
    
    //MARK: - Custom UIPageViewControllerDataSource & UIPageViewControllerDelegate
    
    open func numberOfViewControllers() -> Int {
        
        return 0
    }
    
    open func viewControllerAtIndex(_ index: Int) -> UIViewController? {
        
        return nil
    }
    
    open func indexOfViewController(_ viewController: UIViewController) -> Int {
        
        return NSNotFound
    }
    
    open func reloadData() {
        
        if let initialController = self.viewControllerAtIndex(self.initialPageIndex) {
            
            self.setViewControllers([initialController], direction: .forward, animated: false, completion: nil)
        }
    }
    
    //MARK: - Additional Functionalities
    
    open func selectPage(at index: Int, animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        
        guard
        let current = self.viewControllers?.first,
        let next = self.viewControllerAtIndex(index)
        else {
            
            return
        }
        
        let currentIndex = self.indexOfViewController(current)
        let direction: UIPageViewController.NavigationDirection = currentIndex > index ? .reverse : .forward
        
        self.setViewControllers([next], direction: direction, animated: animated, completion: completion)
    }
}

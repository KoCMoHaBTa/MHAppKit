//
//  BasePageViewController.swift
//  MHAppKit
//
//  Created by Milen Halachev on 3/21/15.
//  Copyright (c) 2015 Milen Halachev. All rights reserved.
//

import UIKit

public class PageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    @IBInspectable public var initialPageIndex: Int = 0
    @IBInspectable public var endlessPaging: Bool = false

    public override func viewDidLoad() {
        
        super.viewDidLoad()

        self.delegate = self
        self.dataSource = self
        self.reloadData()
    }
    

    //MARK: - UIPageViewControllerDataSource & UIPageViewControllerDelegate
    
    public func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        var index = self.indexOfViewController(viewController)
        
        if index == 0 || index == NSNotFound
        {
            return nil
        }
        
        index -= 1
        return self.viewControllerAtIndex(index)
    }
    
    public func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
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
    
    public func numberOfViewControllers() -> Int {
        
        return 0
    }
    
    public func viewControllerAtIndex(index: Int) -> UIViewController? {
        
        return nil
    }
    
    public func indexOfViewController(viewController: UIViewController) -> Int {
        
        return NSNotFound
    }
    
    public func reloadData() {
        
        if let initialController = self.viewControllerAtIndex(self.initialPageIndex) {
            
            self.setViewControllers([initialController], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        }
    }
}

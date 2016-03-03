//
//  StaticTableViewController.swift
//  MHAppKit
//
//  Created by Milen Halachev on 2/12/15.
//  Copyright (c) 2015 Milen Halachev. All rights reserved.
//

import UIKit

public class StaticTableViewController: UITableViewController, UINavigationControllerPreferencesProvider {
    
    public var prefersStatusBarHiddenValue: Bool?

    public override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    public override func prefersStatusBarHidden() -> Bool {
        
        return self.prefersStatusBarHiddenValue ?? super.prefersStatusBarHidden()
    }
    
    //MARK: - UINavigationControllerPreferencesProvider
    
    @IBInspectable public var providesNavigationControllerPreferencesIB: Bool = false
    @IBInspectable public var prefersNavigationBarHiddenIB: Bool = false
    
    public func providesNavigationControllerPreferences() -> Bool {
        
        return self.providesNavigationControllerPreferencesIB
    }
    
    public func prefersNavigationBarHidden() -> Bool {
        
        return self.prefersNavigationBarHiddenIB
    }
    
    //MARK: - Accessory Action
    
    @IBAction public func accessoryViewTouchAction(sender: AnyObject?, event: AnyObject?) {
        
        if let event = event as? UIEvent {
            
            if let touches = event.allTouches() {
                
                if let touch = touches.first {
                    
                    let currentTouchPosition = touch.locationInView(self.tableView)
                    
                    if let indexPath = self.tableView.indexPathForRowAtPoint(currentTouchPosition) {
                        
                        self.tableView(self.tableView, accessoryButtonTappedForRowWithIndexPath: indexPath)
                    }
                }
            }
        }
    }
    
    //MARK: Scrolling
    
    private var animationCompletionBlock: (() -> ())?
    
    public func scrollToRowAtIndexPath(indexPath: NSIndexPath, atScrollPosition scrollPosition: UITableViewScrollPosition, animationCompletionBlock: (() -> ())?) {
        
        let rect = tableView.rectForRowAtIndexPath(indexPath)
        if (rect.origin.y != self.tableView.contentOffset.y + self.tableView.contentInset.top) {
            
            // scrollToRowAtIndexPath will animate and callback scrollViewDidEndScrollingAnimation
            self.animationCompletionBlock = animationCompletionBlock
            self.tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: scrollPosition, animated: true)
            
        } else {
            
            // scrollToRowAtIndexPath will have no effect
            animationCompletionBlock?()
        }
    }
    
    //MARK: - UIScrollViewDelegate
    
    public override func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        
        self.animationCompletionBlock?()
        self.animationCompletionBlock = nil
    }
}

//MARK: - UIRefreshControl

public extension StaticTableViewController {
    
    func shouldRefresh() -> Bool {
        
        return true
    }
    
    func beginRefresh() {
        
        self.refreshControl?.beginRefreshing()
    }
    
    func endRefresh() {
        
        self.refreshControl?.endRefreshing()
    }
    
    //programatic refresh - shouldRefresh -> tableView content inset (animated) -> refreshControlAction
    func performRefresh() {
        
        self.performRefresh(true)
    }
    
    func performRefresh(animated: Bool) {
        
        if self.shouldRefresh() {
            
            let h = self.refreshControl?.frame.size.height ?? 0
            self.tableView.setContentOffset(CGPoint(x: 0, y: -h * 2), animated: animated)
            self.refreshControl?.sendActionsForControlEvents(UIControlEvents.ValueChanged)
        }
    }
    
    @IBAction func refreshControlAction(sender: AnyObject?) {
        
        self.beginRefresh()
        
        self.refreshControlActionWithCompletionBlock { () -> () in
            
            self.endRefresh()
        }
    }
    
    func refreshControlActionWithCompletionBlock(completionBlock: () -> ()) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { () -> Void in
            
            completionBlock()
        }
    }
}

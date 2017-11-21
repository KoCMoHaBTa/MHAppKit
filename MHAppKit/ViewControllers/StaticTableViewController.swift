//
//  StaticTableViewController.swift
//  MHAppKit
//
//  Created by Milen Halachev on 2/12/15.
//  Copyright (c) 2015 Milen Halachev. All rights reserved.
//

import UIKit

open class StaticTableViewController: UITableViewController, UINavigationControllerPreferencesProvider {
    
    open var prefersStatusBarHiddenValue: Bool?

    open override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    open override var prefersStatusBarHidden : Bool {
        
        return self.prefersStatusBarHiddenValue ?? super.prefersStatusBarHidden
    }
    
    //MARK: - UINavigationControllerPreferencesProvider
    
    @IBInspectable open var providesNavigationControllerPreferencesIB: Bool = false
    @IBInspectable open var prefersNavigationBarHiddenIB: Bool = false
    
    open func providesNavigationControllerPreferences() -> Bool {
        
        return self.providesNavigationControllerPreferencesIB
    }
    
    open func prefersNavigationBarHidden() -> Bool {
        
        return self.prefersNavigationBarHiddenIB
    }
    
    //MARK: - Accessory Action
    
    @IBAction open func accessoryViewTouchAction(_ sender: Any?, event: UIEvent) {
        
        if let indexPath = self.tableView.indexPaths(for: event).first {
            
            self.tableView(self.tableView, accessoryButtonTappedForRowWith: indexPath)
        }
    }
    
    //MARK: Scrolling
    
    private var animationCompletionBlock: (() -> ())?
    
    open func scrollToRowAtIndexPath(_ indexPath: IndexPath, atScrollPosition scrollPosition: UITableViewScrollPosition, animationCompletionBlock: (() -> ())?) {
        
        let rect = tableView.rectForRow(at: indexPath)
        if (rect.origin.y != self.tableView.contentOffset.y + self.tableView.contentInset.top) {
            
            // scrollToRowAtIndexPath will animate and callback scrollViewDidEndScrollingAnimation
            self.animationCompletionBlock = animationCompletionBlock
            self.tableView.scrollToRow(at: indexPath, at: scrollPosition, animated: true)
            
        } else {
            
            // scrollToRowAtIndexPath will have no effect
            animationCompletionBlock?()
        }
    }
    
    //MARK: - UIScrollViewDelegate
    
    open override func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        
        self.animationCompletionBlock?()
        self.animationCompletionBlock = nil
    }
    
    //MARK: - UIRefreshControl
 
    open func shouldRefresh() -> Bool {
        
        return true
    }
    
    open func beginRefresh() {
        
        self.refreshControl?.beginRefreshing()
    }
    
    open func endRefresh() {
        
        self.refreshControl?.endRefreshing()
    }
    
    //programatic refresh - shouldRefresh -> tableView content inset (animated) -> refreshControlAction
    open func performRefresh() {
        
        self.performRefresh(true)
    }
    
    open func performRefresh(_ animated: Bool) {
        
        if self.shouldRefresh() {
            
            let h = self.refreshControl?.frame.size.height ?? 0
            self.tableView.setContentOffset(CGPoint(x: 0, y: -h * 2), animated: animated)
            self.refreshControl?.sendActions(for: UIControlEvents.valueChanged)
        }
    }
    
    @IBAction open func refreshControlAction(_ sender: Any?) {
        
        self.beginRefresh()
        
        self.refreshControlActionWithCompletionBlock { () -> () in
            
            self.endRefresh()
        }
    }
    
    open func refreshControlActionWithCompletionBlock(_ completionBlock: @escaping () -> ()) {
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(1 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) { () -> Void in
            
            completionBlock()
        }
    }
}

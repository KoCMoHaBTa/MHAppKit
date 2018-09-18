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
    
    open func scrollToRowAtIndexPath(_ indexPath: IndexPath, atScrollPosition scrollPosition: UITableView.ScrollPosition, animationCompletionBlock: (() -> ())?) {
        
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
    
    open func beginRefresh() {
        
        self.refreshControl?.beginRefreshing()
    }
    
    open func endRefresh() {
        
        self.refreshControl?.endRefreshing()
    }
    
    open func showRefreshControl(animated: Bool) {
        
        guard self.refreshControl?.isRefreshing == false else {
            
            return
        }
        
        let h = self.refreshControl?.frame.size.height ?? 0
        var offset = self.tableView.contentOffset
        offset.y = -h - self.topLayoutGuide.length
        self.tableView.setContentOffset(offset, animated: animated)
    }
    
    //programatic refresh - shouldRefresh -> tableView content inset (animated) -> refreshControlAction
    @IBAction open func performRefresh() {
        
        self.performRefresh(animated: true)
    }
    
    open func performRefresh(animated: Bool) {
        
        self.showRefreshControl(animated: animated)
        self.refreshControl?.sendActions(for: .valueChanged)
    }
    
    ///Performs a refresh with custom action
    open func performRefresh(animated: Bool, action: @escaping (_ completion: @escaping () -> Void) -> Void) {
        
        self.showRefreshControl(animated: animated)
        self.beginRefresh()
        
        action {
            
            self.endRefresh()
        }
    }
    
    ///Assign this action to the refresh control. If you do so, the `refreshControlActionWithCompletionBlock` method will be called automatically
    @IBAction open func refreshControlAction(_ sender: Any?) {
        
        self.beginRefresh()
        
        self.refreshControlActionWithCompletionBlock { () -> () in
            
            self.endRefresh()
        }
    }
    
    ///Override this in order to implement the refersh control action
    open func refreshControlActionWithCompletionBlock(_ completionBlock: @escaping () -> ()) {
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(1 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) { () -> Void in
            
            completionBlock()
        }
    }
}

//
//  CollectionViewController.swift
//  MHAppKit
//
//  Created by Milen Halachev on 3/21/15.
//  Copyright (c) 2015 Milen Halachev. All rights reserved.
//

import UIKit

public class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    public var prefersStatusBarHiddenValue: Bool?
    
    public override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if self.enableRefreshing() {
            
            let refreshControl = UIRefreshControl()
            self.collectionView?.addSubview(refreshControl)
            self.collectionView?.alwaysBounceVertical = true
            refreshControl.addTarget(self, action: #selector(CollectionViewController.refreshControlAction(_:)), forControlEvents: UIControlEvents.ValueChanged)
            self.refreshControl = refreshControl
        }
    }
    
    public override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        
        self.collectionViewFlowLayout?.invalidateLayout()
    }
    
    public override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        
        coordinator.animateAlongsideTransition({ (ctx) -> Void in
            
            self.collectionViewFlowLayout?.invalidateLayout()
            
        }) { (ctx) -> Void in
            
            
        }
    }
    
    public override func prefersStatusBarHidden() -> Bool {
        
        return self.prefersStatusBarHiddenValue ?? super.prefersStatusBarHidden()
    }
    
    public var collectionViewFlowLayout: UICollectionViewFlowLayout? {
        
        return self.collectionViewLayout as? UICollectionViewFlowLayout
    }

    // MARK: - UICollectionViewDataSource & UICollectionViewDelegate

    public override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        var cell = self.collectionView(collectionView, loadCellForItemAtIndexPath: indexPath)
        cell.contentView.frame = cell.bounds
        
        cell = self.collectionView(collectionView, configureCell: cell, forItemAtIndexPath: indexPath)
    
        return cell
    }
    
    //MARK: - Custom UICollectionViewDataSource & UICollectionViewDelegate
    
    public func collectionView(collectionView: UICollectionView, loadCellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cellID = "CellID"
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellID, forIndexPath: indexPath)
        
        return cell
    }
    
    public func collectionView(collectionView: UICollectionView, configureCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        return cell
    }
    
    //square
    public func numberOfItems() -> UInt {
        
        return 0
    }
    
    public func numberOfRows() -> UInt {
        
        return 0
    }
    
    public func numberOfColumns() -> UInt {
        
        return 0
    }
    
    //Indicate wherever to make items with equal width and height. Called when only either numberOfRows or numberOfColumns is specified. Defaults to YES
    public func shouldMakeSquareItems() -> Bool {
        
        return true
    }
    
    //MARK: - UICollectionViewDelegateFlowLayout
    
    public func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let containerSize = collectionView.bounds.size;
//    containerSize = [self getRotatedViewSize:collectionView];
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            
            let CalculateLength = { (elementsCount: UInt, maxLength: CGFloat, padding: CGFloat) -> CGFloat in
                
                var length = maxLength
                length -= (padding * CGFloat(elementsCount - 1))
                length /= CGFloat(elementsCount)
                
                return length
            }
            
            let padding = layout.minimumInteritemSpacing
            
            //equal square items
            
            let numberOfItems = self.numberOfItems()
            if numberOfItems > 0
            {
                //calculate max length based on the layout
                var maxLength: CGFloat = 0
                switch layout.scrollDirection
                {
                    case UICollectionViewScrollDirection.Horizontal:
                        maxLength = containerSize.height
                        
                    case UICollectionViewScrollDirection.Vertical:
                        maxLength = containerSize.width
                    
//                    default:
//                        maxLength = 0
                }
                
                if (maxLength > 0)
                {
                    let length = CalculateLength(numberOfItems, maxLength, padding)
                    let size = CGSizeMake(length, length)
//                NSLog(@"Size: %@; View: %@", NSStringFromCGSize(size), NSStringFromCGRect(collectionView.bounds));
                    return size
                }
            }
            
            //rectangle items
            var width: CGFloat = 0
            var height: CGFloat = 0
            
            let numberOfColumns = self.numberOfColumns()
            if numberOfColumns > 0
            {
                let maxLength = containerSize.width
                let length = CalculateLength(numberOfColumns, maxLength, padding)
                width = length
            }
            
            let numberOfRows = self.numberOfRows()
            if numberOfRows > 0
            {
                let maxLength = containerSize.height
                let length = CalculateLength(numberOfRows, maxLength, padding)
                height = length
            }
            
            //check if souhld make square items
            if width != 0 && height == 0 && self.shouldMakeSquareItems()
            {
                height = width
            }
            
            if width == 0 && height != 0 && self.shouldMakeSquareItems()
            {
                width = height
            }
            
            //check and set default values
            if width == 0
            {
                width = layout.itemSize.width
            }
            
            if height == 0
            {
                height = layout.itemSize.height
            }
            
            
            let size = CGSizeMake(width, height)
//        NSLog(@"Size: %@; View: %@", NSStringFromCGSize(size), NSStringFromCGRect(collectionView.bounds));
            return size
        }
        
        
        let size = CGSizeMake(10, 10)
//    NSLog(@"Size: %@; View: %@", NSStringFromCGSize(size), NSStringFromCGRect(collectionView.bounds));
        return size
    }


    //MARK: - UIRefreshControl
    
    @IBOutlet public var refreshControl: UIRefreshControl?
    
    //false by default
    public func enableRefreshing() -> Bool {
        
        return false
    }
    
    //used by performRefresh
    public func shouldRefresh() -> Bool {
        
        return false
    }
    
    public func beginRefresh() {
        
        self.refreshControl?.beginRefreshing()
//        self.searchDisplayController?.searchBar.userInteractionEnabled = false
    }
    
    public func endRefresh() {
        
        self.refreshControl?.endRefreshing()
//        self.searchDisplayController?.searchBar.userInteractionEnabled = true
    }

    //calls beginRefresh -> refreshControlActionWithCompletionBlock -> endRefresh
    @IBAction public func refreshControlAction(sender: AnyObject) {
        
        self.beginRefresh()
        
        self.refreshControlActionWithCompletionBlock { [weak self] () -> Void in
            
            self?.endRefresh()
        }
    }
    
    //its bets to override this method and perform refresh process in it. Call completion block when done.
    public func refreshControlActionWithCompletionBlock(completionBlock: () -> Void) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (Int64)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), completionBlock)
    }
    
    //programatic refresh - shouldRefresh -> content inset (animated) -> refreshControlAction
    public func performRefresh(animated: Bool = true) {
        
        if self.shouldRefresh() && self.refreshControl != nil {
            
            self.collectionView?.setContentOffset(CGPoint(x: 0, y: -self.refreshControl!.frame.size.height*2), animated: animated)
            self.refreshControl?.sendActionsForControlEvents(UIControlEvents.ValueChanged)
        }
    }
}




//
//  CollectionViewController.swift
//  MHAppKit
//
//  Created by Milen Halachev on 3/21/15.
//  Copyright (c) 2015 Milen Halachev. All rights reserved.
//

import UIKit

open class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    open var prefersStatusBarHiddenValue: Bool?
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if self.enableRefreshing() {
            
            let refreshControl = UIRefreshControl()
            self.collectionView?.addSubview(refreshControl)
            self.collectionView?.alwaysBounceVertical = true
            refreshControl.addTarget(self, action: #selector(CollectionViewController.refreshControlAction(_:)), for: UIControlEvents.valueChanged)
            self.refreshControl = refreshControl
        }
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        self.collectionViewFlowLayout?.invalidateLayout()
    }
    
    open override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: { (ctx) -> Void in
            
            self.collectionViewFlowLayout?.invalidateLayout()
            
        }) { (ctx) -> Void in
            
            
        }
    }
    
    open override var prefersStatusBarHidden : Bool {
        
        return self.prefersStatusBarHiddenValue ?? super.prefersStatusBarHidden
    }
    
    open var collectionViewFlowLayout: UICollectionViewFlowLayout? {
        
        return self.collectionViewLayout as? UICollectionViewFlowLayout
    }

    // MARK: - UICollectionViewDataSource & UICollectionViewDelegate

    open override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = self.collectionView(collectionView, loadCellForItemAtIndexPath: indexPath)
        cell.contentView.frame = cell.bounds
        
        cell = self.collectionView(collectionView, configureCell: cell, forItemAtIndexPath: indexPath)
    
        return cell
    }
    
    //MARK: - Custom UICollectionViewDataSource & UICollectionViewDelegate
    
    open func collectionView(_ collectionView: UICollectionView, loadCellForItemAtIndexPath indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellID = "CellID"
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        
        return cell
    }
    
    open func collectionView(_ collectionView: UICollectionView, configureCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: IndexPath) -> UICollectionViewCell {
        
        return cell
    }
    
    //square
    open func numberOfItems() -> UInt {
        
        return 0
    }
    
    open func numberOfRows() -> UInt {
        
        return 0
    }
    
    open func numberOfColumns() -> UInt {
        
        return 0
    }
    
    //Indicate wherever to make items with equal width and height. Called when only either numberOfRows or numberOfColumns is specified. Defaults to YES
    open func shouldMakeSquareItems() -> Bool {
        
        return true
    }
    
    //MARK: - UICollectionViewDelegateFlowLayout
    
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
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
                    case UICollectionViewScrollDirection.horizontal:
                        maxLength = containerSize.height
                        
                    case UICollectionViewScrollDirection.vertical:
                        maxLength = containerSize.width
                    
//                    default:
//                        maxLength = 0
                }
                
                if (maxLength > 0)
                {
                    let length = CalculateLength(numberOfItems, maxLength, padding)
                    let size = CGSize(width: length, height: length)
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
            
            
            let size = CGSize(width: width, height: height)
//        NSLog(@"Size: %@; View: %@", NSStringFromCGSize(size), NSStringFromCGRect(collectionView.bounds));
            return size
        }
        
        
        let size = CGSize(width: 10, height: 10)
//    NSLog(@"Size: %@; View: %@", NSStringFromCGSize(size), NSStringFromCGRect(collectionView.bounds));
        return size
    }


    //MARK: - UIRefreshControl
    
    @IBOutlet open var refreshControl: UIRefreshControl?
    
    //false by default
    open func enableRefreshing() -> Bool {
        
        return false
    }
    
    //used by performRefresh
    open func shouldRefresh() -> Bool {
        
        return false
    }
    
    open func beginRefresh() {
        
        self.refreshControl?.beginRefreshing()
//        self.searchDisplayController?.searchBar.userInteractionEnabled = false
    }
    
    open func endRefresh() {
        
        self.refreshControl?.endRefreshing()
//        self.searchDisplayController?.searchBar.userInteractionEnabled = true
    }

    //calls beginRefresh -> refreshControlActionWithCompletionBlock -> endRefresh
    @IBAction open func refreshControlAction(_ sender: AnyObject) {
        
        self.beginRefresh()
        
        self.refreshControlActionWithCompletionBlock { [weak self] () -> Void in
            
            self?.endRefresh()
        }
    }
    
    //its bets to override this method and perform refresh process in it. Call completion block when done.
    open func refreshControlActionWithCompletionBlock(_ completionBlock: @escaping () -> Void) {
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double((Int64)(1 * NSEC_PER_SEC)) / Double(NSEC_PER_SEC), execute: completionBlock)
    }
    
    //programatic refresh - shouldRefresh -> content inset (animated) -> refreshControlAction
    open func performRefresh(_ animated: Bool = true) {
        
        if self.shouldRefresh() && self.refreshControl != nil {
            
            self.collectionView?.setContentOffset(CGPoint(x: 0, y: -self.refreshControl!.frame.size.height*2), animated: animated)
            self.refreshControl?.sendActions(for: UIControlEvents.valueChanged)
        }
    }
}




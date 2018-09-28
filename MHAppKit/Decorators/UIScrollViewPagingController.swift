//
//  UIScrollViewPagingController.swift
//  MHAppKit
//
//  Created by Milen Halachev on 10.09.18.
//  Copyright © 2018 Milen Halachev. All rights reserved.
//

import Foundation
import UIKit

///A type that can adjust the paging behaviour of a given scroll view by allowing to set custom page size.
open class UIScrollViewPagingController: NSObject, UIScrollViewDelegate {
    
    ///The target scroll view, which paging should be adjusted with custom page size
    public let scrollView: UIScrollView
    
    ///A closure, called when the user swipes to a different page. Not called when the page is changed programatically.
    open var pageChangeHandler: ((Page) -> Void)?
    
    ///The pageable scroll view, used to setup the desired paging behaviour. The technique used is swapping of the panGestureRecognizer, as per few WWDC sessions.
    ///https://developer.apple.com/videos/play/wwdc2014/235/
    ///https://developer.apple.com/videos/play/wwdc2012/223/
    open private(set) lazy var pageableScrollView: UIScrollView = { [unowned self] in
        
        let pageableScrollView = UIScrollView()
        pageableScrollView.delegate = self
        pageableScrollView.isPagingEnabled = true
        
        self.scrollView.panGestureRecognizer.isEnabled = false
        self.scrollView.addGestureRecognizer(pageableScrollView.panGestureRecognizer)
        
        return pageableScrollView
    }()
    
    ///An observer for the target scroll view content size
    private lazy var scrollViewContentSizeObserver = self.scrollView.observe(\.contentSize) { [weak self] (scrollView, change) in
        
        //update the content size
        self?.pageableScrollView.contentSize = scrollView.contentSize
        
        //NOTE: I'm not sure if this should be here - if not substracting the difference - and extra space exist that creates an additional page
        //So basically if there is difference between the size of the scrollView and the pageableScrollView - the difference has to be accounted into the contentSize of pageableScrollView
        //The time will show, when this find more usage, if this is implementation detail of the first use case or its a general issue that is correctly implemented here
        self?.pageableScrollView.contentSize.width -= scrollView.bounds.size.width - (self?.pageableScrollView.bounds.size.width ?? 0)
        self?.pageableScrollView.contentSize.height -= scrollView.bounds.size.height - (self?.pageableScrollView.bounds.size.height ?? 0)
    }
    
    /**
     Creates an instnace of the receiver.
     
     - parameter scrollView: The target scroll view for which to modeify the paging behaviour.
     - parameter pageSize: The desired page size.
     - paramter pageChangeHandler: An optional handler to receive page change events.
     */
    public init(scrollView: UIScrollView, pageSize: CGSize, pageChangeHandler: ((Page) -> Void)? = nil) {
        
        self.scrollView = scrollView
        self.pageChangeHandler = pageChangeHandler
        
        super.init()
        
        self.pageSize = pageSize
        _ = self.scrollViewContentSizeObserver
    }
    
    ///Current page size.
    open var pageSize: CGSize {
        
        get {
            
            return self.pageableScrollView.bounds.size
        }
        
        set {
            
            self.pageableScrollView.bounds.size = newValue
        }
    }
    
    ///Current page index state.
    private var _page: Page = Page(horizontal: 0, vertical: 0)
    
    ///Current page index.
    open var page: Page {
        
        get {
            
            return _page
        }
        
        set {
            
            self.setPage(newValue, animated: false)
        }
    }
    
    ///Sets the current page index.
    open func setPage(_ page: Page, animated: Bool) {
        
        _page = page
        
        self.pageableScrollView.contentOffset.x = CGFloat(page.horizontal) * self.pageableScrollView.bounds.size.width
        self.pageableScrollView.contentOffset.y = CGFloat(page.vertical) * self.pageableScrollView.bounds.size.height
        
        self.scrollView.setContentOffset(self.pageableScrollView.contentOffset, animated: animated)
    }
    
    //this is kept for historcal purpose, in case we need it
    open var pageBasedOnCurrentContentOffset: Page {
        
        return self.pageFor(size: self.pageableScrollView.bounds.size, contentOffset: self.pageableScrollView.contentOffset)
    }
    
    /**
     Calcualtes a page index.
     
     - parameter size: The size of the page.
     - parameter contentOffset: The offset of the content.
     - returns: A page index.
     */
    open func pageFor(size: CGSize, contentOffset: CGPoint) -> Page {
        
        let horizontal = size.width == 0 ? 0 : Int((contentOffset.x / size.width).rounded())
        let vertical = size.height == 0 ? 0 : Int((contentOffset.y / size.height).rounded())
        
        return Page(horizontal: horizontal, vertical: vertical)
    }
    
    deinit {
        
        self.scrollView.removeGestureRecognizer(self.pageableScrollView.panGestureRecognizer)
        self.scrollView.panGestureRecognizer.isEnabled = true
        
        if #available(iOS 11.0, *) {
            
        }
        else {
            
            //NOTE: On iOS 10 and below, swift key-value observers are not automatically invalidated upon deallocation, so we have to explicitly invalidate it in order to prevent the app from crashing
            self.scrollViewContentSizeObserver.invalidate()
        }
    }
    
    //MARK: - UIScrollViewDelegate
    
    open func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        self.scrollView.contentOffset = scrollView.contentOffset
    }
    
    open func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let targetPage = self.pageFor(size: scrollView.bounds.size, contentOffset: targetContentOffset.pointee)
        
        if targetPage != self.page {
            
            _page = targetPage
            self.pageChangeHandler?(targetPage)
        }
    }
}

extension UIScrollViewPagingController {
    
    ///A type that represents a horizontal and vertical page index
    public struct Page: Equatable {
        
        public var horizontal: Int
        public var vertical: Int
        
        public init(horizontal: Int, vertical: Int) {
            
            self.horizontal = horizontal
            self.vertical = vertical
        }
    }
}


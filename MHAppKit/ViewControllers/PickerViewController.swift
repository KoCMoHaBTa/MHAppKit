//
//  PickerViewController.swift
//  MHAppKit
//
//  Created by Milen Halachev on 7/12/15.
//  Copyright (c) 2015 Milen Halachev. All rights reserved.
//

import UIKit

public protocol PickerViewControllerItem {
    
    var title: String {get}
}

extension String: PickerViewControllerItem {
    
    public var title: String {
        
        return self
    }
}

extension UInt: PickerViewControllerItem {
    
    public var title: String {
        
        return "\(self)"
    }
}

extension Int: PickerViewControllerItem {
    
    public var title: String {
        
        return "\(self)"
    }
}

extension Double: PickerViewControllerItem {
    
    public var title: String {
        
        return "\(self)"
    }
}

extension Float: PickerViewControllerItem {
    
    public var title: String {
        
        return "\(self)"
    }
}

public class PickerViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    public typealias Item = PickerViewControllerItem
    
    public var items: [Item] = []
    public var selectedItemIndex: Int = 0
    private static let backgroundViewTag = "PickerViewController.backgroundViewTag".hashValue
    
    @IBOutlet public var pickerView: UIPickerView!
    @IBOutlet public var cancelBarButton: UIBarButtonItem!
    @IBOutlet public var titleBarButton: UIBarButtonItem!
    @IBOutlet public var doneBarButton: UIBarButtonItem!
    
    public var didSelectItem: ((controller: PickerViewController, item: PickerViewController.Item?, index: Int?) -> Void)?
    
    //MARK: - Init
    
    public convenience init(items: [Item], selectedItemIndex: Int) {

        self.init(nibName: "PickerViewController", bundle: NSBundle(forClass: PickerViewController.self))
        
        self.items = items
        self.selectedItemIndex = selectedItemIndex
    }
    
    public required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        self.modalPresentationStyle = .OverCurrentContext
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.modalPresentationStyle = .OverCurrentContext
    }

    //MARK: UIViewController
    
    public override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.cancelBarButton.title = NSLocalizedString("Cancel", comment: "Picker View Cancel Button");
        self.titleBarButton.title = self.title
        self.doneBarButton.title = NSLocalizedString("Done", comment: "Picker View Done Button");
        
        if let color = self.titleBarButton.tintColor {
            
            self.titleBarButton.setTitleTextAttributes([NSForegroundColorAttributeName: color], forState: UIControlState.Normal)
            self.titleBarButton.setTitleTextAttributes([NSForegroundColorAttributeName: color], forState: UIControlState.Disabled)
        }
        
        self.pickerView.selectRow(self.selectedItemIndex, inComponent: 0, animated: false)
    }
    
    public override func preferredStatusBarStyle() -> UIStatusBarStyle {
        
        return .LightContent
    }
    
    public override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        self.transitionCoordinator()?.animateAlongsideTransition({ (ctx) -> Void in
            
            let container = ctx.containerView()
            
            let backgroundView = UIView(frame: container.bounds)
            backgroundView.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
            backgroundView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.3)
            backgroundView.tag = self.dynamicType.backgroundViewTag
            container.insertSubview(backgroundView, atIndex: 0)
            
            backgroundView.alpha = 0
            backgroundView.alpha = 1
            
        }, completion: { (ctx) -> Void in
            
        })
    }
    
    public override func viewWillDisappear(animated: Bool) {
        
        super.viewWillDisappear(animated)
        
        self.transitionCoordinator()?.animateAlongsideTransition({ (ctx) -> Void in
            
            let container = ctx.containerView()
            let backgroundView = container.viewWithTag(self.dynamicType.backgroundViewTag)
            backgroundView?.alpha = 0
            
        }, completion: { (ctx) -> Void in
            
            let container = ctx.containerView()
            let backgroundView = container.viewWithTag(self.dynamicType.backgroundViewTag)
            backgroundView?.removeFromSuperview()
        })
    }
    
    //MARK: - Actions
    
    @IBAction public func cancelAction(sender: AnyObject) {
        
        self.didSelectItem?(controller: self, item: nil, index: nil)
    }
    
    @IBAction public func doneAction(sender: AnyObject) {
        
        let index = self.pickerView.selectedRowInComponent(0)
        let item = self.items[index]
        self.didSelectItem?(controller: self, item: item, index: index)
    }
    
    //MARK: - UIPickerViewDataSource and UIPickerViewDelegate
    
    public func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    public func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return self.items.count
    }
    
    public func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let item = self.items[row]
        return item.title
    }
}

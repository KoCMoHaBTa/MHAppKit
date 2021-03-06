//
//  PickerViewController.swift
//  MHAppKit
//
//  Created by Milen Halachev on 7/12/15.
//  Copyright (c) 2015 Milen Halachev. All rights reserved.
//

#if canImport(UIKit) && !os(tvOS) && !os(watchOS)
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

open class PickerViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    public typealias Item = PickerViewControllerItem
    
    open var items: [Item] = []
    open var selectedItemIndex: Int = 0
    private static let backgroundViewTag = "PickerViewController.backgroundViewTag".hashValue
    
    @IBOutlet open var pickerView: UIPickerView!
    @IBOutlet open var navigationBar: UINavigationBar!
    @IBOutlet open var cancelBarButton: UIBarButtonItem!
    @IBOutlet open var doneBarButton: UIBarButtonItem!
    
    open var didSelectItem: ((_ controller: PickerViewController, _ item: PickerViewController.Item?, _ index: Int?) -> Void)?
    open var viewDidLoadConfiguration: ((PickerViewController) -> Void)?
    
    //MARK: - Init
    
    convenience init() {
        
        self.init(nibName: "PickerViewController", bundle: Bundle(for: type(of: self)))
    }
    
    public convenience init(items: [Item], selectedItemIndex: Int) {

        self.init()
        
        self.items = items
        self.selectedItemIndex = selectedItemIndex
    }
    
    public required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        self.modalPresentationStyle = .overCurrentContext
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.modalPresentationStyle = .overCurrentContext
    }

    //MARK: UIViewController
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.cancelBarButton.title = NSLocalizedString("Cancel", comment: "");
        self.navigationBar.items?.first?.title = self.title
        self.doneBarButton.title = NSLocalizedString("Done", comment: "");        
        self.pickerView.selectRow(self.selectedItemIndex, inComponent: 0, animated: false)
        
        self.viewDidLoadConfiguration?(self)
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cancelAction(_:))))
    }
    
    open override var preferredStatusBarStyle : UIStatusBarStyle {
        
        return .lightContent
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        self.transitionCoordinator?.animate(alongsideTransition: { (ctx) -> Void in
            
            let container = ctx.containerView
            
            let backgroundView = UIView(frame: container.bounds)
            backgroundView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
            backgroundView.tag = Self.backgroundViewTag
            container.insertSubview(backgroundView, at: 0)
            
            backgroundView.alpha = 0
            backgroundView.alpha = 1
            
        }, completion: { (ctx) -> Void in
            
        })
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        
        self.transitionCoordinator?.animate(alongsideTransition: { (ctx) -> Void in
            
            let container = ctx.containerView
            let backgroundView = container.viewWithTag(Self.backgroundViewTag)
            backgroundView?.alpha = 0
            
        }, completion: { (ctx) -> Void in
            
            let container = ctx.containerView
            let backgroundView = container.viewWithTag(Self.backgroundViewTag)
            backgroundView?.removeFromSuperview()
        })
    }
    
    //MARK: - Actions
    
    @IBAction open func cancelAction(_ sender: Any?) {
        
        self.didSelectItem?(self, nil, nil) ?? self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction open func doneAction(_ sender: Any?) {
        
        let index = self.pickerView.selectedRow(inComponent: 0)
        let item = self.items[index]
        self.didSelectItem?(self, item, index) ?? self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - UIPickerViewDataSource and UIPickerViewDelegate
    
    open func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    open func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return self.items.count
    }
    
    open func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let item = self.items[row]
        return item.title
    }
}
#endif

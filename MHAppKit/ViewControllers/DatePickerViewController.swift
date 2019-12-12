//
//  DatePickerViewController.swift
//  MHAppKit
//
//  Created by Milen Halachev on 15.08.18.
//  Copyright © 2018 Milen Halachev. All rights reserved.
//

#if canImport(UIKit) && !os(watchOS)
import Foundation
import UIKit

@available(tvOS, unavailable)
open class DatePickerViewController: UIViewController {
    
    private static let backgroundViewTag = "DatePickerViewController.backgroundViewTag".hashValue
    
    @IBOutlet open var datePickerView: UIDatePicker!
    @IBOutlet open var navigationBar: UINavigationBar!
    @IBOutlet open var cancelBarButton: UIBarButtonItem!
    @IBOutlet open var doneBarButton: UIBarButtonItem!
    
    open var didSelectDate: ((_ controller: DatePickerViewController, _ date: Date?) -> Void)?
    open var viewDidLoadConfiguration: ((DatePickerViewController) -> Void)?
    
    //MARK: - Init

    public required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        self.modalPresentationStyle = .overCurrentContext
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.modalPresentationStyle = .overCurrentContext
    }
    
    convenience init() {
        
        self.init(nibName: "DatePickerViewController", bundle: Bundle(for: type(of: self)))
    }
    
    //MARK: UIViewController
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.cancelBarButton.title = NSLocalizedString("Cancel", comment: "");
        self.navigationBar.items?.first?.title = self.title
        self.doneBarButton.title = NSLocalizedString("Done", comment: "");
        
        self.viewDidLoadConfiguration?(self)
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cancelAction(_:))))
    }
    
    #if !os(tvOS)
    open override var preferredStatusBarStyle : UIStatusBarStyle {
        
        return .lightContent
    }
    #endif
    
    open override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        self.transitionCoordinator?.animate(alongsideTransition: { (ctx) -> Void in
            
            let container = ctx.containerView
            
            let backgroundView = UIView(frame: container.bounds)
            backgroundView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
            backgroundView.tag = type(of: self).backgroundViewTag
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
        
        self.didSelectDate?(self, nil) ?? self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction open func doneAction(_ sender: Any?) {
        
        self.didSelectDate?(self, self.datePickerView.date) ?? self.dismiss(animated: true, completion: nil)
    }
}
#endif

//
//  TextView.swift
//  MHAppKit
//
//  Created by Milen Halachev on 3/3/16.
//  Copyright (c) 2016 Milen Halachev. All rights reserved.
//

import UIKit

///A UITextView subclass with some useful additions
@IBDesignable open class TextView: UITextView {
    
    ///Controls whenever to remove the text padding of the receiver
    @IBInspectable open var removePadding: Bool = false {
        
        didSet {
            
            if self.removePadding {
                
                self.textContainer.lineFragmentPadding = 0
                self.textContainerInset = .zero
            }
            else {
                
                self.textContainer.lineFragmentPadding = 5.0
                self.textContainerInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
            }
        }
    }
    
    ///Controls the left padding of the receiver's text
    @IBInspectable open var leftPadding: CGFloat = 0 {
        
        didSet {
            
            self.textContainerInset.left = self.leftPadding
        }
    }
    
    //MARK: - Auto Size
    
    ///Constrols whenever to autoSize the receier. Default to `false`. If set to `true` - the receiver's intrinsicContentSize will be set to the content size
    @IBInspectable open var autoSize: Bool = false
    
    //MARK: - Placeholder
    //https://github.com/soffes/SAMTextView/blob/master/SAMTextView/SAMTextView.m
    
    @IBInspectable open var placeholder: String? {
        
        get {
            
            return self.attributedPlaceholder?.string
        }
        
        set {
            
            if let newValue = newValue {
                
                if newValue == self.attributedPlaceholder?.string {
                    
                    return
                }
                
                var attributes: [String: Any] = [:]
                
                if self.isFirstResponder {
                    
                    for (k, v) in self.typingAttributes {
                        
                        attributes.updateValue(v, forKey: k)
                    }
                    
                } else {
                    
                    attributes[NSFontAttributeName] = self.font
                    attributes[NSForegroundColorAttributeName] = UIColor(white: 0.702, alpha: 1.0)
                    
                    if self.textAlignment != .left {
                        
                        let paragraph = NSMutableParagraphStyle()
                        paragraph.alignment = self.textAlignment
                        attributes[NSParagraphStyleAttributeName] = paragraph
                    }
                }
                
                self.attributedPlaceholder = NSAttributedString(string: newValue, attributes: attributes)
            }
        }
    }
    
    private var _attributedPlaceholder: NSAttributedString?
    open var attributedPlaceholder: NSAttributedString? {
        
        get {
            
            return _attributedPlaceholder
        }
        
        set {
            
            if _attributedPlaceholder == nil && newValue == nil {
                
                return
            }
            
            if let _attributedPlaceholder = _attributedPlaceholder {
                
                if let newValue = newValue {
                    
                    if _attributedPlaceholder.isEqual(to: newValue) {
                        
                        return
                    }
                }
            }
            
            _attributedPlaceholder = newValue
            self.setNeedsDisplay()
        }
    }
    
    open func placeholderRectForBounds(_ bounds: CGRect) -> CGRect {
        
        var rect = UIEdgeInsetsInsetRect(bounds, self.contentInset);
        
        rect = UIEdgeInsetsInsetRect(rect, self.textContainerInset)
        
        let padding = self.textContainer.lineFragmentPadding
        rect.origin.x += padding
        rect.size.width -= padding * 2.0
        
        return rect
    }
    
    //MARK: - UITextView
    
    open override var text: String! {
        
        didSet {
            
            self.setNeedsDisplay()
        }
    }
    
    open override var font: UIFont? {
        
        didSet {
            
            self.setNeedsDisplay()
        }
    }
    
    open override var textAlignment: NSTextAlignment {
        
        get {
            
            return super.textAlignment
        }

        set {
            
            super.textAlignment = newValue
            self.setNeedsDisplay()
        }
    }
    
    open override var attributedText: NSAttributedString! {
        
        didSet {
            
            self.setNeedsDisplay()
        }
    }
    
    open override func insertText(_ text: String) {
        
        super.insertText(text)
        self.setNeedsDisplay()
    }
    
    //MARK: - UIScrollView
    
    open override var contentInset: UIEdgeInsets {
        
        get {
            
            return super.contentInset
        }
        
        set {
            
            super.contentInset = newValue
            self.setNeedsDisplay()
        }
    }
    
    //MARK: - NSObject
    
    deinit {
        
        NotificationCenter.default.removeObserver(self, name: .UITextViewTextDidChange, object: self)
    }
    
    //MARK: - UIView

//    public required init(coder aDecoder: NSCoder) {
//        
//        super.init(coder: aDecoder)
//        self.setupNotifications()
//    }
//    
//    public override init(frame: CGRect) {
//        
//        super.init(frame: frame)
//        self.setupNotifications()
//    }
    
    open override func awakeFromNib() {
        
        super.awakeFromNib()
        
        self.setupNotifications()
    }
    
    open override func draw(_ rect: CGRect) {
        
        super.draw(rect)
        
        // Draw placeholder if necessary
        if let text = self.text {
            
            if let attributedPlaceholder = self.attributedPlaceholder {
                
                if text.isEmpty {
                    
                    let placeholderRect = self.placeholderRectForBounds(self.bounds)
                    attributedPlaceholder.draw(in: placeholderRect)
                }
            }
        }
    }
    
    open override func layoutSubviews() {
        
        super.layoutSubviews()
        
        if self.autoSize {
            
            if !self.bounds.size.equalTo(self.intrinsicContentSize) {
                
                self.invalidateIntrinsicContentSize()
            }
        }
        
        if self.attributedPlaceholder != nil && (self.text?.isEmpty ?? false) {
            
            self.setNeedsDisplay()
        }
    }
    
    open override var intrinsicContentSize: CGSize {
        
        if self.autoSize {
            
            var intrinsicContentSize = self.layoutManager.usedRect(for: self.textContainer).size //self.contentSize
            
            
            /*
            // iOS 7.0+
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f) {
            intrinsicContentSize.width += (self.textContainerInset.left + self.textContainerInset.right ) / 2.0f;
            intrinsicContentSize.height += (self.textContainerInset.top + self.textContainerInset.bottom) / 2.0f;
            }
            */
            
            if self.text == nil || self.text.isEmpty {
                
                return .zero
            }
            
            intrinsicContentSize.height += self.textContainerInset.top
            intrinsicContentSize.height += self.textContainerInset.bottom
            intrinsicContentSize.width += self.textContainerInset.left
            intrinsicContentSize.width += self.textContainerInset.right
            
            return intrinsicContentSize
        }
        
        return super.intrinsicContentSize
    }
    
    //MARK: - Notifications
    
    private func setupNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(TextView.receivedTextDidChangeNotification(_:)), name: .UITextViewTextDidChange, object: self)
    }
    
    open func receivedTextDidChangeNotification(_ noitification: Notification) {
        
        self.setNeedsDisplay()
    }
    
    //MARK: - Interface Builder
    
    open override func prepareForInterfaceBuilder() {
        
        super.prepareForInterfaceBuilder()
        
        self.setNeedsDisplay()
    }
}

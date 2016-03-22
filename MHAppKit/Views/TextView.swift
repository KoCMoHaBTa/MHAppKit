//
//  TextView.swift
//  MHAppKit
//
//  Created by Milen Halachev on 3/3/16.
//  Copyright (c) 2016 Milen Halachev. All rights reserved.
//

import UIKit

@IBDesignable public class TextView: UITextView {
    
    @IBInspectable public var removePadding: Bool = false {
        
        didSet {
            
            if self.removePadding {
                
                self.textContainer.lineFragmentPadding = 0
                self.textContainerInset = UIEdgeInsetsZero
            }
            else {
                
                self.textContainer.lineFragmentPadding = 5.0
                self.textContainerInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
            }
        }
    }
    
    @IBInspectable public var leftPadding: CGFloat = 0 {
        
        didSet {
            
            self.textContainerInset.left = self.leftPadding
        }
    }
    
    //MARK: - Auto Size
    
    @IBInspectable public var autoSize: Bool = false
    
    //MARK: - Placeholder
//    https://github.com/soffes/SAMTextView/blob/master/SAMTextView/SAMTextView.m
    
    @IBInspectable public var placeholder: String? {
        
        get {
            
            return self.attributedPlaceholder?.string
        }
        
        set {
            
            if let newValue = newValue {
                
                if newValue == self.attributedPlaceholder?.string {
                    
                    return
                }
                
                var attributes: [String: AnyObject] = [:]
                
                if self.isFirstResponder() {
                    
                    for (k, v) in self.typingAttributes {
                        
                        attributes.updateValue(v, forKey: k)
                    }
                    
                } else {
                    
                    attributes[NSFontAttributeName] = self.font
                    attributes[NSForegroundColorAttributeName] = UIColor(white: 0.702, alpha: 1.0)
                    
                    if self.textAlignment != NSTextAlignment.Left {
                        
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
    public var attributedPlaceholder: NSAttributedString? {
        
        get {
            
            return _attributedPlaceholder
        }
        
        set {
            
            if _attributedPlaceholder == nil && newValue == nil {
                
                return
            }
            
            if let _attributedPlaceholder = _attributedPlaceholder {
                
                if let newValue = newValue {
                    
                    if _attributedPlaceholder.isEqualToAttributedString(newValue) {
                        
                        return
                    }
                }
            }
            
            _attributedPlaceholder = newValue
            self.setNeedsDisplay()
        }
    }
    
    public func placeholderRectForBounds(bounds: CGRect) -> CGRect {
        
        var rect = UIEdgeInsetsInsetRect(bounds, self.contentInset);
        
        rect = UIEdgeInsetsInsetRect(rect, self.textContainerInset)
        
        let padding = self.textContainer.lineFragmentPadding
        rect.origin.x += padding
        rect.size.width -= padding * 2.0
        
        return rect
    }
    
    //MARK: - UITextView
    
    public override var text: String! {
        
        didSet {
            
            self.setNeedsDisplay()
        }
    }
    
    public override var font: UIFont? {
        
        didSet {
            
            self.setNeedsDisplay()
        }
    }
    
    public override var textAlignment: NSTextAlignment {
        
        get {
            
            return super.textAlignment
        }

        set {
            
            super.textAlignment = newValue
            self.setNeedsDisplay()
        }
    }
    
    public override var attributedText: NSAttributedString! {
        
        didSet {
            
            self.setNeedsDisplay()
        }
    }
    
    public override func insertText(text: String) {
        
        super.insertText(text)
        self.setNeedsDisplay()
    }
    
    //MARK: - UIScrollView
    
    public override var contentInset: UIEdgeInsets {
        
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
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UITextViewTextDidChangeNotification, object: self)
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
    
    public override func awakeFromNib() {
        
        super.awakeFromNib()
        
        self.setupNotifications()
    }
    
    public override func drawRect(rect: CGRect) {
        
        super.drawRect(rect)
        
        // Draw placeholder if necessary
        if let text = self.text {
            
            if let attributedPlaceholder = self.attributedPlaceholder {
                
                if text.isEmpty {
                    
                    let placeholderRect = self.placeholderRectForBounds(self.bounds)
                    attributedPlaceholder.drawInRect(placeholderRect)
                }
            }
        }
    }
    
    public override func layoutSubviews() {
        
        super.layoutSubviews()
        
        if self.autoSize {
            
            if !CGSizeEqualToSize(self.bounds.size, self.intrinsicContentSize()) {
                
                self.invalidateIntrinsicContentSize()
            }
        }
        
        if self.attributedPlaceholder != nil && (self.text?.isEmpty ?? false) {
            
            self.setNeedsDisplay()
        }
    }
    
    public override func intrinsicContentSize() -> CGSize {
        
        if self.autoSize {
            
            var intrinsicContentSize = self.layoutManager.usedRectForTextContainer(self.textContainer).size //self.contentSize
            
            
            /*
            // iOS 7.0+
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f) {
            intrinsicContentSize.width += (self.textContainerInset.left + self.textContainerInset.right ) / 2.0f;
            intrinsicContentSize.height += (self.textContainerInset.top + self.textContainerInset.bottom) / 2.0f;
            }
            */
            
            if self.text == nil || self.text.isEmpty {
                
                return CGSizeZero
            }
            
            intrinsicContentSize.height += self.textContainerInset.top
            intrinsicContentSize.height += self.textContainerInset.bottom
            intrinsicContentSize.width += self.textContainerInset.left
            intrinsicContentSize.width += self.textContainerInset.right
            
            return intrinsicContentSize
        }
        
        return super.intrinsicContentSize()
    }
    
    //MARK: - Notifications
    
    private func setupNotifications() {
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(TextView.receivedTextDidChangeNotification(_:)), name: UITextViewTextDidChangeNotification, object: self)
    }
    
    public func receivedTextDidChangeNotification(noitification: NSNotification) {
        
        self.setNeedsDisplay()
    }
    
    //MARK: - Interface Builder
    
    public override func prepareForInterfaceBuilder() {
        
        super.prepareForInterfaceBuilder()
        
        self.setNeedsDisplay()
    }
}

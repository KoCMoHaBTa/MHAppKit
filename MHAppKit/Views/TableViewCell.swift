//
//  TableViewCell.swift
//  MHAppKit
//
//  Created by Milen Halachev on 3/3/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation
import UIKit

public class TableViewCell: UITableViewCell {
    
    private var _customImageView: UIImageView?
    @IBOutlet public override var imageView: UIImageView? {
        
        get {
            
            return _customImageView
        }
        
        set {
            
            _customImageView = newValue
        }
    }
    
    private var _customTextLabel: UILabel?
    @IBOutlet public override var textLabel: UILabel? {
        
        get {
            
            return _customTextLabel
        }
        
        set {
            
            _customTextLabel = newValue
        }
    }
    
    private var _customDetailTextLabel: UILabel?
    @IBOutlet public override var detailTextLabel: UILabel? {
        
        get {
            
            return _customDetailTextLabel
        }
        
        set {
            
            _customDetailTextLabel = newValue
        }
    }
    
    //MARK: - Selection
    
    @IBInspectable public var showCheckMarkUponSelection: Bool = false
    @IBInspectable public var showImageUponSelection: Bool = false
    @IBInspectable public var selectionImage: UIImage?
    @IBInspectable public var unselectionImage: UIImage?
    
    @IBOutlet public var selectionImageView: UIImageView?
    
    public override func setSelected(selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
        
        if self.showCheckMarkUponSelection {
            
            self.accessoryType = selected ? UITableViewCellAccessoryType.Checkmark : UITableViewCellAccessoryType.None;
        }
        
        if self.showImageUponSelection {
            
            let imageView = self.selectionImageView ?? self.imageView
            let image = selected ? self.selectionImage : self.unselectionImage
            imageView?.image = image
        }
    }
    
    //MARK: - Background Nib Loading
    
    @IBInspectable public var backgroundViewNibName: String?
    @IBInspectable public var backgroundViewNibBundleIdentifier: String?
    
    public var backgroundViewNibBundle: NSBundle {

        if let nibBundleIdentifier = self.backgroundViewNibBundleIdentifier {
            
            return NSBundle(identifier: nibBundleIdentifier)!
        }
        
        return NSBundle.mainBundle()
    }
    
    @IBInspectable public var selectedBackgroundViewNibName: String?
    @IBInspectable public var selectedBackgroundViewNibBundleIdentifier: String?
    
    public var selectedBackgroundViewNibBundle: NSBundle {
        
        if let nibBundleIdentifier = self.selectedBackgroundViewNibBundleIdentifier {
            
            return NSBundle(identifier: nibBundleIdentifier)!
        }
        
        return NSBundle.mainBundle()
    }
    
    //MARK: - Other
    
    ///can be used to override the background color at runtime
    @IBInspectable public var runtimeBackgroundColor: UIColor? = nil
    
    //MARK: - Setup
    
    public override func awakeFromNib() {
        
        super.awakeFromNib()
        
        if let backgroundViewNibName = self.backgroundViewNibName {
            
            NSBundle.mainBundle().loadNibNamed(backgroundViewNibName, owner: self, options: nil)
        }
        
        if let selectedBackgroundViewNibName = self.selectedBackgroundViewNibName {
            
            NSBundle.mainBundle().loadNibNamed(selectedBackgroundViewNibName, owner: self, options: nil)
        }
        
        if let color = self.runtimeBackgroundColor {
            
            self.backgroundColor = color
        }
    }
    
    public override func prepareForInterfaceBuilder() {
        
        super.prepareForInterfaceBuilder()
    }
}
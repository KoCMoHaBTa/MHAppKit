//
//  TableViewCell.swift
//  MHAppKit
//
//  Created by Milen Halachev on 3/3/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation
import UIKit

open class TableViewCell: UITableViewCell {
    
    private var _customImageView: UIImageView?
    @IBOutlet open override var imageView: UIImageView? {
        
        get {
            
            return _customImageView
        }
        
        set {
            
            _customImageView = newValue
        }
    }
    
    private var _customTextLabel: UILabel?
    @IBOutlet open override var textLabel: UILabel? {
        
        get {
            
            return _customTextLabel
        }
        
        set {
            
            _customTextLabel = newValue
        }
    }
    
    private var _customDetailTextLabel: UILabel?
    @IBOutlet open override var detailTextLabel: UILabel? {
        
        get {
            
            return _customDetailTextLabel
        }
        
        set {
            
            _customDetailTextLabel = newValue
        }
    }
    
    //MARK: - Selection
    
    @IBInspectable open var showCheckMarkUponSelection: Bool = false
    @IBInspectable open var showImageUponSelection: Bool = false
    @IBInspectable open var selectionImage: UIImage?
    @IBInspectable open var unselectionImage: UIImage?
    
    @IBOutlet open var selectionImageView: UIImageView?
    
    open override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
        
        if self.showCheckMarkUponSelection {
            
            self.accessoryType = selected ? .checkmark : .none;
        }
        
        if self.showImageUponSelection {
            
            let imageView = self.selectionImageView ?? self.imageView
            let image = selected ? self.selectionImage : self.unselectionImage
            imageView?.image = image
        }
    }
    
    //MARK: - Background Nib Loading
    
    @IBInspectable open var backgroundViewNibName: String?
    @IBInspectable open var backgroundViewNibBundleIdentifier: String?
    
    open var backgroundViewNibBundle: Bundle {

        if let nibBundleIdentifier = self.backgroundViewNibBundleIdentifier {
            
            return Bundle(identifier: nibBundleIdentifier)!
        }
        
        return Bundle.main
    }
    
    @IBInspectable open var selectedBackgroundViewNibName: String?
    @IBInspectable open var selectedBackgroundViewNibBundleIdentifier: String?
    
    open var selectedBackgroundViewNibBundle: Bundle {
        
        if let nibBundleIdentifier = self.selectedBackgroundViewNibBundleIdentifier {
            
            return Bundle(identifier: nibBundleIdentifier)!
        }
        
        return Bundle.main
    }
    
    //MARK: - Other
    
    ///can be used to override the background color at runtime
    @IBInspectable open var runtimeBackgroundColor: UIColor? = nil
    
    //MARK: - Setup
    
    open override func awakeFromNib() {
        
        super.awakeFromNib()
        
        if let backgroundViewNibName = self.backgroundViewNibName {
            
            Bundle.main.loadNibNamed(backgroundViewNibName, owner: self, options: nil)
        }
        
        if let selectedBackgroundViewNibName = self.selectedBackgroundViewNibName {
            
            Bundle.main.loadNibNamed(selectedBackgroundViewNibName, owner: self, options: nil)
        }
        
        if let color = self.runtimeBackgroundColor {
            
            self.backgroundColor = color
        }
    }
    
    open override func prepareForInterfaceBuilder() {
        
        super.prepareForInterfaceBuilder()
    }
    
    //MARK: - Separator
    
    ///if you need a reference to your custom separator view :)
    @IBOutlet open weak var separatorView: UIView?
}

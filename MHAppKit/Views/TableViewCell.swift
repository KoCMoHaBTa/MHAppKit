//
//  TableViewCell.swift
//  MHAppKit
//
//  Created by Milen Halachev on 3/3/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation
import UIKit

///A TableViewCell subclass with some useful additions
open class TableViewCell: UITableViewCell {
    
    //Overrides the UITableViewCell's imageView in order to provide IBOutlet reference.
    private var _customImageView: UIImageView?
    @IBOutlet open override var imageView: UIImageView? {
        
        get {
            
            return _customImageView
        }
        
        set {
            
            _customImageView = newValue
        }
    }
    
    //Overrides the UITableViewCell's textLabel in order to provide IBOutlet reference.
    private var _customTextLabel: UILabel?
    @IBOutlet open override var textLabel: UILabel? {
        
        get {
            
            return _customTextLabel
        }
        
        set {
            
            _customTextLabel = newValue
        }
    }
    
    //Overrides the UITableViewCell's detailTextLabel in order to provide IBOutlet reference.
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
    
    ///Controls whenever the standart checkmar accessory will be shown upon cell selection. Default to `false`.
    @IBInspectable open var showCheckMarkUponSelection: Bool = false
    
    ///Controls whenever the provided `selectionImage` and `unselectionImage` be shown upon cell selection and deselection. Default to `false`.
    @IBInspectable open var showImageUponSelection: Bool = false
    
    ///The image to be shown upon cell selection. You must set `showImageUponSelection` to `true` in order for this to work.
    @IBInspectable open var selectionImage: UIImage?
    
    ///The image to be shown unpo cell deselection. You must set `showImageUponSelection` to `true` in order for this to work.
    @IBInspectable open var unselectionImage: UIImage?
    
    ///If set, the selection/deselection image will be shown into this image view. Otherwise into the  cell's image view.
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
    
    ///Sets a nib name to be loaded and its contents to be used as background to the receiver.
    @IBInspectable open var backgroundViewNibName: String?
    
    ///Specify a nib bundle identifier from which the background nib to be loaded.
    @IBInspectable open var backgroundViewNibBundleIdentifier: String?
    
    ///The bundle from which the backround nib to be loaded, if backgroundViewNibBundleIdentifier is provided. Default to main bundle.
    open var backgroundViewNibBundle: Bundle {

        if let nibBundleIdentifier = self.backgroundViewNibBundleIdentifier {
            
            return Bundle(identifier: nibBundleIdentifier)!
        }
        
        return Bundle.main
    }
    
    ///Sets a nib name to be loaded and its contents to be used as selected background to the receiver.
    @IBInspectable open var selectedBackgroundViewNibName: String?
    
    ///Specify a nib bundle identifier from which the selected background nib to be loaded.
    @IBInspectable open var selectedBackgroundViewNibBundleIdentifier: String?
    
    ///The bundle from which the selected backround nib to be loaded, if selectedBackgroundViewNibBundleIdentifier is provided. Default to main bundle.
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

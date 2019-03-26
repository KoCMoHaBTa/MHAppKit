//
//  UIControlGroup.swift
//  MHAppKit
//
//  Created by Milen Halachev on 7/25/17.
//  Copyright © 2017 Milen Halachev. All rights reserved.
//

import Foundation
import UIKit

open class UIControlGroup: NSObject {
    
    public enum StateAction: Int {
        
        case none = 0
        case enabled        //change the enbled value
        case hidden         //change the hidden value
        case highlighted    //change the highlited value
    }
    
    ///The controls that forms the group
    @IBOutlet open var controls: [UIControl] = [] {
        
        didSet {
            
            oldValue.forEach { (control) in
                
                control.removeTarget(self, action: #selector(type(of: self).controlAction(_:)), for: .touchUpInside)
            }
            
            let controls = self.controls.sorted { (c1, c2) -> Bool in
                
                return c1.tag > c2.tag
            }
            
            for control in controls {
                
                control.addTarget(self, action: #selector(type(of: self).controlAction(_:)), for: .touchUpInside)
            }
            
            self.controls = controls
        }
    }
    
    ///Controls whenver multiple selection is allowed. Default to false
    @IBInspectable open var allowMultipleSelection: Bool = false
    
    ///Controls whenever no selection is allowed
    @IBInspectable open var allowNoneSelection: Bool = false
    
    ///Assign to a control which action will deselect all controls in the group
    @IBOutlet open var deselectAllControl: UIControl? {
        
        didSet {
            
            oldValue?.removeTarget(self, action: #selector(type(of: self).deselectAllControls), for: .touchUpInside)
            self.deselectAllControl?.addTarget(self, action: #selector(type(of: self).deselectAllControls), for: .touchUpInside)
        }
    }
    
    ///The state action assigned to all deselected controls
    open var deselectAllControlStateAction: StateAction = .none
    
    ///Assign to a control which action will select all controls in the group
    @IBOutlet open var selectAllControl: UIControl? {
        
        didSet {
            
            oldValue?.removeTarget(self, action: #selector(type(of: self).selectAllControls), for: .touchUpInside)
            self.selectAllControl?.addTarget(self, action: #selector(type(of: self).selectAllControls), for: .touchUpInside)
        }
    }
    
    ///The state action assigned to all selected controls
    open var selectAllControlStateAction: StateAction = .none
    
    //MARK: - Callbacks
    
    open var didSelectControlHandler: ((UIControl) -> Void)?
    open var didDeselectControlHandler: ((UIControl) -> Void)?
    open var didChangeControlState: ((UIControl, StateAction) -> Void)?
    
    //MARK: - Behaviour
    
    ///Toggle the selection state of the control at the given index
    open func toggleControl(at index: Int) {
        
        self.controlAction(self.controls[index])
    }
    
    ///Deselect all controls. This works only if `allowNoneSelection` is `true`
    @IBAction open func deselectAllControls() {
        
        if self.allowNoneSelection {
            
            for control in self.selectedControls {
                
                self.controlAction(control)
            }
        }
    }
    
    ///Select all controls. This only works if `allowMultipleSelection` is `true`
    @IBAction open func selectAllControls() {
        
        if self.allowMultipleSelection {
            
            for control in self.deselectedControls {
                
                self.controlAction(control)
            }
        }
    }
    
    //MARK: - State
    
    ///The selected controls from the group
    open var selectedControls: [UIControl] {
        
        return self.controls.filter({ (control) -> Bool in
            
            return control.isSelected == true
        })
    }
    
    ///The indexes of the selected controls from the group
    open var selectedControlIndexes: [Int] {
        
        return self.selectedControls.map({ self.controls.firstIndex(of: $0)! })
    }
    
    ///The deselected controls from the group
    open var deselectedControls: [UIControl] {
        
        return self.controls.filter({ (control) -> Bool in
            
            return control.isSelected == false
        })
    }
    
    ///The indexes of the deselected controls from the group
    open var deselectedControlIndexes: [Int] {
        
        return self.deselectedControls.map({ self.controls.firstIndex(of: $0)! })
    }
    
    //MARK: - Private
    
    @IBAction private func controlAction(_ sender: UIControl) {
        
        if !self.allowNoneSelection && self.selectedControls.count == 1 && sender.isSelected {
            
            return
        }
        
        sender.isSelected = !sender.isSelected
        
        if !self.allowMultipleSelection {
            
            var controlToDeselect: UIControl?
            for control in self.controls {
                
                if control.isSelected && !control.isEqual(sender) {
                    
                    controlToDeselect = control
                    break
                }
            }
            
            controlToDeselect?.isSelected = false
            
            if let controlToDeselect = controlToDeselect {
                
                self.didDeselectControlHandler?(controlToDeselect)
            }
        }
        
        self.updateStateActionsWithSelection(sender.isSelected)
        
        sender.isSelected ? self.didSelectControlHandler?(sender) : self.didDeselectControlHandler?(sender)
    }
    
    private func updateStateActionsWithSelection(_ isSelected: Bool) {
        
        let selectedControlsCount = self.selectedControls.count
        let controlsCount = self.controls.count
        
        //none are selected
        if selectedControlsCount == 0
        {
            self.update(control: self.deselectAllControl, with: self.deselectAllControlStateAction)
        }
        
        //all are selected
        if selectedControlsCount == controlsCount
        {
            self.update(control: self.selectAllControl, with: self.selectAllControlStateAction)
        }
        
        //any first selected - from none to one
        if selectedControlsCount == 1 && isSelected
        {
            self.update(control: self.deselectAllControl, with: self.deselectAllControlStateAction)
        }
        
        //any first deselected - from none to one
        if selectedControlsCount == controlsCount - 1 && !isSelected
        {
            self.update(control: self.selectAllControl, with: self.selectAllControlStateAction)
        }
    }
    
    private func update(control: UIControl?, with stateAction: StateAction) {
        
        guard let control = control else {
            
            return
        }
        
        switch stateAction
        {
            case .enabled:
                control.isEnabled = !control.isEnabled
                
            case .hidden:
                control.isHidden = !control.isHidden
                
            case .highlighted:
                control.isHighlighted = !control.isHighlighted
                
            case .none:
                break
        }
        
        self.didChangeControlState?(control, stateAction)
    }
}

//
//  DynamicTableViewController.swift
//  MHAppKit
//
//  Created by Milen Halachev on 2/12/15.
//  Copyright (c) 2015 Milen Halachev. All rights reserved.
//

import UIKit

public class DynamicTableViewController: StaticTableViewController {

    @IBInspectable public var automaticallyBindTableViewCellAccessoryControlToDelegate: Bool = false
    
    public override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    //MARK: - UITableViewDataSource & UITableViewDelegate
    
    public override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = self.tableView(tableView, loadCellForRowAtIndexPath: indexPath)
        cell = self.tableView(tableView, configureCell: cell, forRowAtIndexPath: indexPath)
        
        if self.automaticallyBindTableViewCellAccessoryControlToDelegate && cell.accessoryView != nil && cell.accessoryView is UIControl
        {
            if let accessoryView = cell.accessoryView as? UIControl {
                
                accessoryView.addTarget(self, action: Selector("accessoryViewTouchAction:event:"), forControlEvents: UIControlEvents.TouchUpInside)
            }
        }
        
        return cell
    }
    
    public override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    //MARK: - Custom UITableViewDataSource & UITableViewDelegate
    
    public func tableView(tableView: UITableView, loadCellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellID = "CellID"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellID)
        
        return cell!
    }
    
    public func tableView(tableView: UITableView, configureCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        return cell
    }
}

//
//  DynamicTableViewController.swift
//  MHAppKit
//
//  Created by Milen Halachev on 2/12/15.
//  Copyright (c) 2015 Milen Halachev. All rights reserved.
//

import UIKit

open class DynamicTableViewController: StaticTableViewController {

    @IBInspectable open var automaticallyBindTableViewCellAccessoryControlToDelegate: Bool = false
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    //MARK: - UITableViewDataSource & UITableViewDelegate
    
    open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = self.tableView(tableView, loadCellForRowAtIndexPath: indexPath)
        cell = self.tableView(tableView, configureCell: cell, forRowAtIndexPath: indexPath)
        
        if self.automaticallyBindTableViewCellAccessoryControlToDelegate && cell.accessoryView != nil && cell.accessoryView is UIControl
        {
            if let accessoryView = cell.accessoryView as? UIControl {
                
                accessoryView.addTarget(self, action: #selector(StaticTableViewController.accessoryViewTouchAction(_:event:)), for: UIControlEvents.touchUpInside)
            }
        }
        
        return cell
    }
    
    open override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Custom UITableViewDataSource & UITableViewDelegate
    
    open func tableView(_ tableView: UITableView, loadCellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        
        let cellID = "CellID"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        
        return cell!
    }
    
    open func tableView(_ tableView: UITableView, configureCell cell: UITableViewCell, forRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        
        return cell
    }
}

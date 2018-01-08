//
//  TestStaticTableViewController.swift
//  MHAppKitTestsHost
//
//  Created by Milen Halachev on 8.01.18.
//  Copyright © 2018 Milen Halachev. All rights reserved.
//

import Foundation
import MHAppKit

class RefreshStaticTableViewController: StaticTableViewController {
    
    @IBAction func customRefresh() {
        
        self.performRefresh(animated: true) { (completion) in
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + (2 * Double(NSEC_PER_SEC)) / Double(NSEC_PER_SEC)) {
                
                completion()
            }
        }
    }
    
    override func refreshControlActionWithCompletionBlock(_ completionBlock: @escaping () -> ()) {
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + (2 * Double(NSEC_PER_SEC)) / Double(NSEC_PER_SEC)) {
            
            completionBlock()
        }
    }
}

class StandartRefreshUponViewDidLoadTestStaticTableViewController: RefreshStaticTableViewController {
 
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.performRefresh(animated: false) { (completion) in
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + (2 * Double(NSEC_PER_SEC)) / Double(NSEC_PER_SEC)) {
                
                completion()
            }
        }
    }
}

class CustomRefreshUponViewDidLoadTestStaticTableViewController: RefreshStaticTableViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.performRefresh(animated: false)
    }
}

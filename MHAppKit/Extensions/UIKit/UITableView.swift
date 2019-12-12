//
//  UITableView.swift
//  MHAppKit
//
//  Created by Milen Halachev on 21.11.17.
//  Copyright © 2017 Milen Halachev. All rights reserved.
//

#if canImport(UIKit) && !os(watchOS)
import Foundation
import UIKit

extension UITableView {
    
    public func indexPaths(for event: UIEvent) -> [IndexPath] {
        
        return event.allTouches?.reduce([], { (result, touch) -> [IndexPath] in
            
            guard let indexPath = self.indexPathForRow(at: touch.location(in: self)) else {
                
                return result
            }
            
            return result + indexPath
            
        }) ?? []
    }
}

extension UITableView {
    
    /**
     Lookup the indexpath of a view withing the receivers view hierarchy.
     - parameter view: The view for which to lookup for index path.
     - returns: The index path of the view or nil if the view could not be found withing the receiver.
     */
    ///
    public func indexPath(of view: UIView) -> IndexPath? {
        
        guard let cell: UITableViewCell = view.superviewOfType() else {
            
            return nil
        }
        
        return self.indexPath(for: cell)
    }
    
    /**
     Lookup for a view of a given type at a given indexPath.
     - parameter indexPath: The indexPath at which to lookup.
     - returns: The view found or nil.
     */
    public func view<View: UIView>(at indexPath: IndexPath) -> View? {
        
        guard let cell = self.cellForRow(at: indexPath) else {
            
            return nil
        }
        
        return cell.subviewOfType()
    }
    
    /**
     Determines whenever a given view is the last one if its kind within the receier's view hierachy, based on its index path.
     - parameter view: The view for which to check.
     - returns: `true` if the view is the last one, otherwise `false`.
     */
    public func isViewLast<View: UIView>(_ view: View) -> Bool {
        
        return self.nextView(after: view) == nil
    }
    
    /**
     Lookup for a view, logically positioned after a given one of the same type.
     - parameter view: The view after which to look for another of the same type.
     - returns: A view of the same type, positioned logically on a greater index path.
     */
    public func nextView<View: UIView>(after view: View) -> View? {
        
        guard let indexPath = self.indexPath(of: view) else {
            
            return nil
        }
        
        return self.nextView(after: indexPath)
    }
    
    public func nextView<View: UIView>(after indexPath: IndexPath) -> View? {
        
        //take the next index path
        guard let nextIndexPath = self.nextIndexPath(after: indexPath) else {
            
            //there is no next index path
            return nil
        }
        
        return self.view(at: nextIndexPath) ?? self.nextView(after: nextIndexPath)
    }
}

extension UITableView {
    
    /**
     Lookup the next index path after a given index path.
     - parameter indexPath: The index path after which to look.
     - returns: An index path, logically higher or nil if such cannot be found.
     */
    public func nextIndexPath(after indexPath: IndexPath) -> IndexPath? {
        
        //check if the row is the last one
        let lastRow = self.numberOfRows(inSection: indexPath.section) - 1
        guard indexPath.row < lastRow else {
            
            //look for next section
            guard let nextSection = self.nextSection(afterSection: indexPath.section) else {
                
                //there are no more sections
                return nil
            }
            
            //move to the next section
            let nextIndexPath = IndexPath(row: 0, section: nextSection)
            return nextIndexPath
        }
        
        //move to the next row
        let nextRow = indexPath.row + 1
        let nextIndexPath = IndexPath(row: nextRow, section: indexPath.section)
        return nextIndexPath
    }
    
    /**
     Lookup the next non-empty section after a given section.
     - parameter section: The section after which to look.
     - returns: The next non-empty section or nil if there are no more non-empty sections.
     */
    public func nextSection(afterSection section: Int) -> Int? {
        
        let nextSection = section + 1
        
        //check if the section is the last one
        let lastSection = self.numberOfSections - 1
        guard section < lastSection else {
            
            //there are no more sections
            return nil
        }
        
        //check if the next section has rows
        guard self.numberOfRows(inSection: nextSection) > 0 else {
            
            //skip that section
            return self.nextSection(afterSection: nextSection)
        }
        
        return nextSection
    }
}
#endif

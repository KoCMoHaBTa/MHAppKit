//
//  PHAsset+Metadata.swift
//  MHAppKit
//
//  Created by Milen Halachev on 7/3/17.
//  Copyright © 2017 Milen Halachev. All rights reserved.
//

import Foundation
import Photos

extension PHAsset {
    
    ///Loads any available media metadata from the recevier 
    open func mediaMetadata(completion: @escaping ([AnyHashable: Any]?) -> Void) {
        
        self.requestContentEditingInput(with: nil) { (input, info) -> Void in
            
            guard
            let url = input?.fullSizeImageURL
            else {
                
                DispatchQueue.main.async {
                    
                    completion([:])
                }
                return
            }
            
            DispatchQueue.main.async {
                
                completion(CIImage(contentsOf: url)?.properties)
            }
        }
    }
}

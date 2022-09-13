//
//  PHAsset+Metadata.swift
//  MHAppKit
//
//  Created by Milen Halachev on 7/3/17.
//  Copyright © 2017 Milen Halachev. All rights reserved.
//

#if canImport(Photos)
import Foundation
import Photos

@available(tvOS 10, *)
@available(OSX 10.13, *)
extension PHAsset {
    
    ///Loads any available media metadata from the recevier 
    @available(OSX 10.15, *)
    public func mediaMetadata(completion: @escaping ([AnyHashable: Any]?) -> Void) {
        
        self.requestContentEditingInput(with: nil) { (input, info) -> Void in
            
            guard
            let url = input?.fullSizeImageURL
            else {
                
                completion([:])
                return
            }
            
            completion(CIImage(contentsOf: url)?.properties)
        }
    }
}
#endif

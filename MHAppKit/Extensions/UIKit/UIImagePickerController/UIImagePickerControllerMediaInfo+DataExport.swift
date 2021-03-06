//
//  UIImagePickerControllerMediaInfo+DataExport.swift
//  MHAppKit
//
//  Created by Milen Halachev on 18.01.19.
//  Copyright © 2019 Milen Halachev. All rights reserved.
//

#if canImport(UIKit) && !os(watchOS)
import Foundation
import UIKit

@available(tvOS, unavailable)
extension Dictionary where Key == UIImagePickerController.InfoKey, Value == Any {
    
    @available(tvOS 10, *)
    public func exportImageData(as representation: UIImage.Representation, queue: DispatchQueue = .global(), completion: @escaping (Data?) -> Void) {
        
        guard self.isImage, let image = self.editedImage ?? self.originalImage else {
            
            NSLog("Error: media type is not an image")
            completion(nil)
            return
        }
        
        self.mediaMetadata { (mediaMetadata) in
            
            queue.async {
                
                let data = image.data(as: representation, withMetadata: mediaMetadata)
                completion(data)
            }
        }
    }
}
#endif

//
//  PHPhotoLibrary+Save.swift
//  MHAppKit
//
//  Created by Milen Halachev on 7/3/17.
//  Copyright © 2017 Milen Halachev. All rights reserved.
//

import Foundation
import Photos

extension PHPhotoLibrary {
    
    public typealias SaveCompletionHandler = (_ assetLocalIdentifier: String?, _ error: Error?) -> Void
    
    /**
     Saves an image to photo library.
     
     The image is represented as Data using the provided representation, then the metadata is injected into it and finally it is saved to the photo library.
     
     - parameter image: The image to save.
     - parameter representation: The data representation of the image.
     - parameter metadata: The image exif metadata.
     - parameter completion: The completion handler called when the image save succeeds or fails.
     */
    func save(image: UIImage, as representation: UIImage.Representation, withMetadata metadata: [AnyHashable: Any]?, completion: @escaping SaveCompletionHandler) {
        
        guard let data = image.data(as: representation, withMetadata: metadata) else {
            
            let error = NSError(domain: "PHPhotoLibrary Error", code: 0, userInfo: [NSLocalizedDescriptionKey: NSLocalizedString("Unable to represent image as data", comment: "")])
            completion(nil, error)
            return
        }
        
        self.save(imageData: data, completion: completion)
    }

    /**
     Saves an image to photo library.
     
     - parameter data: The image data to save.
     - parameter completion: The completion handler called when the image save succeeds or fails.
     */
    
    func save(imageData data: Data, completion: @escaping SaveCompletionHandler) {
        
        guard
        let temporaryFileURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent(NSUUID().uuidString)
        else {
            
            let error = NSError(domain: NSURLErrorDomain, code: NSURLErrorUnknown, userInfo: [NSLocalizedFailureReasonErrorKey: NSLocalizedString("Unable to generate temporary write file URL", comment: "")])
            completion(nil, error)
            return
        }
        
        do {
            
            try data.write(to: temporaryFileURL, options: [.atomicWrite])
        }
        catch let error as NSError {
            
            try? FileManager.default.removeItem(at: temporaryFileURL)
            completion(nil, error)
            return
        }
        
        self.save(imageFileAtURL: temporaryFileURL) { (id, error) in
            
            try? FileManager.default.removeItem(at: temporaryFileURL)
            completion(id, error)
        }
    }
    
    /**
     Saves an image to photo library.
     
     - parameter url: The location of the image file to save.
     - parameter completion: The completion handler called when the image save succeeds or fails.
     */
    
    func save(imageFileAtURL url: URL, completion: @escaping SaveCompletionHandler) {
        
        var placeholderAsset: PHObjectPlaceholder? = nil
        
        self.performChanges({ () -> Void in
            
            let assetChangeRequest = PHAssetChangeRequest.creationRequestForAssetFromImage(atFileURL: url)
            placeholderAsset = assetChangeRequest?.placeholderForCreatedAsset
            
        }) { (success, error) -> Void in
            
            DispatchQueue.main.async {
                
                completion(placeholderAsset?.localIdentifier, error)
            }
        }
    }
}

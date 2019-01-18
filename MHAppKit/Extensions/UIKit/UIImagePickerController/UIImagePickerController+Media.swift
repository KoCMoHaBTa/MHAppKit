//
//  UIImagePickerController+Media.swift
//  MHAppKit
//
//  Created by Milen Halachev on 7/3/17.
//  Copyright © 2017 Milen Halachev. All rights reserved.
//

import Foundation
import MobileCoreServices
import Photos

extension UIImagePickerController {
    
    ///Represents a media returned from UIImagePickerControllerDelegate's media info dictionary
    public struct Media {
        
        public var info: Info
    }
}

extension UIImagePickerController.Media {
    
    ///True if the media type is image, otherwise false.
    public var isImage: Bool {
        
        return self.info.mediaType == kUTTypeImage as String
    }
    
    ///True if the media type is movie, otherwise false.
    public var isMovie: Bool {
        
        return self.info.mediaType == kUTTypeMovie as String
    }
}

extension UIImagePickerController.Media {
    
    ///The asset representation of the media. Loaded using the .phAsset key (iOS 11+) or referenceURL (prior iOS 11)
    public var asset: PHAsset? {
        
        if #available(iOS 11.0, *), let asset = self.info.asset {
            
            return asset
        }
        
        guard let url = self.info.referenceURL else {
            
            return nil
        }
        
        return PHAsset.fetchAssets(withALAssetURLs: [url], options: nil).firstObject
    }
    
    /**
     Loads the media metadata if the recever.
     
     The implementation loads the metadata in the followin way:
     - checks if metadata is available in the info using `UIImagePickerControllerMediaMetadata` - this is available if the media is captured image.
     - if above is not available - loads metada from the asset representation of the receiver - this is available if the media is selected image from photo library.
     
     
     - warning: Video and Live Photos are not tested
     */
    public func mediaMetadata(_ completion: @escaping ([AnyHashable: Any]?) -> Void) {
        
        //TODO: Test and update behaviour for videos and live photos
        
        if let mediaMetadata = self.info.mediaMetadata {
            
            DispatchQueue.main.async {
                
                completion(mediaMetadata)
            }
            return
        }
        
        guard let asset = self.asset else {
            
            completion(nil)
            return
        }
        
        asset.mediaMetadata(completion: { (mediaMetadata) in
            
            DispatchQueue.main.async {
                
                completion(mediaMetadata)
            }
        })
    }
    
    /**
     Saves the receiver image representation to the photo library, including metadata.
     
     - parameter representation: The data representation to use for saving the receiver. Default to .png
     
     - note: This method works only if the receiver is image media
     - warning: Video and Live Photos are not tested
     */
    public func saveImageToPhotoLibrary(as representation: UIImage.Representation = .png, completion: ((PHAsset?, Error?) -> Void)?) {
        
        //TODO: Test and update behaviour for videos and live photos
        
        guard
        self.isImage,
        let image = self.info.editedImage ?? self.info.originalImage
        else {
            
            let error = NSError(domain: "UIImagePickerController.Media Error", code: 0, userInfo: [NSLocalizedDescriptionKey: NSLocalizedString("Media is not an image", comment: "")])
            completion?(nil, error)
            return
        }
        
        self.mediaMetadata { (metadata) in
            
            PHPhotoLibrary.shared().save(image: image, as: representation, withMetadata: metadata, completion: completion)
        }
    }
}





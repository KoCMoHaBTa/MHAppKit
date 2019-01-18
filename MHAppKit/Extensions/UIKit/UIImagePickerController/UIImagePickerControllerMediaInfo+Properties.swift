//
//  UIImagePickerControllerMediaInfo+Properties.swift
//  MHAppKit
//
//  Created by Milen Halachev on 18.01.19.
//  Copyright © 2019 Milen Halachev. All rights reserved.
//

import Foundation
import MobileCoreServices
import Photos

extension Dictionary where Key == UIImagePickerController.InfoKey, Value == Any {
    
    ///The media type selected by the user. The value of this property is a type code such as kUTTypeImage or kUTTypeMovie.
    public var mediaType: String? {
        
        return self[.mediaType] as? String
    }
    
    ///The original, uncropped image selected by the user.
    public var originalImage: UIImage? {
        
        return self[.originalImage] as? UIImage
    }
    
    ///Specifies an image edited by the user.
    public var editedImage: UIImage? {
        
        return self[.editedImage] as? UIImage
    }
    
    ///Specifies the cropping rectangle that was applied to the original image.
    public var cropRect: CGRect? {
        
        return (self[.cropRect] as? NSValue)?.cgRectValue
    }
    
    ///Specifies the filesystem URL for the movie.
    public var mediaURL: URL? {
        
        return self[.mediaURL] as? URL
    }
    
    ///The Assets Library URL for the original version of the picked item. After the user edits a picked item—such as by cropping an image or trimming a movie—the URL continues to point to the original version of the picked item.
    @available(iOS, deprecated: 11.0, message: "Use `asset` instead.")
    public var referenceURL: URL? {
        
        return self[.referenceURL] as? URL
    }
    
    ///Metadata for a newly-captured photograph. This key is valid only when using an image picker whose source type is set to camera, and applies only to still images.
    public var mediaMetadata: [String: Any]? {
        
        return self[.mediaMetadata] as? [String: Any]
    }
    
    ///The Live Photo representation of the selected or captured photo. Include the kUTTypeImage and kUTTypeLivePhoto identifiers in the allowed media types when configuring an image picker controller.
    @available(iOS 9.1, *)
    public var livePhoto: PHLivePhoto? {
        
        return self[.livePhoto] as? PHLivePhoto
    }
    
    @available(iOS 11.0, *)
    ///The key to use when retrieving a Photos asset for the image.
    public var asset: PHAsset? {
        
        return self[.phAsset] as? PHAsset
    }
}

extension Dictionary where Key == UIImagePickerController.InfoKey, Value == Any {
    
    ///True if the media type is image, otherwise false.
    public var isImage: Bool {
        
        return self.mediaType == kUTTypeImage as String
    }
    
    ///True if the media type is movie, otherwise false.
    public var isMovie: Bool {
        
        return self.mediaType == kUTTypeMovie as String
    }
}

extension Dictionary where Key == UIImagePickerController.InfoKey, Value == Any {
    
    ///The asset representation of the media. Loaded using the .phAsset key (iOS 11+) or referenceURL (prior iOS 11)
    public func fetchAsset() -> PHAsset? {
        
        if #available(iOS 11.0, *), let asset = self.asset {
            
            return asset
        }
        
        guard let url = self.referenceURL else {
            
            return nil
        }
        
        return PHAsset.fetchAssets(withALAssetURLs: [url], options: nil).firstObject
    }
}

extension Dictionary where Key == UIImagePickerController.InfoKey, Value == Any {
    
    /**
     Loads the media metadata if the recever.
     
     The implementation loads the metadata in the followin way:
     - checks if metadata is available in the info using `UIImagePickerControllerMediaMetadata` - this is available if the media is captured image.
     - if above is not available - loads metada from the asset representation of the receiver - this is available if the media is selected image from photo library.
     
     
     - warning: Video and Live Photos are not tested
     */
    public func mediaMetadata(_ completion: @escaping ([AnyHashable: Any]?) -> Void) {
        
        //TODO: Test and update behaviour for videos and live photos
        
        if let mediaMetadata = self.mediaMetadata {
            
            completion(mediaMetadata)
            return
        }
        
        guard let asset = self.fetchAsset() else {
            
            completion(nil)
            return
        }
        
        asset.mediaMetadata(completion: completion)
    }
}

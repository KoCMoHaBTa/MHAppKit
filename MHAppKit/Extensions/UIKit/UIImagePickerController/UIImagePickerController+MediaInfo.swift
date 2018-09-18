//
//  UIImagePickerController+MediaInfo.swift
//  MHAppKit
//
//  Created by Milen Halachev on 7/3/17.
//  Copyright © 2017 Milen Halachev. All rights reserved.
//

import Foundation
import MobileCoreServices
import Photos

extension UIImagePickerController.Media {
    
    ///A wrapper around the media info dictionary returned from UIImagePickerControllerDelegate
    public struct Info {
        
        ///apple-reference-documentation://ts1658409
        public var dictionary: [UIImagePickerController.InfoKey : Any]
    }
}

extension UIImagePickerController.Media.Info {
    
    ///The media type selected by the user. The value of this property is a type code such as kUTTypeImage or kUTTypeMovie.
    public var mediaType: String {
        
        return self.dictionary[.mediaType] as! String
    }
    
    ///The original, uncropped image selected by the user.
    public var originalImage: UIImage? {
        
        return self.dictionary[.originalImage] as? UIImage
    }
    
    ///Specifies an image edited by the user.
    public var editedImage: UIImage? {
        
        return self.dictionary[.editedImage] as? UIImage
    }
    
    ///Specifies the cropping rectangle that was applied to the original image.
    public var cropRect: CGRect? {
        
        return (self.dictionary[.cropRect] as? NSValue)?.cgRectValue
    }
    
    ///Specifies the filesystem URL for the movie.
    public var mediaURL: URL? {
        
        return self.dictionary[.mediaURL] as? URL
    }
    
    ///The Assets Library URL for the original version of the picked item. After the user edits a picked item—such as by cropping an image or trimming a movie—the URL continues to point to the original version of the picked item.
    public var referenceURL: URL? {
        
        return self.dictionary[.referenceURL] as? URL
    }
    
    ///Metadata for a newly-captured photograph. This key is valid only when using an image picker whose source type is set to camera, and applies only to still images.
    public var mediaMetadata: [String: Any]? {
        
        return self.dictionary[.mediaMetadata] as? [String: Any]
    }
    
    ///The Live Photo representation of the selected or captured photo. Include the kUTTypeImage and kUTTypeLivePhoto identifiers in the allowed media types when configuring an image picker controller.
    @available(iOS 9.1, *)
    public var livePhoto: PHLivePhoto? {
        
        return self.dictionary[.livePhoto] as? PHLivePhoto
    }
}

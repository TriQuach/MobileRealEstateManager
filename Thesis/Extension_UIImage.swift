//
//  Extension_UIImage.swift
//  Thesis
//
//  Created by Tri Quach on 6/15/17.
//  Copyright © 2017 TriQuach. All rights reserved.
//

import Foundation
import UIKit
public enum ImageFormat {
    case png
    case jpeg(CGFloat)
}

extension UIImage {
    
    public func base64(format: ImageFormat) -> String? {
        var imageData: Data?
        switch format {
        case .png: imageData = UIImagePNGRepresentation(self)
        case .jpeg(let compression): imageData = UIImageJPEGRepresentation(self, compression)
        }
        return imageData?.base64EncodedString()
    }
}

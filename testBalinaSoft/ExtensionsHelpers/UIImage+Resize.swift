//
//  UIImage+.swift
//  testBalinaSoft
//
//  Created by Ilya Lagutovsky on 2/19/20.
//  Copyright © 2020 Ilya Lagutovsky. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    // MARK: - UIImage+Resize
    func compressTo(_ expectedSizeInKb: Int) -> Data? {
        let sizeInBytes = expectedSizeInKb * 1024
        var needCompress:Bool = true
        var imgData:Data?
        var compressingValue: CGFloat = 1.0
        while (needCompress && compressingValue > 0.0) {
            if let data = self.jpegData(compressionQuality: compressingValue) {
                if data.count < sizeInBytes {
                    needCompress = false
                    imgData = data
                } else {
                    compressingValue -= 0.1
                }
            }
        }
        
        if let data = imgData {
            if (data.count < sizeInBytes) {
                return data
            }
        }
        return nil
    }
}

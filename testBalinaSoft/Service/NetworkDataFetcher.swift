//
//  NetworkDataFetcher.swift
//  testBalinaSoft
//
//  Created by Ilya Lagutovsky on 2/18/20.
//  Copyright © 2020 Ilya Lagutovsky. All rights reserved.
//

import Foundation
import UIKit

enum Constants {
    static let maxSizeImageInKilobytes = 1024
}

protocol DataFetcher: class {
    func getUserInfo(withParams params: String?, response: @escaping (UserResponse?) -> Void)
    func postUserInfo(withImage image: UIImage, withId id: String, withName name: String, success: @escaping (Bool) -> Void)
}

class NetworkDataFetcher: DataFetcher {

    private var networkService: Networking = NetworkService()
    
    private let url =  "https://junior.balinasoft.com/api/v2/photo/type"
    private let postUrl = "https://junior.balinasoft.com/api/v2/photo"
    
    
    func getUserInfo(withParams params: String?, response: @escaping (UserResponse?) -> Void) {
        var urls = url
        if let params = params {
            urls = urls + params
        }
        
        networkService.getRequest(withURL: urls) { (data, error) in
            if error != nil {
                response(nil)
                return
            }
            
            guard let data = data,
                let decoded = try? JSONDecoder().decode(UserResponse.self, from: data) else { return }
           
            response(decoded)
        }
    }
    
    func postUserInfo(withImage image: UIImage, withId id: String, withName name: String, success: @escaping (Bool) -> Void) {
        guard let imageData = image.compressTo(Constants.maxSizeImageInKilobytes) else { return }
        networkService.postRequest(withURL: postUrl, withImageData: imageData, withId: id, withName: name, success: success)
     }
}

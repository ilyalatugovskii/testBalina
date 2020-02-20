//
//  NetworkService.swift
//  testBalinaSoft
//
//  Created by Ilya Lagutovsky on 2/18/20.
//  Copyright © 2020 Ilya Lagutovsky. All rights reserved.
//

import Foundation
import UIKit

protocol Networking: class {
    func getRequest(withURL urlString: String, completion: @escaping (Data?, Error?) -> Void)
    func postRequest(withURL urlString: String,withImageData data: Data, withId id: String, withName name: String, success: @escaping (Bool) -> Void)
}

class NetworkService: Networking {
    
    func getRequest(withURL urlString: String, completion: @escaping (Data?, Error?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: URLRequest(url: url)) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }.resume()
        
    }
    
    func postRequest(withURL urlString: String, withImageData data: Data, withId id: String, withName name: String, success: @escaping (Bool) -> Void) {
        guard let postUrl = URL(string: urlString) else { return }
        
        var request = URLRequest(url: postUrl);
        request.httpMethod = "POST";
        
        let param = [
            "name"  : "\(name)",
            "typeId"    : "\(id)"
        ]
        
        let boundary = UUID().uuidString
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.httpBody = createBodyWithParameters(parameters: param, imageDataKey: data, boundary: boundary)
       
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                return
            }
            guard let data = data else { return }
            // You can print out response object
            print("******* response = \(String(describing: response))")
            
            // Print out reponse body
            let responseString = String(data: data, encoding: .utf8)
            print("****** response data = \(responseString!)")
            
            var isSuccess = false
            if let _ = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: String] {
                isSuccess = true
            }
            
            DispatchQueue.main.async {
                 success(isSuccess)
            }
           
        }.resume()
    }
    
    private func createBodyWithParameters(parameters: [String: String]?, imageDataKey: Data, boundary: String) -> Data {
            var body = Data();
            
            if parameters != nil {
                for (key, value) in parameters! {
                    body.append("--\(boundary)\r\n".data(using: .utf8)!)
                    body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
                    body.append("\(value)\r\n".data(using: .utf8)!)
                }
            }
    
            let filename = ".jpeg"
            let mimetype = "image/jpeg"
            
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"photo\"; filename=\"\(filename)\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: \(mimetype)\r\n\r\n".data(using: .utf8)!)
            body.append(imageDataKey)
            body.append("\r\n".data(using: .utf8)!)
            body.append("--\(boundary)--\r\n".data(using: .utf8)!)
            
            return body
        }
}

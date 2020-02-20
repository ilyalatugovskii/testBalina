//
//  InfoUserWorker.swift
//  testBalinaSoft
//
//  Created by Ilya Lagutovsky on 2/18/20.
//  Copyright (c) 2020 Ilya Lagutovsky. All rights reserved.
//

import UIKit

class InfoUserService {
    var dataFetcher: DataFetcher = NetworkDataFetcher()
    var cameraService = CameraService()
    
    private var userResponse: UserResponse?
    
    func getUserInfo(completion: @escaping (UserResponse) -> Void) {
        dataFetcher.getUserInfo(withParams: nil) { [weak self] (userResponse) in
            guard let userResponse = userResponse else { return }
            self?.userResponse = userResponse
            completion(userResponse)
        }
    }
    
    func gerRequestWithNewParametrs(indexPath: IndexPath, completion: @escaping (UserResponse) -> Void) {
        guard let userResponse = userResponse else { return }
        
        if indexPath.row == (userResponse.pageSize * ( userResponse.page + 1 )) - 1 {
            let params = "?page=" + String(userResponse.page + 1)
            print(params)
            dataFetcher.getUserInfo(withParams: params) { [weak self] (additionalUserResponse) in
                guard let addUserResponse = additionalUserResponse else { return }
                self?.userResponse?.content.append(contentsOf: addUserResponse.content)
                self?.userResponse?.pageSize = addUserResponse.pageSize
                self?.userResponse?.page = addUserResponse.page
                completion(self!.userResponse!)
            }
        }
    }

    func cameraHandler(viewController: InfoUserViewController, infoCell :InfoCellContentViewModel, completion: @escaping (Bool) -> Void) {
        cameraService.showActionSheet(vc: viewController)
        
        cameraService.imagePickedBlock = { [weak self] image in
            viewController.activityIndicator.isHidden = false
            viewController.visualEffectView.isHidden = false
            self?.dataFetcher.postUserInfo(withImage: image, withId: infoCell.userId, withName: infoCell.userName) { (isSuccess) in
                completion(isSuccess)
            }
        }
    }
}

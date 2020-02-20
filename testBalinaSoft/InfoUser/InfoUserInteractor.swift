//
//  InfoUserInteractor.swift
//  testBalinaSoft
//
//  Created by Ilya Lagutovsky on 2/18/20.
//  Copyright (c) 2020 Ilya Lagutovsky. All rights reserved.
//

import UIKit

protocol InfoUserBusinessLogic {
  func makeRequest(request: InfoUser.Model.Request.RequestType)
}

class InfoUserInteractor: InfoUserBusinessLogic {

  var presenter: InfoUserPresentationLogic?
  var service: InfoUserService?
    
  private var userResponse: UserResponse?
    
  func makeRequest(request: InfoUser.Model.Request.RequestType) {
    if service == nil {
      service = InfoUserService()
    }
    
    switch request {
    case .getRequest:
        service?.getUserInfo(completion: { [weak self] (userResponse) in
            self?.presenter?.presentData(response: .presentGetRequest(userResponse: userResponse))
        })

    case .getCamera(let infoCell, let viewController):
        service?.cameraHandler(viewController: viewController, infoCell: infoCell, completion: { [weak self] (isSuccess) in
            self?.presenter?.presentData(response: .presentAlert(isSsuccess: isSuccess))
        })
        
    case .gerRequestWithNewParametrs(let indexPath):
        service?.gerRequestWithNewParametrs(indexPath: indexPath, completion: { [weak self] (userResponse) in
            self?.presenter?.presentData(response: .presentGetRequest(userResponse: userResponse))
        })

    }
  }
  
}

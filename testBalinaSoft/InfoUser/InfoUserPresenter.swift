//
//  InfoUserPresenter.swift
//  testBalinaSoft
//
//  Created by Ilya Lagutovsky on 2/18/20.
//  Copyright (c) 2020 Ilya Lagutovsky. All rights reserved.
//

import UIKit

protocol InfoUserPresentationLogic {
  func presentData(response: InfoUser.Model.Response.ResponseType)
}

class InfoUserPresenter: InfoUserPresentationLogic {
  weak var viewController: InfoUserDisplayLogic?
  
  func presentData(response: InfoUser.Model.Response.ResponseType) {
    switch response {
   
    case .presentGetRequest(let userResponse):
        let cells = userResponse.content.map { InfoViewModel.Cell(userId: String($0.id), userName: $0.name) }
        let infoViewModel = InfoViewModel(cells: cells)
        viewController?.displayData(viewModel: .display(viewModel: infoViewModel))
        
    case .presentAlert(let isSsuccess):
        let cortage = isSsuccess ? ("Ssuccess",  "data uploaded") : ("Not ssuccess", "data do not uploaded")
        
        viewController?.displayData(viewModel: .displayAlert(cortage))
    }
   
 }
}

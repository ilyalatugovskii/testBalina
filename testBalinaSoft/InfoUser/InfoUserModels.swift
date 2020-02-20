//
//  InfoUserModels.swift
//  testBalinaSoft
//
//  Created by Ilya Lagutovsky on 2/18/20.
//  Copyright (c) 2020 Ilya Lagutovsky. All rights reserved.
//

import UIKit

enum InfoUser {
   
  enum Model {
    struct Request {
      enum RequestType {
        case getRequest
        case getCamera(infoCell: InfoCellContentViewModel, viewController: InfoUserViewController )
        case gerRequestWithNewParametrs(indexPath: IndexPath)
      }
    }
    struct Response {
      enum ResponseType {
        case presentGetRequest(userResponse: UserResponse)
        case presentAlert(isSsuccess: Bool)
      }
    }
    struct ViewModel {
      enum ViewModelData {
        case display(viewModel: InfoViewModel)
        case displayAlert((String, String))
      }
    }
  }
  
}

struct UserResponse: Codable {
    var content: [Content]
    var page: Int
    var pageSize: Int
    var totalElements: Int
    var totalPages: Int
}

struct Content: Codable {
    var id: Int
    var name: String
}

struct InfoViewModel {
    
    struct Cell: InfoCellContentViewModel {
        var userId: String
        var userName: String
    }
    
    var cells: [Cell]
}

//
//  InfoUserViewController.swift
//  testBalinaSoft
//
//  Created by Ilya Lagutovsky on 2/18/20.
//  Copyright (c) 2020 Ilya Lagutovsky. All rights reserved.
//

import UIKit
import Foundation

protocol InfoUserDisplayLogic: class {
  func displayData(viewModel: InfoUser.Model.ViewModel.ViewModelData)
}

class InfoUserViewController: UIViewController, InfoUserDisplayLogic {
  
  @IBOutlet weak var visualEffectView: UIVisualEffectView! // 
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView! //
    
  var usersInformation = InfoViewModel(cells: [])
  var interactor: InfoUserBusinessLogic?
  var router: (NSObjectProtocol & InfoUserRoutingLogic)?
    
  // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  
  private func setup() {
    let viewController        = self
    let interactor            = InfoUserInteractor()
    let presenter             = InfoUserPresenter()
    let router                = InfoUserRouter()
    viewController.interactor = interactor
    viewController.router     = router
    interactor.presenter      = presenter
    presenter.viewController  = viewController
    router.viewController     = viewController
  }
  
  // MARK: Routing
  

  
  // MARK: View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    interactor?.makeRequest(request: .getRequest)
  }
  
  func displayData(viewModel: InfoUser.Model.ViewModel.ViewModelData) {
    switch viewModel {
        
    case .display(let viewModel):
        usersInformation = viewModel
        tableView.reloadData()
    
    case .displayAlert(let title, let message):
        visualEffectView.isHidden = true
        activityIndicator.isHidden = true
        showAlert(withTitle: title, withMessage: message)
    }
  }
}

extension InfoUserViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersInformation.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "infoUser", for: indexPath) as! InfoUserTableViewCell
        cell.set(userInformation: usersInformation.cells[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor?.makeRequest(request: .getCamera(infoCell: usersInformation.cells[indexPath.row], viewController: self))
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        interactor?.makeRequest(request: .gerRequestWithNewParametrs(indexPath: indexPath))
    }
 
    
}

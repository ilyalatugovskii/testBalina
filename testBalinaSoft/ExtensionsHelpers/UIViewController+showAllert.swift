//
//  UIVIew+.swift
//  testBalinaSoft
//
//  Created by Ilya Lagutovsky on 2/19/20.
//  Copyright © 2020 Ilya Lagutovsky. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(withTitle title: String, withMessage message: String) {    //  я знаю что оно блокирует ui, но мне кажется что в этом случае пойдет.
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        Timer.scheduledTimer(withTimeInterval:  1.5, repeats: false) { (timer) in
            self.dismiss(animated: true, completion: nil)
        }
    }
}

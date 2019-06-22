//
//  UIViewControllerExtension.swift
//  MyCV
//
//  Created by Leming Deng on 2019-06-20.
//  Copyright © 2019 Leming Deng. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func showError(_ error: Error, retryHandler: @escaping (UIAlertAction) -> Void) {
        let alert = UIAlertController(title: nil, message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Retry".localizedCapitalized, style: .default, handler: retryHandler))
        alert.addAction(UIAlertAction(title: "Cancel".localizedCapitalized, style: .cancel))
        present(alert, animated: true)
    }
}

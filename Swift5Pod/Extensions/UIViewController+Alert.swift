//
//  UIViewController+Alert.swift
//  Swift5Pod
//
//  Created by yoshiyuki ono on 2019/04/07.
//  Copyright © 2019 yono-ap. All rights reserved.
//

import UIKit

protocol Alert {

    /// 1ボタンアラートを表示する.
    ///
    /// - Parameters:
    ///   - title: タイトル
    ///   - message: メッセージ
    func displayAlert(title: String, message: String)
}

// MARK: - Alert
extension UIViewController: Alert {

    func displayAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}

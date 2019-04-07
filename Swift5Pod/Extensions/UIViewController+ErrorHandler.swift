//
//  UIViewController+ErrorHandler.swift
//  Swift5Pod
//
//  Created by yoshiyuki ono on 2019/04/07.
//  Copyright © 2019 yono-ap. All rights reserved.
//

import UIKit

protocol ErrorHandler {

    /// HTTPのデフォルトエラーハンドラー. 1ボタンアラートを表示する.
    ///
    /// - Parameters:
    ///   - data: エラー時のパラメータ
    ///   - response: エラー時のパラメータ
    ///   - error: エラー時のパラメータ
    func httpErrorHandler(data: Data?, response: URLResponse?, error: Error?)
}

// MARK: - ErrorHandler
extension UIViewController: ErrorHandler {
    func httpErrorHandler(data: Data?, response: URLResponse?, error: Error?) {
        var errorText = ""
        if let error = error {
            errorText = "\(error)"
        }
        var codeText = ""
        if let response = response as? HTTPURLResponse {
            codeText = response.statusCode.description
        }
        var dataText = ""
        if let data = data {
            dataText = String(data: data, encoding: .utf8) ?? ""
        }
        displayAlert(title: "Error", message: "\(errorText) \(codeText) \(dataText)")
    }

}

//
//  NSObject+AppLog.swift
//  Swift5Pod
//
//  Created by yoshiyuki ono on 2019/04/07.
//  Copyright © 2019 yono-ap. All rights reserved.
//

import Foundation

/// ログ拡張. 呼び出し元の諸元を参照する例. どこからでも使えるようにNSObjectを拡張する.
protocol AppLog {

    /// トレース.
    ///
    /// - Parameters:
    ///   - line: 呼び出し元行数
    ///   - function: 呼び出し元関数名
    func appTrace(line: Int, function: String)

    /// メッセージログ.
    ///
    /// - Parameters:
    ///   - message: メッセージ
    ///   - line: 呼び出し元行数
    ///   - function: 呼び出し元関数名
    func appLog(_ message: String, line: Int, function: String)
}

extension NSObject: AppLog {
    func appTrace(line: Int = #line, function: String = #function) {
        let text = "[TRACE] \(String(describing: type(of: self))) \(line) \(function)"
        print(text)
    }

    func appLog(_ message: String, line: Int = #line, function: String = #function) {
        let text = "[LOG] \(String(describing: type(of: self))) \(line) \(function) \(message)"
        print(text)
    }

}

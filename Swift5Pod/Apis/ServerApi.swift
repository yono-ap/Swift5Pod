//
//  ServerApi.swift
//  Swift5Pod
//
//  Created by yoshiyuki ono on 2019/04/13.
//  Copyright © 2019 yono-ap. All rights reserved.
//

import Foundation

/// 通信処理の固有エラー.
///
/// - badUrlString: 指定したURLを生成できない.
enum ServerApiError: Error {
    case badUrlString
}

/// サーバーAPIを実行する
class ServerApi<T: Codable>: NSObject {

    /// GETを実行する
    ///
    /// - Parameters:
    ///   - urlString: リクエストURL文字列
    ///   - dataHandler: 正常終了時のハンドラーを指定する
    ///   - errorHandler: エラー終了時のハンドラーを指定する
    func apiGet(urlString: String,
                dataHandler: @escaping (T) -> Void,
                errorHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {

        appLog("[SEND] \(urlString)")
        guard let url = URL(string: urlString) else {
            appLog("url is nil.")
            errorHandler(nil, nil, ServerApiError.badUrlString)
            return
        }

        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            if let error = error {
                self.appLog("[RECV] \(error.localizedDescription)")
                errorHandler(data, response, error)
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                self.appLog("[RECV] no response.")
                errorHandler(data, response, error)
                return
            }

            httpResponse.allHeaderFields.forEach({ key, value in
                print("[RECV HEADER] \(key) : \(value)")
            })

            if httpResponse.statusCode != 200 {
                self.appLog("[RECV] \(httpResponse.statusCode) \(httpResponse.description)")
                errorHandler(data, httpResponse, error)
                return
            }

            guard let jsonData = data else {
                self.appLog("[RECV] no data.")
                errorHandler(data, httpResponse, error)
                return
            }

            self.appLog("[RECV] \(String(data: jsonData, encoding: .utf8) ?? "encode error.")")

            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            do {
                let instance = try decoder.decode(T.self, from: jsonData)
                dataHandler(instance)
            } catch let error {
                errorHandler(jsonData, httpResponse, error)
            }
        })
        task.resume()
    }

}

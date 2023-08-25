//
//  Logging.swift
//  ConCurrency
//
//  Created by Mohamed Atallah on 25/08/2023.
//

import Foundation

protocol Logging {
    /// Log a message
    ///
    /// - Parameters:
    ///   - message: To be logged message
    ///   - level: Log level
    ///   - file: File name. Default is caller file name.
    ///   - function: Function name, Default is caller function name.
    ///   - line: Invoke line. Default is invoke line number.
    static func log(_ message: @autoclosure () -> String,
             level: LogLevel,
             file: String,
             function: String,
             line: UInt)
}

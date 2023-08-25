//
//  LoggerManager.swift
//  ConCurrency
//
//  Created by Mohamed Atallah on 25/08/2023.
//

import Foundation

enum LoggerManager: Logging {
    static func log(_ message: @autoclosure () -> String,
             level: LogLevel = .info,
             file: String = #file,
             function: String = #function,
             line: UInt = #line) {
        let logMessage = "\(level.rawValue) - \(file) - Line \(line) - \(function): \(message())"
        debugPrint(logMessage)
    }
}

extension LoggerManager: LogEngine {
    static func verbose(message: @autoclosure () -> String,
                 file: String = #file,
                 function: String = #function,
                 line: UInt = #line) {
        log(message(), level: .verbose, file: file, function: function, line: line)
    }
    
    static func info(message: @autoclosure () -> String,
              file: String = #file,
              function: String = #function,
              line: UInt = #line) {
        log(message(), level: .info, file: file, function: function, line: line)
    }
    
    static func warn(message: @autoclosure () -> String,
              file: String = #file,
              function: String = #function,
              line: UInt = #line) {
        log(message(), level: .warn, file: file, function: function, line: line)
    }
    
    static func error(message: @autoclosure () -> String,
               file: String = #file,
               function: String = #function,
               line: UInt = #line) {
        log(message(), level: .error, file: file, function: function, line: line)
    }
}

//
//  LogLevel.swift
//  ConCurrency
//
//  Created by Mohamed Atallah on 25/08/2023.
//

import Foundation

enum LogLevel: String {
    
    /// When you need full visibility of what is happening in your application.
    ///
    case verbose = "VERBOSE 🙄"
    
    /// Standard log level indicating that something happened, the application entered a certain state, etc.
    ///
    case info = "INFO 👀"
    
    /// Indicates that something unexpected happened in the application, a problem, or a situation that
    /// might disturb one of the processes. But that doesn’t mean that the application failed.
    ///
    case warn = "WARN ⚠️"
    
    /// Should be used when the application hits an issue preventing one or more functionalities from
    /// properly functioning.
    case error = "ERROR 🚨"
}

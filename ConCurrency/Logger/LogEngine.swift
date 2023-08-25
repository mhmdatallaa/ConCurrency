//
//  LogEngine.swift
//  ConCurrency
//
//  Created by Mohamed Atallah on 25/08/2023.
//

import Foundation

protocol LogEngine {
    static func verbose(message: @autoclosure () -> String,
                 file: String,
                 function: String,
                 line: UInt)
    
    static func info(message: @autoclosure () -> String,
              file: String,
              function: String,
              line: UInt)
    
    static func warn(message: @autoclosure () -> String,
              file: String,
              function: String,
              line: UInt)
    
    static func error(message: @autoclosure () -> String,
               file: String,
               function: String,
               line: UInt)
}

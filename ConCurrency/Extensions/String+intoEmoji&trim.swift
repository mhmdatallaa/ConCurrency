//
//  String+intoEmoji.swift
//  ConCurrency
//
//  Created by Mohamed Atallah on 28/08/2023.
//

import Foundation

extension String {
    
    var trimm: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func intoEmoji() -> String {
        let code = self.dropLast()
        let base: UInt32 = 127397
        var emoji = ""
        for scalar in code.unicodeScalars {
            emoji.append(String(UnicodeScalar(base + scalar.value)!))
        }
        return emoji
    }
}

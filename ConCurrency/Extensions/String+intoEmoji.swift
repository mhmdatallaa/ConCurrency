//
//  String+intoEmoji.swift
//  ConCurrency
//
//  Created by Mohamed Atallah on 28/08/2023.
//

import Foundation

extension String {
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

//
//    private func getFlagEmoji(flag: String) -> String {
//        let code = flag.dropLast()
//        let base: UInt32 = 127397
//        var emoji = ""
//        for scalar in code.unicodeScalars {
//            emoji.append(String(UnicodeScalar(base + scalar.value)!))
//        }
//        print(emoji)
//        return emoji
//    }

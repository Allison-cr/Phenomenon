//
//  String+ext.swift
//  Phenomenon
//
//  Created by Alexander Suprun on 22.07.2024.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "\(self) could not be found in localizable.strings")
    }
}

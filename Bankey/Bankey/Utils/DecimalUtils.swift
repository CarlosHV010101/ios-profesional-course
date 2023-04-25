//
//  DecimalUtils.swift
//  Bankey
//
//  Created by Administrador on 27/04/23.
//

import Foundation

extension Decimal {
    var doubleValue: Double {
        return NSDecimalNumber(decimal: self).doubleValue
    }
}

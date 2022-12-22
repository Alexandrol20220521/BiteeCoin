//
//  CurrencyModel.swift
//  BiteeCoin
//
//  Created by 中島竜太郎 on 2022/11/01.
//

import Foundation

struct CurrencyModel {
    let currentRate : Double
    let currency : String
    var rateString: String {
        return String(format: "%.5f", currentRate)
    }
}

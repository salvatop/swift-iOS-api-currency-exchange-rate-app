//
//  Currency.swift
//  currency_converter
//
//  Created by salvatore palazzo on 2020-05-20.
//  Copyright © 2020 salvatore palazzo. All rights reserved.
//

import Foundation

struct Currency : Decodable{
    let rates : [String : Double]
}

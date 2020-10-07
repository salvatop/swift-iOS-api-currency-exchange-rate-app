//
//  CurrencyManager.swift
//  currency_converter
//
//  Created by salvatore palazzo on 2020-05-20.
//  Copyright © 2020 salvatore palazzo. All rights reserved.
//

import Foundation

protocol CurrencyManagerDelegate {
    func getRates(listOfRates: [String:Double]) -> [String:Double]
    func makeAlert(title:String , error : Error?)
}

struct CurrencyManager {
    var delegate : CurrencyManagerDelegate!
    let url = URL(string: "http://data.fixer.io/api/latest?access_key=")
    let session = URLSession.shared
           
    func getCurrency() {
        let task =  session.dataTask(with: url!) { (data, response, error) in
                  if error != nil {
                    self.delegate?.makeAlert(title: "Error", error: error)
                  }
                  if let safeData = data {
                      if let lstRates = self.jsonParse(safeData) {
                        self.delegate!.getRates(listOfRates: lstRates)
                      }
                  }
              }
              task.resume()
    }
    
    func jsonParse(_ data : Data)-> [String:Double]! {
          let decoder = JSONDecoder()
          do {
              let decodeData = try decoder.decode(Currency.self, from: data)
              let listOfRates = decodeData.rates
              return listOfRates
          }
          catch {
              return nil
          }
      }
}

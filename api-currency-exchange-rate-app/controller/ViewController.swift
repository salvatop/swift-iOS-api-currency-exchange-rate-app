//
//  ViewController.swift
//  currency_converter
//
//  Created by salvatore palazzo on 2020-05-14.
//  Copyright © 2020 salvatore palazzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
    @IBOutlet weak var excRate: UILabel!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var switchStyle: UIButton!
    
    private var manageCurrency = CurrencyManager()
    
    private let dataSource = ["CAD" , "USD" , "JPY" , "CNY"]
    private var rates: [String:Double] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
              
        manageCurrency.delegate = self
        manageCurrency.getCurrency()
        
        picker.dataSource = self
        picker.delegate = self
    }
    
    @IBAction func changeStyle(_ sender: Any) {
        let userInterfaceStyle = traitCollection.userInterfaceStyle
        
        if userInterfaceStyle == .dark {
            overrideUserInterfaceStyle = .light
        } else {
            overrideUserInterfaceStyle = .dark
        }
    }
}


//MARK: - UIStyles
extension ViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        
       let userInterfaceStyle = traitCollection.userInterfaceStyle
        
        if userInterfaceStyle == .dark {
            switchStyle.setTitleColor(.white, for: .normal)
                    
        }
        else {
           switchStyle.setTitleColor(.black, for: .normal)
        }
        
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        
      let userInterfaceStyle = traitCollection.userInterfaceStyle
             
             if userInterfaceStyle == .dark {
                 switchStyle.setTitleColor(.white, for: .normal)
             }
             else {
                 switchStyle.setTitleColor(.black, for: .normal)
             }
    }
}

//MARK: -ManageCurrencyDelegate

extension ViewController:CurrencyManagerDelegate, UIPickerViewDelegate , UIPickerViewDataSource {
    
    func getRates(listOfRates: [String : Double]) -> [String : Double] {
        self.rates = listOfRates
        return self.rates
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return dataSource.count
        }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return dataSource[row]
        }
        
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        manageCurrency.getCurrency()
        switch dataSource[row] {
            
            case "CAD":
                excRate.text = "Exchange Rate: \(rates["CAD"] ?? 0.0)"
            break
            case "USD":
                excRate.text = "Exchange Rate: \(rates["USD"] ?? 0.0)"
            break
                
            case "JPY":
                excRate.text = "Exchange Rate: \(rates["JPY"] ?? 0.0)"
            break
                
            case "CNY":
                excRate.text = "Exchange Rate: \(rates["CNY"] ?? 0.0)"
            break
                
            default: break
        }
    }
    
    func makeAlert(title:String , error:Error?){
        
        let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                       let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
                       alert.addAction(okButton)
                       self.present(alert, animated: true, completion: nil)
    }
}

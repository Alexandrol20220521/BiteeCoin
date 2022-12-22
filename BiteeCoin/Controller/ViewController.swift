//
//  ViewController.swift
//  BiteeCoin
//
//  Created by 中島竜太郎 on 2022/10/31.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var bitCoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
   var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.delegate = self
        
        
    }

   
}

//Mark: - UIPickerVIewDataSource
extension ViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        coinManager.currencyArray.count
    }
}

//Mark: - UIPickerViewDelegate
extension ViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(coinManager.currencyArray[row])
      
        let selectedCurrency = coinManager.currencyArray[row]
            
        coinManager.getCoinPrice(for: selectedCurrency)
        
      
    }
}

//Mark: - CoinManagerDelegare
extension ViewController: CoinManagerDelegate {
    func didUpDatecurrncy(_ coinManager: CoinManager, coinModel: CurrencyModel) {
        DispatchQueue.main.async {
            // self.bitCoinLabel.text = String("\(coinModel.currentRate)")
            self.bitCoinLabel.text = coinModel.rateString
            self.currencyLabel.text = coinModel.currency
        }
    }
    
    func didUPdateFail(error: Error) {
        print(error)
    }
    
    
}

//
//  CoinManager.swift
//  BiteeCoin
//
//  Created by 中島竜太郎 on 2022/10/31.
//

import Foundation

import Foundation

protocol CoinManagerDelegate {
    func didUpDatecurrncy(_ coinManager: CoinManager, coinModel: CurrencyModel)
    
    func didUPdateFail(error: Error)
}

struct CoinManager {
    
    var delegate: CoinManagerDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "F8320103-B289-4591-99E0-FF3B7792DC53"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    // sent a currency from UIPickerviewDelegate
    func getCoinPrice(for currency: String) {
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        print(urlString)
        perfournRequest(with: urlString)
    }
    
    func perfournRequest(with urlString: String) {
        //createa a URL
        if let url = URL(string: urlString) {
            //create a session
            let session = URLSession(configuration: .default)
            //give the session a task
            let task = session.dataTask(with: url) { (data, URLResponse, error) in
                if error != nil {
                    self.delegate?.didUPdateFail(error: error!)
                    return
                }
                if let safeData = data {
                    if let currency = self.parseJSON(safeData) {
                        self.delegate?.didUpDatecurrncy(self, coinModel: currency)
                        
                        //let dataAsString = String(data: data!, encoding: .utf8)
                   // print(dataAsString!)
                    }
                        
                    
                }
            }
            //start a task
            task.resume()
        }
    }
    
    func parseJSON(_ currencyData: Data) -> CurrencyModel? {
        let decorder = JSONDecoder()
        do {
            let decordedData = try decorder.decode(CurrencyData.self, from: currencyData)
            let currency = decordedData.asset_id_quote
            let rate = decordedData.rate
            print(rate)
            
            return CurrencyModel(currentRate: rate, currency: currency)
        } catch {
            print(error)
            return nil
        }
    }
    
}

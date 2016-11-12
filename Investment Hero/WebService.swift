//
//  WebService.swift
//  Investment Hero
//
//  Created by Alex Nguyen on 2016-11-11.
//  Copyright © 2016 Alex Nguyen. All rights reserved.
//

import Foundation
import Alamofire

class WebService {
    
    static let shared = WebService()
    
    func searchForSymbol(withSymbol symbolTxt : String, completion : ((_ found : Bool, _ symbol : Symbol?) -> Void)?){
        let url = URL(string: "https://investment-hero.herokuapp.com/GetEndOfDayData/\(symbolTxt)")
        Alamofire.request(url!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            print(response.description)
            if let results = response.result.value as? [String : AnyObject] {
                if let success = results["success"] as? Bool {
                    if (success) {
                        if let body = results["body"] as? [String : AnyObject]{
                            if let prices = body["Prices"] as? [String : AnyObject] {
                                if let eodPrice = prices["EndOfDayPrice"] as? [String : AnyObject] {
                                    let symbol = Symbol()
                                    symbol.symbolName = symbolTxt
                                    if let close = eodPrice["Close"] as? String {
                                        symbol.close = Double(close)
                                    }
                                    if let high = eodPrice["High"] as? String {
                                        symbol.high = Double(high)
                                    }
                                    if let lastSale = eodPrice["LastSale"] as? String {
                                         symbol.lastSale = Double(lastSale)
                                    }
                                    if let low = eodPrice["Low"] as? String {
                                        symbol.low = Double(low)
                                    }
                                    if let open = eodPrice["Open"] as? String {
                                        symbol.open = Double(open)
                                    }
                                    if let volume = eodPrice["Volume"] as? String {
                                        symbol.volume = Double(volume)
                                    }
                                    completion?(true, symbol)
                                }
                            }
                        }
                    } else {
                        completion?(false, nil)
                    }
                } else {
                    completion?(false, nil)
                }
            } else {
                completion?(false, nil)
            }

        }
    }
}

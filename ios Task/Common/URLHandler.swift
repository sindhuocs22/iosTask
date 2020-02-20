//
//  URLHandler.swift
//  ios Task
//
//  Created by INFOSYS on 19/02/20.
//  Copyright © 2020 INFOSYS. All rights reserved.
//

import Foundation


class URLHandler: NSObject {
  
  static let sharedInstance = URLHandler()
  
  func sendRequestToGetAPICall(_ completion: @escaping (_ data:Data?) -> ()) {
    
    guard let url = URL(string: constants.Baseurl) else { return }
    
    URLSession.shared.dataTask(with: url) { (data, res, err) in
      
      if let d = data {
        
        if let value = String(data: d, encoding: String.Encoding.ascii) {
          
          if let jsonData = value.data(using: String.Encoding.utf8) {
            
            completion(jsonData)
          }
        }
        
      }
      }.resume()
  }
}

//
//  URLHandler.swift
//  ios Task
//
//  Created by INFOSYS on 19/02/20.
//  Copyright © 2020 INFOSYS. All rights reserved.
//

import UIKit


class URLHandler: NSObject {
  
  static let sharedInstance = URLHandler()
  
  func sendRequestToGetAPICall(parentController:UIViewController,_ completion: @escaping (_ data:Data?) -> ()) {
    
    if Reachability.isConnectedToNetwork() {
      
      Themes.sharedInstance.showProgresss()
      
      guard let url = URL(string: constants.Baseurl) else { return }
      
      URLSession.shared.dataTask(with: url) { (data, res, err) in
        
        Themes.sharedInstance.dismissProgress()
        
        if let d = data {
          
          if let value = String(data: d, encoding: String.Encoding.ascii) {
            
            if let jsonData = value.data(using: String.Encoding.utf8) {
              
              completion(jsonData)
            }
          }
          
        }
        else {
          
          DispatchQueue.main.async {
            Themes.sharedInstance.showResponseErrorAlert(controller: parentController)
          }
        }
        }.resume()
    }
    else {
      
      Themes.sharedInstance.showNetworkErrorAlert(controller: parentController)

    }
    
    
  }
}

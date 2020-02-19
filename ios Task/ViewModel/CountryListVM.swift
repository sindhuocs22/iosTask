//
//  CountryListVM.swift
//  ios Task
//
//  Created by INFOSYS on 19/02/20.
//  Copyright © 2020 INFOSYS. All rights reserved.
//

import UIKit

//MARK: protocol created
protocol countryListViewModelDelegate : class {
  func reloadData()
}

class countryListVM : NSObject {
  
  var arrayCountryData = [Rows]()
  var delegate: countryListViewModelDelegate?
  
  func sendRequestToGetCountryData() -> Void {
    
    if Reachability.isConnectedToNetwork() {
      
      URLHandler.sharedInstance.sendRequestToGetAPICall { (data) in
        
          if let responseData = data {
            
            let decoder = JSONDecoder()
           // decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedData = try? decoder.decode(countryModel.self, from: responseData)
            print("title-->\(decodedData?.title ?? "test")")
            if let array = decodedData?.rows {
              self.arrayCountryData = array
              print("array--->\(self.arrayCountryData)")
              self.delegate?.reloadData()
            }
            
          }
          else{
            Themes.sharedInstance.showResponseErrorAlert()

          }
      }
    }
    else{
      
    }
}
  
}
//MARK:Tableview DataSource
extension countryListVM : UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return arrayCountryData.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    var cell:CountryListCell? = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? CountryListCell
    cell?.selectionStyle = .none
    if cell == nil {
      cell = CountryListCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Cell")
    }
    
    return cell!
  }
  
}

//MARK:Tableview Delegate

extension countryListVM : UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
    return UITableView.automaticDimension
  }
}

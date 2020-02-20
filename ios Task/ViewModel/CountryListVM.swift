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
  func updateNavigationTitle(title:String)
  
}

class countryListVM : NSObject {
  
  var arrayCountryData : [Rows]?
  var delegate: countryListViewModelDelegate?
  
  func sendRequestToGetCountryData(parentController:UIViewController) -> Void {
    
    //API Call
    
    URLHandler.sharedInstance.sendRequestToGetAPICall(parentController: parentController) { (data) in
      if let responseData = data {
        let decoder = JSONDecoder()
        let decodedData = try? decoder.decode(countryModel.self, from: responseData)
        if let array = decodedData?.rows {
          self.arrayCountryData = array
          print("array-->\(array)")
          DispatchQueue.main.async {
            self.delegate?.updateNavigationTitle(title: decodedData?.title ?? "")
            self.delegate?.reloadData()
          }
        }
        
      }
      else{
        DispatchQueue.main.async {
          Themes.sharedInstance.showResponseErrorAlert(controller: parentController)
        }
      }
    }
    
  }
  
}
//MARK:Tableview DataSource
extension countryListVM : UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    if arrayCountryData?.count ?? 0 > 0 {
      
      tableView.setEmptyMessage(NSLocalizedString("no_data", comment: ""))
    }
    else {
      
      tableView.restore()
    }
    return arrayCountryData?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    var cell:CountryListCell? = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? CountryListCell
    cell?.selectionStyle = .none
    if cell == nil {
      cell = CountryListCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Cell")
    }
    if let object = arrayCountryData?[indexPath.row] {
      let title = "\(object.title ?? "")"
      let description = "\(object.description ?? "")"
      let imageUrl = "\(object.imageHref ?? "")"
      cell?.labelTitle.text = title
      cell?.labelDescription.text = description
      if imageUrl != "" {
        cell?.configureWith(urlString: imageUrl)
      }
      else {
        cell?.imageIcon.image = UIImage.init(named: "placeholder")
        
      }
      
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

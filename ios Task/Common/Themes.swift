//
//  Themes.swift
//  ios Task
//
//  Created by INFOSYS on 19/02/20.
//  Copyright © 2020 INFOSYS. All rights reserved.
//

import Foundation
import SVProgressHUD
import Toast_Swift

class Themes: NSObject {
  
  static let sharedInstance = Themes()
  
  func showNetworkErrorAlert(controller:UIViewController) -> Void {
    
    controller.view.makeToast("No Network Available")
  }
  func showResponseErrorAlert(controller:UIViewController) -> Void {
    
    controller.view.makeToast("Error in Network connection")

  }
  func showProgresss() -> Void {
    
    SVProgressHUD .show()
  }
  func dismissProgress() -> Void {
    
    SVProgressHUD.dismiss()
  }
}

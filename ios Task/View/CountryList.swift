//
//  CountryList.swift
//  ios Task
//
//  Created by INFOSYS on 19/02/20.
//  Copyright © 2020 INFOSYS. All rights reserved.
//

import UIKit

class CountryList: UIViewController,countryListViewModelDelegate {
  
  var tableCountry = UITableView()
  var countryListViewModel = countryListVM()
  var refreshControl = UIRefreshControl()


    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupDesign()
    }
  func setupDesign() -> Void {
    
    countryListViewModel.delegate = self
    self.createSubViews()
    self.setupConstraints()
    tableCountry.register(CountryListCell.self, forCellReuseIdentifier: "Cell")
    refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
    tableCountry.addSubview(refreshControl)
    countryListViewModel.sendRequestToGetCountryData()

  }
  func createSubViews() -> Void {
    
    self.navigationItem.title = "About"
    tableCountry.translatesAutoresizingMaskIntoConstraints = false
    tableCountry.estimatedRowHeight = 80
    tableCountry.separatorStyle = .none
    tableCountry.delegate = countryListViewModel
    tableCountry.dataSource = countryListViewModel
    self.view.addSubview(tableCountry)
  }
  func setupConstraints() -> Void {
    
    tableCountry.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
    tableCountry.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
    tableCountry.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
    tableCountry.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
    
  }
  //MARK:Custom protocols
  func reloadData() {
    self.tableCountry.reloadData()
    self.refreshControl.endRefreshing()

  }
  func updateNavigationTitle(title: String) {
    
    self.navigationItem.title = title
  }
  //MARK:Actions
  @objc func refresh(sender:AnyObject) {
    countryListViewModel.sendRequestToGetCountryData()

  }
}

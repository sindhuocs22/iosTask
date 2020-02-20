//
//  Extensions.swift
//  ios Task
//
//  Created by INFOSYS on 20/02/20.
//  Copyright © 2020 INFOSYS. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
  
  func downloadImage(from imgURL: String) -> URLSessionDataTask? {
    guard let url = URL(string: imgURL) else { return nil }
    
    // set initial image to nil so it doesn't use the image from a reused cell
    image = nil
    
    // check if the image is already in the cache
    if let imageToCache = imageCache.object(forKey: imgURL as NSString) {
      self.image = imageToCache
      return nil
    }
    else {
      self.image = UIImage.init(named: "placeholder")

    }
    
    // download the image asynchronously
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
      if let err = error {
        print(err)
        return
      }
      
      DispatchQueue.main.async {
        // create UIImage
        if let imagedata = data {
          if  let imageToCache = UIImage(data: imagedata) {
            // add image to cache
            imageCache.setObject(imageToCache, forKey: imgURL as NSString)
            self.image = imageToCache
          }
          else {
            self.image = UIImage.init(named: "placeholder")
          }
        }
        
      }
    }
    task.resume()
    return task
  }
  }



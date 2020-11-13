//
//  UIImageView+Extension.swift
//  IssueTracker
//
//  Created by 강병민 on 2020/11/11.
//

import UIKit
let cachedImages = NSCache<NSString, UIImage>()

extension UIImageView {
    func loadImageUsingCache(with urlString:String?) {
        
        //스트링이 nil일때 기본이미지로 변경
        guard let urlString = urlString else {
            self.image = UIImage(systemName: "person.circle")
            return
        }
        
        let activityIndicator = UIActivityIndicatorView()
        addSubview(activityIndicator)
        setup(activityIndicator: activityIndicator)

        self.image = nil
        activityIndicator.startAnimating()

        self.image = nil
    
        if let cacheImage = cachedImages.object(forKey: urlString as NSString)  {
            print("캐시 이미지")
            self.image = cacheImage
            activityIndicator.stopAnimating()
            return
        }
        
        let url = URL(string: urlString)
        let task = URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            
            if error != nil {
                print(error!)
                return
            }
            
            DispatchQueue.main.async {
                if let downloadedImage = UIImage(data:data!){
                    cachedImages.setObject(downloadedImage, forKey: urlString as NSString)
                    self.image = downloadedImage
                    activityIndicator.stopAnimating()
                }
            }
        })
        task.resume()

    }
    
    func setup(activityIndicator : UIActivityIndicatorView){
        activityIndicator.color = .darkGray
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
}

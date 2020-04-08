//
//  Webservice.swift
//  Venturus iOS Test
//
//  Created by Vinícius Brito on 08/04/20.
//  Copyright © 2020 Vinícius Brito. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class Webservice {
    
    /*
     The function below calls the API in order to get the images. It uses a string for searching called searchText which can be anything. E.g. cats, people, fruit. It also has a parameter called page which can can be used for pagionation, infinite scrolling.
     */
    
    class func getData(searchText: String, page: Int, completion: @escaping (Bool, JSON?) -> ()) {
                    
        let url = "https://api.imgur.com/3/gallery/search/?q=\(searchText)"
        
        let headers: HTTPHeaders = [
            "Authorization": "Client-ID 1ceddedc03a5d71"
        ]
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseJSON {
            (response) in
            
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    completion(json.dictionary != nil, json)
                }
            case .failure(let error):
                print("getData Error: \(error)")
            }
        }
        
    }
    
}

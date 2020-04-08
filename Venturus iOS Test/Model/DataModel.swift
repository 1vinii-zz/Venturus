//
//  DataModel.swift
//  Venturus iOS Test
//
//  Created by Vinícius Brito on 08/04/20.
//  Copyright © 2020 Vinícius Brito. All rights reserved.
//

import UIKit
import SwiftyJSON

struct Image {
    var link: String = ""
}

class DataModel: NSObject {
    
    var data = [Image]()
    
    static func parse(json: JSON) -> DataModel {
        let dataModel = DataModel()
        
        for oneElement in json["data"].arrayValue {
            for imgElement in oneElement["images"].arrayValue {
                let img = Image(link: imgElement["link"].stringValue)
                dataModel.data.append(img)
            }
        }
        
        return dataModel
    }
    
}

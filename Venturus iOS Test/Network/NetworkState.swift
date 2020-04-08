//
//  NetworkState.swift
//  Venturus iOS Test
//
//  Created by Vinícius Brito on 08/04/20.
//  Copyright © 2020 Vinícius Brito. All rights reserved.
//

import Foundation
import Alamofire

class NetworkState {
    class func isConnected() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

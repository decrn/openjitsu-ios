//
//  WebService.swift
//  Openjitsu
//
//  Created by Denis Carnier on 13/01/2019.
//  Copyright © 2019 Denis Carnier. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

enum WebService {
    
    private static let baseUrl = "https://gist.githubusercontent.com/decrn/9333d4c9fc9bab3084964d053b708561/raw/"
    private static let headers: HTTPHeaders = [ "Accept": "application/json" ]
    
    /**
     * GET item by id
     * Returns ExploreItem?
     */
    static func getItemById(id: String, completion: @escaping (ExploreItem?) -> Void) {
        let url = URL(string: "\(baseUrl)/position_\(id)")!
        
        Alamofire.request(url, method: .get, headers: headers).responseData { (response) -> Void in
            
            // Check for HTTP 200
            guard response.result.isSuccess else {
                print("Error during request: \(String(describing: response.result.error))")
                
                completion(nil)
                return
            }
            
            let json = JSON(response.result.value!)
            
            completion(ExploreItem.fromJSON(json: json))
        }
    }
    
    /**
     * GET all items (positions and submissions)
     * Returns [ExploreItem]?
     */
    static func getAllItems(completion: @escaping ([ExploreItem]?) -> Void) {
        let url = URL(string: "\(baseUrl)/positions")!
        
        Alamofire.request(url, method: .get, headers: headers).responseData { (response) -> Void in
            
            // Check for HTTP 200
            guard response.result.isSuccess else {
                print("Error during request: \(String(describing: response.result.error))")
                
                completion(nil)
                return
            }
            
            let json = JSON(response.result.value!)
            
            let items = json.map { ExploreItem.fromJSON(json: $1) }
            
            completion(items)
        }
    }
}

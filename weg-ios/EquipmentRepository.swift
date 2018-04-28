//
//  EquipmentRepository.swift
//  weg-ios
//
//  Created by Taylor, James on 4/28/18.
//  Copyright © 2018 James JM Taylor. All rights reserved.
//

import Foundation

class EquipmentRepository {
    static func baseUrl() -> String {return "http://api.jjmtaylor.com:8080/"}
    static func getAllUrl() -> String {return baseUrl() + "getAllCombined"}
    enum method:String {case GET;case POST;case PATCH;case DELETE}
    
    //TODO: Implement last fetch date & coreData
    static var equipment : [Equipment]?
    static func getEquipment(completionHandler: @escaping ([Equipment]?, String?)->()) -> [Equipment]?{
        if equipment != nil { return equipment }
        getEquipmentFromNetwork { (fetchedEquipment, error) in
            equipment = fetchedEquipment
            completionHandler(equipment,error)
        }
        return equipment
    }
    
    private static func getEquipmentFromNetwork(completionHandler: @escaping ([Equipment]?, String?)->()) {
        guard let url = URL(string: getAllUrl()) else {
            completionHandler(nil,"Failed to convert url to strign"); return
        }
        let headers = ["Cache-Control": "no-cache"]
        let request = NSMutableURLRequest(url: url, cachePolicy: .useProtocolCachePolicy,timeoutInterval: 10.0)
        request.httpMethod = method.GET.rawValue
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                completionHandler(nil,error.debugDescription)
            } else {
                let decoder = JSONDecoder()
                guard let jsonData = data else {completionHandler(nil,"Network returned an empty response.");return}
                do {
                    let combined = try decoder.decode(CombinedList.self, from: jsonData)
                    completionHandler(combined.getEquipment(),nil)
                } catch {
                    completionHandler(nil,error.localizedDescription);return
                }
            }
        })
        dataTask.resume()
    }
}

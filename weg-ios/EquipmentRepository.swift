//
//  EquipmentRepository.swift
//  weg-ios
//
//  Created by Taylor, James on 4/28/18.
//  Copyright © 2018 James JM Taylor. All rights reserved.
//

import Foundation
import Kingfisher
import CoreData

class EquipmentRepository {
    static func baseUrl() -> String {return "http://api.jjmtaylor.com:8080/"}
    static func getAllUrl() -> String {return baseUrl() + "getAllCombined"}
    static func app() -> AppDelegate {return UIApplication.shared.delegate as! AppDelegate}
    enum method:String {case GET;case POST;case PATCH;case DELETE}

    static var equipment : [Equipment]?
    
    
    static func getEquipment(completionHandler: @escaping (String?)->()) -> [Equipment]?{
        if equipment != nil { return equipment } //in-memory fetch
        equipment = getEquipmentFromDatabase()
        if equipment != nil { return equipment } //database fetch
        getEquipmentFromNetwork {(error) in completionHandler(error)}
        return nil
    }
    static func getEquipmentFromDatabase() -> [Equipment]? {
        let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            var equipment = [Equipment]()
            guard let gunResults = try moc.fetch(Gun.fetchRequest()) as? [Gun] else {return nil}
            guard let landResults = try moc.fetch(Land.fetchRequest()) as? [Land] else {return nil}
            guard let airResults = try moc.fetch(Air.fetchRequest()) as? [Air] else {return nil}
            guard let seaResults = try moc.fetch(Sea.fetchRequest()) as? [Sea] else {return nil}
            equipment.append(contentsOf: gunResults)
            equipment.append(contentsOf: landResults)
            equipment.append(contentsOf: airResults)
            equipment.append(contentsOf: seaResults)
            return equipment
        } catch {
            print(error)
        }
        return nil
    }
    fileprivate static func getEquipmentFromNetwork(completionHandler: @escaping (String?)->()) {
        guard let url = URL(string: getAllUrl()) else {
            completionHandler("Failed to convert url to string"); return
        }
        let headers = ["Cache-Control": "no-cache"]
        let request = NSMutableURLRequest(url: url, cachePolicy: .useProtocolCachePolicy,timeoutInterval: 10.0)
        request.httpMethod = method.GET.rawValue
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) { completionHandler(error.debugDescription)
            } else {
                do {
                    let context = app().persistentContainer.newBackgroundContext()
                    let decoder = JSONDecoder()
                    decoder.userInfo[CodingUserInfoKey.context!] = context
                    guard let jsonData = data else {
                        completionHandler("Network returned an empty response.")
                        return
                    }
                    let combined = try decoder.decode(CombinedList.self, from: jsonData)
                    try context.save()
                    prefetchImages(combined: combined)
                    completionHandler(nil)
                } catch { completionHandler(error.localizedDescription); return }
            }
        })
        dataTask.resume()
    }
    private static func prefetchImages(combined : CombinedList) {
        var urls = [URL]()
        let e = combined.getEquipment()
        let placeholder = URL(string: EquipmentRepository.baseUrl())!
        let photoUrls = e.map { URL(string: EquipmentRepository.baseUrl() + ($0.photoUrl ?? "")) ?? placeholder }
        let indIconUrls = e.map { URL(string: EquipmentRepository.baseUrl() + ($0.individualIconUrl ?? "")) ?? placeholder }
        let airGroupIconUrls = combined.air.map {
            URL(string: EquipmentRepository.baseUrl() + ($0.groupIconUrl ?? "")) ?? placeholder }
        let landGroupIconUrls = combined.land.map {
            URL(string: EquipmentRepository.baseUrl() + ($0.groupIconUrl ?? "")) ?? placeholder }
        let gunGroupIconUrls = combined.guns.map {
            URL(string: EquipmentRepository.baseUrl() + ($0.groupIconUrl ?? "")) ?? placeholder }
        
        urls.append(contentsOf: photoUrls)
        urls.append(contentsOf: indIconUrls)
        urls.append(contentsOf: airGroupIconUrls)
        urls.append(contentsOf: landGroupIconUrls)
        urls.append(contentsOf: gunGroupIconUrls)
        
        let prefetcher = ImagePrefetcher(urls: urls) {skippedResources, failedResources, completedResources in}
        prefetcher.start()
    }
    static func setImage(_ imageView: UIImageView ,_ url: String?){
        guard let imageUrl = url else {return}
        guard let url = URL(string: EquipmentRepository.baseUrl() + imageUrl) else {return}
        imageView.kf.setImage(with: url, options: nil)
    }
}

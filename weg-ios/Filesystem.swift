//
//  Filesystem.swift
//  weg-ios
//
//  Created by Taylor, James on 7/11/17.
//  Copyright © 2017 Taylor, James. All rights reserved.
//

import UIKit

struct Filesystem {
    static func removeFoldersFromFilename(filename: String) -> String {
        return filename.split(separator: "/").last?.description ?? ""
    }
    
    static func getDirectoryPath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    static func saveImageTo(image: UIImage, fileName: String){
        let fileManager = FileManager.default
        let file = removeFoldersFromFilename(filename: fileName)
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(file)
        let imageData = image.jpegData(compressionQuality: 0.5)
        fileManager.createFile(atPath: paths as String, contents: imageData, attributes: nil)
    }
    
    static func getImageFrom(fileName: String) -> UIImage? {
        let fileManager = FileManager.default
        let file = removeFoldersFromFilename(filename: fileName)
        let imagePath = (self.getDirectoryPath() as NSString).appendingPathComponent(file)
        if fileManager.fileExists(atPath: imagePath){
            return UIImage(named: imagePath)
        }
        print("No Image at \(file)")
        return nil
    }
}

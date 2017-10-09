//
//  AZUserServices.swift
//  AzamMedia
//
//  Created by Farooque on 09/10/17.
//  Copyright © 2017 Quintype. All rights reserved.
//

import Foundation
import SwiftyJSON

typealias ServiceResponseArray = (NSArray?, NSError?,NSInteger) -> Void

final class InstagramUserServices {
    
   class func fetchStoriesList(onCompletion: ServiceResponseArray){
        if let path = Bundle.main.path(forResource: "jsonFile", ofType: "json") {
            do {
                let url = NSURL(fileURLWithPath: path)
                let data = try NSData(contentsOf: url as URL , options : NSData.ReadingOptions.dataReadingMapped)
                let jsonObj = JSON(data: data as Data)
                if jsonObj != JSON.null {
                    let modelArray = mapDataToModel(newsList: jsonObj.arrayObject! as NSArray)
                    onCompletion(modelArray,nil,1)
                } else {
                    print("Could not get json from file, make sure that file contains valid json.")
                }
            } catch let error {
                print(error)
            }
        } else {
            print("Invalid filename/path.")
        }
        
    }
    
    private class func mapDataToModel (newsList : NSArray)-> NSArray {
        
        let modelArray:NSMutableArray=NSMutableArray()
        for userData in newsList {
            let user:InstagramStoriesModel=InstagramStoriesModel(json: userData as! NSDictionary)
            modelArray.add(user)
        }
        
        return modelArray
        
    }
}



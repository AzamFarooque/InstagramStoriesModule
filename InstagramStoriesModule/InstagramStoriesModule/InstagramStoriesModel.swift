//
//  InstagramStoriesModel.swift
//  InstagramStoriesModule
//
//  Created by Farooque on 09/10/17.
//  Copyright © 2017 Quintype. All rights reserved.
//

import Foundation

class InstagramStoriesModel: NSObject {
    
    var images : String?
    var name : String?
    var storiesArray : NSArray?
    
    init(json: NSDictionary) {
        self.images = json["imageURL"] as? String
        self.name = json["name"] as? String
        self.storiesArray = json["storiesInside"] as? NSArray
    }
}

//
//  Post.swift
//  Honest Reviews
//
//  Created by Arjun on 15/11/14.
//  Copyright (c) 2014 Techulus. All rights reserved.
//

import Foundation

class Post {
    var id : Int
    var title : String
    var type : Int
    var price : Int
    var image : String
    
    init(id:Int, title:String, type:Int, price:Int, image: String) {
        self.id = id
        self.title = title
        self.type = type
        self.price = price
        self.image = image
    }
    
    func toJSON() -> String {
        return ""
    }
}
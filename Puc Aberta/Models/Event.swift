//
//  Event.swift
//  Puc Aberta
//
//  Created by Marco Braga on 14/03/18.
//  Copyright © 2018 Marco Braga. All rights reserved.
//

struct Event: Mappable {
    var group: String
    var description: String
    var image: String
    var location: String
    var startTime: String
    var courses: String

    init(mapper: Mapper) {
        self.group = mapper.keyPath("group")
        self.description = mapper.keyPath("description")
        self.location = mapper.keyPath("location")
        self.image = mapper.keyPath("image")
        self.startTime = mapper.keyPath("start_time")
        self.courses = mapper.keyPath("courses")
    }
}

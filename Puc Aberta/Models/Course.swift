//
//  Courses.swift
//  Puc Aberta
//
//  Created by Marco Braga on 19/03/18.
//  Copyright © 2018 Marco Braga. All rights reserved.
//

struct Course: Mappable {
    var course: String?
    var lecture: String?

    init(mapper: Mapper) {
        self.course = mapper.keyPath("curso")
        self.lecture = mapper.keyPath("palestra")
    }
}

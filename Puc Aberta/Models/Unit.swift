//
//  Unit.swift
//  Puc Aberta
//
//  Created by Marco Braga on 05/03/18.
//  Copyright © 2018 Marco Braga. All rights reserved.
//

struct Unit: Mappable {
    var name: String
    var schedule: Schedule
    
    init(mapper: Mapper) {
        self.name = mapper.keyPath("name")
        self.schedule = mapper.keyPath("schedule")
    }
}

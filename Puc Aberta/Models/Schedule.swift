//
//  Schedule.swift
//  Puc Aberta
//
//  Created by Marco Braga on 05/03/18.
//  Copyright © 2018 Marco Braga. All rights reserved.
//

//enum ScheduleType: String {
//    case workshop = "Oficina"
//    case lecture = "Palestra"
//    case mixed = "Misto"
//    case opening = "Abertura"
//    case fair = "Feira"
//}

struct Schedule: Mappable {
    var dates: [Date]
    var type: String
    var description: String
    var events: [Event]
    
    init(mapper: Mapper) {
        let datesStrings: [String] = mapper.keyPath("dates")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        self.dates = datesStrings.map { dateFormatter.date(from: $0)! }
        self.type = mapper.keyPath("type")
        self.description = mapper.keyPath("description")
        self.events = mapper.keyPath("events")
    }
}

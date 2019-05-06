//
//  Lecture.swift
//  Puc Aberta
//
//  Created by Marco Braga on 19/03/18.
//  Copyright © 2018 Marco Braga. All rights reserved.
//

struct Lecture: Mappable {
    var lecture: String?
    var subscriptionStatus: String?
    var unity: String?
    var location: String?
    var date: Date?

    init(mapper: Mapper) {
        self.lecture = mapper.keyPath("palestra")
        self.subscriptionStatus = mapper.keyPath("status_inscricao")
        self.unity = mapper.keyPath("unidade")
        self.location = mapper.keyPath("palestra_espaco")
        guard let dateString: String = mapper.keyPath("palestra_data") else { return }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "BRT")
        self.date = dateFormatter.date(from: dateString)
    }
}

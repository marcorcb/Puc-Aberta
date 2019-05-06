//
//  Building.swift
//  Puc Aberta
//
//  Created by Marco Braga on 09/04/2018.
//  Copyright © 2018 Marco Braga. All rights reserved.
//

import MapKit

enum BuildingType {
    case cafeteria
    case receptive
    case fair
    case auditorium
    case institute
}

class Building: NSObject, MKAnnotation {
    var name: String
    var type: BuildingType
    var desc: String
    var coordinate: CLLocationCoordinate2D
    var title: String?

    init(name: String, type: BuildingType, desc: String, latitude: Double, longitude: Double) {
        self.name = name
        self.type = type
        self.desc = desc
        self.title = name
        self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        super.init()
    }
}

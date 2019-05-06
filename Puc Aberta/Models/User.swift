//
//  User.swift
//  Puc Aberta
//
//  Created by Marco Braga on 19/03/18.
//  Copyright © 2018 Marco Braga. All rights reserved.
//

struct User: Mappable {
    var name: String
    var birthdate: Date
    var cpf: String
    var cnpj: String?
    var school: String?
    var grade: String?
    var lectures: [Lecture]?
    var courses: [Course]?

    init(mapper: Mapper) {
        self.name = mapper.keyPath("inscrito.nome")
        let birthdateString: String = mapper.keyPath("inscrito.nasc")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        self.birthdate = dateFormatter.date(from: birthdateString)!
        self.cpf = mapper.keyPath("inscrito.cpf")
        self.cnpj = mapper.keyPath("inscrito.cnpj")
        self.school = mapper.keyPath("inscrito.escola")
        self.grade = mapper.keyPath("inscrito.serie")
        self.lectures = mapper.keyPath("palestras")
        self.courses = mapper.keyPath("cursos")
    }
}

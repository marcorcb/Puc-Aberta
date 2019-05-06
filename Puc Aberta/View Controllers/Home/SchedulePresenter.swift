//
//  SchedulePresenter.swift
//  Puc Aberta
//
//  Created by Marco Braga on 05/03/18.
//  Copyright © 2018 Marco Braga. All rights reserved.
//

protocol ScheduleProtocol: AnyObject {
    func startLoading()
    func stopLoading()
    func showAlert(message: String)
    func set(units: [Unit])
}

class SchedulePresenter {

    weak private var scheduleView: ScheduleProtocol?

    func attachView(_ view: ScheduleProtocol) {
        self.scheduleView = view
    }

    func setupJSON() {
        if let path = Bundle.main.path(forResource: "events", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let json = json as? JSONDictionary, let array = json["units"] as? JSONArray {
                    let units = array.map { Unit(dictionary: $0) }
                    self.scheduleView?.set(units: units)
                }
            } catch {
                self.scheduleView?.showAlert(message: "Não foi possível carregar os eventos")
            }
        }
    }
}

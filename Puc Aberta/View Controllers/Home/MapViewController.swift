//
//  MapViewController.swift
//  Puc Aberta
//
//  Created by Marco Braga on 03/03/18.
//  Copyright © 2018 Marco Braga. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: BaseViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var cafeteriaSwitch: UISwitch!
    
    // MARK: - Members
    
    private let locationManager = CLLocationManager()
    private var buildings = [Building]()
    var user: User?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNotifications()
        self.setupUI()
    }
    
    // MARK: - Private
    
    func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.showCafeterias(_:)), name: .openOnMap, object: nil)
    }
    
    func setupUI() {
        self.mapView.delegate = self
        self.mapView.showsUserLocation = true
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        let initialLocation = CLLocation(latitude: -19.924542, longitude: -43.993056)
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(initialLocation.coordinate, 1000, 1000)
        self.mapView.setRegion(coordinateRegion, animated: true)
        self.setupCommonAnnotations()
        self.setupUserAnnotations()
        self.mapView.addAnnotations(self.buildings)
        self.mapView.showAnnotations(self.buildings, animated: true)
    }
    
    func setupCommonAnnotations() {
        self.buildings.append(Building(name: "Receptivo", type: .receptive, desc: "", latitude: -19.924542, longitude: -43.993056))
        self.buildings.append(Building(name: "Feira de Cursos", type: .fair, desc: "", latitude: -19.922306, longitude: -43.993384))
    }
    
    func setupUserAnnotations() {
        if let group = UserDefaults.standard.string(forKey: Constants.userLectureKey) {
            self.addAnnotationFrom(group: group)
        }
    }
    
    func addCafeteriaAnnotations() {
        self.buildings.append(Building(name: "Cantina Sinhazinha", type: .cafeteria, desc: "", latitude: -19.923973, longitude: -43.993499))
        self.buildings.append(Building(name: "Trailer de Lanches", type: .cafeteria, desc: "", latitude: -19.923878, longitude: -43.994025))
        self.buildings.append(Building(name: "Cantina Divin Gout", type: .cafeteria, desc: "", latitude: -19.923375, longitude: -43.993772))
        self.buildings.append(Building(name: "Cantina Shuffner", type: .cafeteria, desc: "", latitude: -19.922603, longitude: -43.992991))
        self.buildings.append(Building(name: "Cantina Sodexo", type: .cafeteria, desc: "", latitude: -19.923024, longitude: -43.991382))
    }
    
    func addAnnotationFrom(group: String) {
        switch group {
        case "Grupo A":
            self.buildings.append(Building(name: "Grupo A - 13h30 às 15h30", type: .auditorium, desc: "Teatro João Paulo II", latitude: -19.923171, longitude: -43.991035))
            self.buildings.append(Building(name: "Instituto Politécnico - IPUC", type: .institute, desc: "", latitude: -19.924144, longitude: -43.99296))
        case "Grupo B":
            self.buildings.append(Building(name: "Grupo B - 13h30 às 15h30", type: .auditorium, desc: "Auditório I", latitude: -19.923265, longitude: -43.992904))
            self.buildings.append(Building(name: "Faculdade Mineira de Direito", type: .institute, desc: "", latitude: -19.922958, longitude: -43.992619))
        case "Grupo C":
            self.buildings.append(Building(name: "Grupo C - 13h30 às 15h30", type: .auditorium, desc: "Auditório II", latitude: -19.922958, longitude: -43.992619))
            self.buildings.append(Building(name: "Instituto de Ciências Econômicas e Gerenciais - ICEG", type: .institute, desc: "", latitude: -19.922651, longitude: -43.991751))
        case "Grupo D":
            self.buildings.append(Building(name: "Grupo D - 13h30 às 15h30", type: .auditorium, desc: "Auditório III", latitude: -19.923527, longitude: -43.99335))
            self.buildings.append(Building(name: "Instituto de Ciências Biológicas e da Saúde - ICBS", type: .institute, desc: "", latitude: -19.924401, longitude: -43.994458))
        case "Grupo E":
            self.buildings.append(Building(name: "Grupo E - 13h30 às 15h30", type: .auditorium, desc: "Auditório Multiuso", latitude: -19.923527, longitude: -43.993354))
            self.buildings.append(Building(name: "Instituto de Ciências Humanas - ICH", type: .institute, desc: "", latitude: -19.92308, longitude: -43.992009))
        case "Grupo F":
            self.buildings.append(Building(name: "Grupo F - 16h às 18h", type: .auditorium, desc: "Teatro João Paulo II", latitude: -19.923171, longitude: -43.991035))
            self.buildings.append(Building(name: "Instituto de Ciências Biológicas e da Saúde - ICBS", type: .institute, desc: "", latitude: -19.924401, longitude: -43.994458))
        case "Grupo G":
            self.buildings.append(Building(name: "Grupo G - 16h às 18h", type: .auditorium, desc: "Auditório I", latitude: -19.923265, longitude: -43.992904))
            self.buildings.append(Building(name: "Faculdade de Psicologia", type: .institute, desc: "", latitude: -19.922651, longitude: -43.992424))
        case "Grupo H":
            self.buildings.append(Building(name: "Grupo H - 16h às 18h", type: .auditorium, desc: "Auditório II", latitude: -19.922958, longitude: -43.992619))
            self.buildings.append(Building(name: "Faculdade de Comunicação e Artes", type: .institute, desc: "", latitude: -19.922442, longitude: -43.992665))
        case "Grupo I":
            self.buildings.append(Building(name: "Grupo I - 16h às 18h", type: .auditorium, desc: "Auditório III", latitude: -19.923527, longitude: -43.993354))
            self.buildings.append(Building(name: "Instituto de Ciências Sociais - ICS", type: .institute, desc: "", latitude: -19.925006, longitude: -43.993402))
        case "Grupo J":
            self.buildings.append(Building(name: "Grupo J - 16h às 18h", type: .auditorium, desc: "Auditório Multiuso", latitude: -19.923527, longitude: -43.993354))
            self.buildings.append(Building(name: "Instituto de Ciências Exatas e Informática - ICEI", type: .institute, desc: "", latitude: -19.923045, longitude: -43.994409))
        default:
            break
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func showCafeterias(_ sender: Any) {
        self.buildings = [Building]()
        
        if self.cafeteriaSwitch.isOn {
            self.addCafeteriaAnnotations()
        }
        
        self.setupUserAnnotations()
        self.setupCommonAnnotations()
        self.mapView.removeAnnotations(self.mapView.annotations)
        self.mapView.addAnnotations(self.buildings)
        self.mapView.showAnnotations(self.buildings, animated: true)
    }
}

// MARK: - MKMapViewDelegate

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation { return nil }
        guard let building = annotation as? Building else { return nil }
        let identifier = "CustomAnnotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if let annotationView = annotationView {
            annotationView.annotation = annotation
        } else {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        }
        
        annotationView!.canShowCallout = true
        
        switch(building.type) {
        case .cafeteria:
            annotationView!.image = #imageLiteral(resourceName: "ic_cantinas")
        case .receptive:
            annotationView!.image = #imageLiteral(resourceName: "ic_receptivo")
        case .fair:
            annotationView!.image = #imageLiteral(resourceName: "ic_feira_de_cursos")
        case .auditorium:
            annotationView!.image = #imageLiteral(resourceName: "ic_auditorios")
        case .institute:
            annotationView!.image = #imageLiteral(resourceName: "ic_institutos_e_faculdades")
        }
        
        return annotationView
    }
    
    //    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
    //
    //        let annotation = view.annotation as! Building
    //        nameBuildingTextField.text = annotation.name
    //        buildingTypeLabel.text = annotation.desc
    //
    //
    //        if annotation.type == .canteen {
    //            pinTypeImageView.image = #imageLiteral(resourceName: "ic_cantinas")
    //        } else if annotation.type == .receptive {
    //            pinTypeImageView.image = #imageLiteral(resourceName: "ic_receptivo")
    //        } else if annotation.type == .fair {
    //            pinTypeImageView.image = #imageLiteral(resourceName: "ic_feira_de_cursos")
    //        } else if annotation.type == .auditoriums {
    //            pinTypeImageView.image = #imageLiteral(resourceName: "ic_auditorios")
    //        } else if annotation.type == .institutes {
    //            pinTypeImageView.image = #imageLiteral(resourceName: "ic_institutos_e_faculdades")
    //        }
    //
    //
    //        if viewDetailHeightConstraint.constant == 0 {
    //            viewDetailHeightConstraint.constant = 45;
    //            nameBuildingTextField.isHidden = false
    //            buildingTypeLabel.isHidden = false
    //            pinTypeImageView.isHidden = false
    //
    //            UIView.animate(withDuration: 0.2) {
    //                self.view.layoutIfNeeded()
    //            }
    //        }
    //
    //    }
}

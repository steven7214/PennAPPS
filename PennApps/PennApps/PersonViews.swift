//
//  PersonViews.swift
//  PennApps
//
//  Created by Aditya Kannan on 9/7/19.
//  Copyright © 2019 Helen Dong. All rights reserved.
//

import Foundation
import MapKit

extension MKAnnotationView {
    
    func loadCustomLines(customLines: [String]) {
        let stackView = self.stackView()
        for line in customLines {
            let label = UILabel()
            label.text = line
            stackView.addArrangedSubview(label)
        }
        self.detailCalloutAccessoryView = stackView
    }
    
    
    
    private func stackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        return stackView
    }
}

@available(iOS 11.0, *)
class PersonMarkerView: MKMarkerAnnotationView {
    var information:[String] = []
    let names = ["Steven", "Helen", "Aditya", "Alex", "Audrey", "Melissa", "Andrew", "Michael", "Jennifer", "Jenny", "Elizabeth", "Paul", "Oliver"]
    //name, number, disaster, additional comments
    func generateInformation(title:String) -> [String] {
        let nameIndex = Int.random(in: 0 ..< names.count)
        var number = ""
        for i in 0 ..< 10 {
            if (i == 0) {
                number += "("
            }
            if (i == 3) {
                number += ") "
            }
            if (i == 6) {
                number += "-"
            }
            var num = Int.random(in: 0 ..< 10)
            if ((i == 0 || i == 3) && num == 0) {
                num = Int.random(in: 1 ..< 10)
            }
            number += String(num)
            
        }
        var disaster = ""
        if (title == "AT RISK" || title == "EMERGENCY") {
            disaster = "Hurricane"
        }
        let temp = [names[nameIndex],  number, disaster]
        return temp

    }

    func setInformation(information:[String]) {
        self.information = information
    }
    override var annotation: MKAnnotation? {
        willSet {
            // 1
            guard let person = newValue as? Person else { return }
            canShowCallout = true
            loadCustomLines(customLines: generateInformation(title: person.title!))
            calloutOffset = CGPoint(x: -5, y: 5)
            rightCalloutAccessoryView = UIButton(type: .system)
            // 2
            markerTintColor = person.markerTintColor
            // glyphText = String(person.discipline.first!)
            
        }
    }
}

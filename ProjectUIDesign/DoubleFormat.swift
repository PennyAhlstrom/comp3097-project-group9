//
//  DoubleFormat.swift
//  ProjectUIDesign
//
//  Created by Penny Ahlstrom on 2026-03-04.
//

import Foundation

extension Double {

    var whole: String {
        String(format: "%.0f", self)
    }

    var percent: String {
        String(format: "%.0f%%", self)
    }

    func decimals(_ places: Int) -> String {
        String(format: "%.\(places)f", self)
    }
}

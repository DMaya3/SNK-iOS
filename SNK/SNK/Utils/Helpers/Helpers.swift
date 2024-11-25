//
//  Helpers.swift
//  SNK
//
//  Created by David Jesús Maya Quirós on 20/11/2024.
//

import Foundation

enum Status: String, CaseIterable, Identifiable {
    var id: Self {
        self
    }
    case alive = "Alive"
    case deceased = "Deceased"
    case unknown = "Unknown"
    case none
}

enum Species: String {
    case human = "Human"
    case intelligentTItan = "Intelligent Titan"
    case titanFormerlyHuman = "Titan (formerly human)"
}

protocol ArrayConvertible {
    var id: Int64 { get }
    var name: String? { get }
    var img: Data? { get }
}

protocol Helpers {
    func getArrayObjectById(stringArray: [String], objectArray: [ArrayConvertible]) -> [ArrayConvertible]
}

struct DefaultHelpers: Helpers {
    func getArrayObjectById(stringArray: [String], objectArray: [ArrayConvertible]) -> [ArrayConvertible] {
        var newArrayObject: [ArrayConvertible] = []
        for string in stringArray {
            let components = string.split(separator: "/")
            if let lastComponent = components.last {
                objectArray.forEach { thisObject in
                    if lastComponent == String(thisObject.id) {
                        newArrayObject.append(thisObject)
                    }
                }
            }
        }
        return newArrayObject
    }
}

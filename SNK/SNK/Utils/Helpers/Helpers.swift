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

enum Seasons: String, CaseIterable, Identifiable {
    var id: Self {
        self
    }
    case sOne = "1"
    case sTwo = "2"
    case sThree = "3"
    case sFour = "4"
    case none
}

enum Species: String {
    case human = "Human"
    case intelligentTItan = "Intelligent Titan"
    case titanFormerlyHuman = "Titan (formerly human)"
}

protocol ObjectConvertible {
    var id: Int64 { get }
    var name: String? { get }
    var img: Data? { get }
}

struct DefaultObjectConvertible: ObjectConvertible {
    var id: Int64
    var name: String?
    var img: Data?
    
    init(id: Int64 = 0,
         name: String = "",
         img: Data = Data()) {
        self.id = id
        self.name = name
        self.img = img
    }
}

protocol Helpers {
    func getArrayObjectById(stringArray: [String], objectArray: [ObjectConvertible]) -> [ObjectConvertible]
    func getObjectById(string: String, object: ObjectConvertible) -> ObjectConvertible
}

struct DefaultHelpers: Helpers {
    func getArrayObjectById(stringArray: [String], objectArray: [ObjectConvertible]) -> [ObjectConvertible] {
        var newArrayObject: [ObjectConvertible] = []
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
    
    func getObjectById(string: String, object: ObjectConvertible) -> ObjectConvertible {
        let components = string.split(separator: "/")
        if let lastComponent = components.last, lastComponent == String(object.id) {
            return object
        }
        return DefaultObjectConvertible()
    }
}

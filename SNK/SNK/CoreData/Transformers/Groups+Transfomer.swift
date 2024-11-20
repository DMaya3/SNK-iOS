//
//  Groups+Transfomer.swift
//  SNK
//
//  Created by David Jesús Maya Quirós on 20/11/2024.
//

import Foundation

@objc(GroupsArrayTransformer)
final class GroupsArrayTransformer: NSSecureUnarchiveFromDataTransformer {
    
    override static var allowedTopLevelClasses: [AnyClass] {
        return [NSArray.self, Groups.self]
    }

    override class func allowsReverseTransformation() -> Bool {
        return true
    }

    override class func transformedValueClass() -> AnyClass {
        return NSData.self
    }

    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? Data else { return nil }
        return try? NSKeyedUnarchiver.unarchivedObject(ofClasses: [NSArray.self, Groups.self], from: data)
    }

    override func transformedValue(_ value: Any?) -> Any? {
        guard let groups = value as? [Groups] else { return nil }
        return try? NSKeyedArchiver.archivedData(withRootObject: groups, requiringSecureCoding: true)
    }
}

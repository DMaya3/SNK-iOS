//
//  Relatives+Transformer.swift
//  SNK
//
//  Created by David Jesús Maya Quirós on 20/11/2024.
//

import Foundation

@objc(RelativesArrayTransformer)
final class RelativesArrayTransformer: NSSecureUnarchiveFromDataTransformer {
    
    override static var allowedTopLevelClasses: [AnyClass] {
        return [NSArray.self, Relatives.self]
    }

    override class func allowsReverseTransformation() -> Bool {
        return true
    }

    override class func transformedValueClass() -> AnyClass {
        return NSData.self
    }

    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? Data else { return nil }
        return try? NSKeyedUnarchiver.unarchivedObject(ofClasses: [NSArray.self, Relatives.self], from: data)
    }

    override func transformedValue(_ value: Any?) -> Any? {
        guard let relatives = value as? [Relatives] else { return nil }
        return try? NSKeyedArchiver.archivedData(withRootObject: relatives, requiringSecureCoding: true)
    }
}

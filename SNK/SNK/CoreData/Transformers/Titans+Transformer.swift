//
//  Titans+Transformer.swift
//  SNK
//
//  Created by David Jesús Maya Quirós on 04/01/2025.
//

import Foundation

@objc(TitansArrayTransformer)
final class TitansArrayTransformer: NSSecureUnarchiveFromDataTransformer {
    override static var allowedTopLevelClasses: [AnyClass] {
        return [NSArray.self, Titans.self]
    }

    override class func allowsReverseTransformation() -> Bool {
        return true
    }

    override class func transformedValueClass() -> AnyClass {
        return NSData.self
    }
    
    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? Data else { return nil }
        return try? JSONDecoder().decode(Titans.self, from: data)
    }
}

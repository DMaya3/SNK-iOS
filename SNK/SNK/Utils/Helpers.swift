//
//  Helpers.swift
//  SNK
//
//  Created by David Jesús Maya Quirós on 20/11/2024.
//

import Foundation

protocol ArrayConvertible {
    var id: Int64 { get }
    var name: String? { get }
    var img: Data? { get }
}


private var bundleKey: UInt8 = 0

extension Bundle {
    class func setLanguage(_ language: String) {
        objc_setAssociatedObject(Bundle.main, &bundleKey, Bundle.main, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        guard let path = Bundle.main.path(forResource: language, ofType: "lproj"),
              let bundle = Bundle(path: path) else {
            return
        }
        
        objc_setAssociatedObject(Bundle.main, &bundleKey, bundle, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    static func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        let bundle = objc_getAssociatedObject(Bundle.main, &bundleKey) as? Bundle ?? Bundle.main
        return bundle.localizedString(forKey: key, value: value, table: tableName)
    }
}

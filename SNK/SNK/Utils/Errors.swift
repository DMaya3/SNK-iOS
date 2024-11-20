//
//  Errors.swift
//  SNK
//
//  Created by David Jesús Maya Quirós on 20/11/2024.
//

import Foundation

enum CoreDataErrors: Error {
    case entityNotFound
    case errorSavingContext(_ error: String)
    case errorFetchingDataByContext
}

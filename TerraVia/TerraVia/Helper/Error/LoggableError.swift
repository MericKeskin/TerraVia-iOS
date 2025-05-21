//
//  LoggableError.swift
//  TerraVia
//
//  Created by Meriç Keskin on 21.05.2025.
//

protocol LoggableError: Error {
    var loggableDescription: String { get }
    var underlyingError: Error? { get }
}

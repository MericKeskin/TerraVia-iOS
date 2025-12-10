//
//  Task+.swift
//  TerraVia
//
//  Created by Meriç Keskin on 27.10.2025.
//

extension Task where Success == Never, Failure == Never {
    
    static func sleep(for seconds: Double) async throws {
        try await Self.sleep(for: .seconds(seconds))
    }
}

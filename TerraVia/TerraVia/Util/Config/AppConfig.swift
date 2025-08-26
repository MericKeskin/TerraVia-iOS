//
//  AppConfig.swift
//  TerraVia
//
//  Created by Meriç Keskin on 14.05.2025.
//

import Foundation

enum AppConfig {
    
    case development
    case staging
    case production
    
    static let current: AppConfig = {
#if DEV
        .development
#elseif STAG
        .staging
#else
        .production
#endif
    }()
    
    static let baseURL: String? = {
        Bundle.main.infoDictionary?["BaseURL"] as? String
    }()
}

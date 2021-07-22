//
//  AppKitSceneIdentifier.swift
//  AppKitSceneIdentifier
//
//  Created by Simon Støvring on 22/07/2021.
//

import Foundation

struct AppKitSceneIdentifier: Hashable {
    let rawValue: String

    init(_ rawValue: String) {
        self.rawValue = rawValue
    }
}

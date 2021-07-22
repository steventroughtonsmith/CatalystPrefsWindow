//
//  SceneIdentifier.swift
//  SceneIdentifier
//
//  Created by Simon Støvring on 22/07/2021.
//

import Foundation

struct UIKitSceneIdentifier: Hashable {
    let rawValue: String

    init(_ rawValue: String) {
       self.rawValue = rawValue
    }

    init(_ sceneIdentifier: AppKitSceneIdentifier) {
        rawValue = sceneIdentifier.rawValue.components(separatedBy: "|").last ?? sceneIdentifier.rawValue
    }
}


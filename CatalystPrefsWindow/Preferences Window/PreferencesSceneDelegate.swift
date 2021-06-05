//
//  PreferencesSceneDelegate.swift
//  CatalystPrefsWindow
//
//  Created by Steven Troughton-Smith on 05/06/2021.
//

import UIKit
import SwiftUI

class PreferencesSceneDelegate: UIResponder, UIWindowSceneDelegate {
	
	var window: UIWindow?
	
	
	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		// Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
		// If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
		// This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
		
		
		// Use a UIHostingController as window root view controller.
		if let windowScene = scene as? UIWindowScene {
			
			if let delegate = UIApplication.shared.delegate as? AppDelegate {
				delegate.preferencesSceneSession = session
			}
			
			let window = UIWindow(windowScene: windowScene)

			window.backgroundColor = .secondarySystemBackground
			
			let fixedSize = CGSize(width: UIFloat(640), height: UIFloat(640))
			window.windowScene?.sizeRestrictions?.minimumSize = fixedSize
			window.windowScene?.sizeRestrictions?.maximumSize = fixedSize
			
			self.window = window
			
			buildMacToolbar()
			
			doTab1(self)

			window.makeKeyAndVisible()
		}
	}
	
	func buildMacToolbar() {
		#if targetEnvironment(macCatalyst)
		guard let scene = window?.windowScene else {
			return
		}
		
		if let titleBar = scene.titlebar {
			let toolbar = NSToolbar(identifier: "Preferences")
			toolbar.delegate = self
			
			toolbar.selectedItemIdentifier = ToolbarIdentifiers.tab1
			
			titleBar.toolbarStyle = .preference
			titleBar.toolbar = toolbar
		}
		#endif
	}
}

#if targetEnvironment(macCatalyst)
extension PreferencesSceneDelegate: NSToolbarDelegate {
	
	enum ToolbarIdentifiers {
		static let tab1 = NSToolbarItem.Identifier("com.example.tab1")
		static let tab2 = NSToolbarItem.Identifier("com.example.tab2")
	}
	
	func toolbarIdentifiers() -> [NSToolbarItem.Identifier] {
		return [ToolbarIdentifiers.tab1, ToolbarIdentifiers.tab2]
	}
	
	func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
		return toolbarIdentifiers()
	}
	
	func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
		return toolbarIdentifiers()
	}
	
	func toolbarSelectableItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
		return toolbarIdentifiers()
	}
	
	func toolbar(_ toolbar: NSToolbar, itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier, willBeInsertedIntoToolbar flag: Bool) -> NSToolbarItem? {
		let item = NSToolbarItem(itemIdentifier: itemIdentifier)
		item.target = self
		item.isBordered = false
		
		if itemIdentifier == ToolbarIdentifiers.tab1 {
			
			item.image = UIImage(systemName: "star")
			item.action = #selector(doTab1(_:))
			item.label = "Star"
			return item
		}
		else if itemIdentifier == ToolbarIdentifiers.tab2 {
			item.image = UIImage(systemName: "circle")
			item.action = #selector(doTab2(_:))
			item.label = "Circle"
			return item
		}
		else {
			return NSToolbarItem(itemIdentifier: itemIdentifier)
		}
	}
	
	@objc func doTab1(_ sender:Any) {
		guard let scene = window?.windowScene else {
			return
		}
		
		scene.title = "Star"
		
		let contentView = PreferencesContentView()

		let hostingController = UIHostingController(rootView: contentView)
		hostingController.view.backgroundColor = .clear
		hostingController.view.isOpaque = false
		
		window?.rootViewController = hostingController
	}
	
	@objc func doTab2(_ sender:Any) {
		guard let scene = window?.windowScene else {
			return
		}
		
		scene.title = "Circle"
		
		let contentView = PreferencesContentView2()

		let hostingController = UIHostingController(rootView: contentView)
		hostingController.view.backgroundColor = .clear
		hostingController.view.isOpaque = false
		
		window?.rootViewController = hostingController
	}
}
#endif

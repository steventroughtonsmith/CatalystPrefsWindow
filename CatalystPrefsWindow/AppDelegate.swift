//
//  AppDelegate.swift
//  CatalystPrefsWindow
//
//  Created by Steven Troughton-Smith on 05/06/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

	var preferencesSceneSession:UISceneSession?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		return true
	}

	// MARK: UISceneSession Lifecycle

	func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
		
		if options.userActivities.filter({$0.activityType == "com.example.preferences"}).first != nil {
			return UISceneConfiguration(name: "Preferences", sessionRole: .windowApplication)
		}
		
		if connectingSceneSession.role == .windowApplication {
			return UISceneConfiguration(name: "Main", sessionRole: .windowApplication)
		}
		
		return UISceneConfiguration(name: nil, sessionRole: .windowExternalDisplay)
	}
	
	// MARK: -
	
	override func buildMenu(with builder: UIMenuBuilder) {

		do {
			let command = UIKeyCommand(input: ",", modifierFlags: [.command], action: #selector(showPreferences(_:)))
			
			command.title = NSLocalizedString("Preferences…", comment: "")
			
			let menu = UIMenu(title: "", image: nil, identifier: UIMenu.Identifier("MENU_FILE_OPEN"), options: .displayInline, children: [command])
			builder.insertSibling(menu, afterMenu: .about)
		}
		
		super.buildMenu(with: builder)
	}
	
	@objc func showPreferences(_ sender:Any) {
		let userActivity = NSUserActivity(activityType: "com.example.preferences")
		UIApplication.shared.requestSceneSessionActivation(preferencesSceneSession, userActivity: userActivity, options: nil, errorHandler: nil)
	}
}


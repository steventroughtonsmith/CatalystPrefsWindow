//
//  AppDelegate.swift
//  CatalystPrefsWindow
//
//  Created by Steven Troughton-Smith on 05/06/2021.
//

import UIKit

#if targetEnvironment(macCatalyst)

extension NSObject {
	@objc public func _marzipan_setupWindow(_ sender:Any) {
		
	}
	
	@objc public func configurePreferencesWindowForSceneIdentifier(_ sceneIdentifier:String) {
   
	}
}
#endif

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

	var preferencesSceneSession:UISceneSession?
	
	#if targetEnvironment(macCatalyst)
	
	static var appKitController:NSObject?
	
	class func loadAppKitIntegrationFramework() {
		
		if let frameworksPath = Bundle.main.privateFrameworksPath {
			let bundlePath = "\(frameworksPath)/AppKitIntegration.framework"
			do {
				try Bundle(path: bundlePath)?.loadAndReturnError()
				
				let bundle = Bundle(path: bundlePath)!
				NSLog("[APPKIT BUNDLE] Loaded Successfully")
				
				if let appKitControllerClass = bundle.classNamed("AppKitIntegration.AppKitController") as? NSObject.Type {
					appKitController = appKitControllerClass.init()
					
					NotificationCenter.default.addObserver(appKitController as Any, selector: #selector(_marzipan_setupWindow(_:)), name: NSNotification.Name("UISBHSDidCreateWindowForSceneNotification"), object: nil)
				}
			}
			catch {
				NSLog("[APPKIT BUNDLE] Error loading: \(error)")
			}
		}
	}
	#endif

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		
		#if targetEnvironment(macCatalyst)
		AppDelegate.loadAppKitIntegrationFramework()
		#endif
		
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

